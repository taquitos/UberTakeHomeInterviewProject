//
//  UPNetworkRequest.m
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

#import <CoreGraphics/CGBase.h>
#import "JLObjectDeserializer.h"
#import "JLObjectSerializer.h"
#import "NSDictionary+QueryString.h"
#import "NSError+UberProject.h"
#import "NSString+JLAdditions.h"
#import "UPNetworkRequest.h"
#import "UPNetworkRequest+Status.h"
#import "UPServerError.h"

static const CGFloat kRequestTimeoutSeconds = 15.0; // Being generous here, maybe there's some real janky networking, ideally, we'd examin what the network topology was and make a decision about timeouts based on that. We could also make some safe guesses depending on the country/city (slower in rural India, faster in London, UK)

static NSString * const kRequestRootURLString = @"https://api.uber.com";
static NSString * const kRequestContentLengthKey = @"Content-Length";
static NSString * const kRequestContentTypeKey = @"Content-Type";
static NSString * const kRequestContentTypeValue = @"application/json; charset=utf-8";
static NSString * const kRequestAcceptKey = @"Accept";
static NSString * const kRequestAcceptValue = @"application/json";

@interface UPNetworkRequest () <NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

@property (nonatomic) NSURLSession *session;
@property (nonatomic) NSURLSessionTask *task;
@property (nonatomic, nullable) NSMutableData *responseData;
@property (nonatomic, copy, nullable) NSData *dataToSend;
@property (nonatomic, copy, nonnull) NSDictionary *authenticationHeaders;
@property (nonatomic, copy, nullable) APICompletionBlock completion;
@property (nonatomic, nullable) Class expectedReturnClass; // What are we going to deserialize to?

@end

@implementation UPNetworkRequest

- (instancetype)initWithData:(NSData *)data queryParams:(NSDictionary *)queryParams apiRoot:(NSString *)apiRoot endpoint:(NSString *)endpoint requestVerb:(UPNetworkRequestVerb)verb authHeaders:(NSDictionary *)authHeaders completion:(APICompletionBlock)completion
{
    if (self = [super init]) {
        _apiRoot = [apiRoot copy];
        _completion = [completion copy];
        _verb = verb;
        _responseData = [[NSMutableData alloc] init];
        _authenticationHeaders = [authHeaders copy];

        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForRequest = kRequestTimeoutSeconds;
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];

        NSURL *url;
        if (queryParams) {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@", _apiRoot, endpoint, [queryParams queryStringValue]]];
        } else {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", _apiRoot, endpoint]];
        }

        NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];

        if (data) {
            _dataToSend = [data copy];
            [mutableRequest addValue:[NSString stringWithFormat:@"%lu", (unsigned long)data.length] forHTTPHeaderField:kRequestContentLengthKey];
        }

        [mutableRequest addValue:kRequestContentTypeValue forHTTPHeaderField:kRequestContentTypeKey];
        [mutableRequest addValue:kRequestAcceptValue forHTTPHeaderField:kRequestAcceptKey];
        [self.authenticationHeaders enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop) {
            [mutableRequest addValue:value forHTTPHeaderField:key];
        }];

        mutableRequest.HTTPBody = data;//ignored sometimes
        switch (verb) {
            case UPNetworkRequestVerbGET: {
                mutableRequest.HTTPMethod = @"GET";
                break;
            }
            case UPNetworkRequestVerbDELETE: {
                mutableRequest.HTTPMethod = @"DELETE";
                break;
            }
            case UPNetworkRequestVerbPOST: {
                mutableRequest.HTTPMethod = @"POST";
                break;
            }
            case UPNetworkRequestVerbPUT: {
                mutableRequest.HTTPMethod = @"PUT";
                break;
            }
            case UPNetworkRequestVerbOPTIONS: {
                mutableRequest.HTTPMethod = @"OPTIONS";
                break;
            }
            case UPNetworkRequestVerbPATCH: {
                mutableRequest.HTTPMethod = @"PATCH";
                break;
            }
        }
        _task = [self.session dataTaskWithRequest:mutableRequest];
    }
    return self;
}

- (instancetype)initWithData:(NSData *)data endpoint:(NSString *)endpoint requestVerb:(UPNetworkRequestVerb)verb authHeaders:(NSDictionary *)authHeaders completion:(APICompletionBlock)completion
{
    return [self initWithData:data queryParams:nil apiRoot:kRequestRootURLString endpoint:endpoint requestVerb:verb authHeaders:authHeaders completion:completion];
}

+ (UPNetworkRequest *)requestForVerb:(UPNetworkRequestVerb)verb endpoint:(NSString *)endpoint authHeaders:(NSDictionary *)authHeaders completion:(APICompletionBlock)completion
{
    return [UPNetworkRequest requestForVerb:verb data:nil endpoint:endpoint authHeaders:authHeaders completion:completion];
}

+ (UPNetworkRequest *)requestForVerb:(UPNetworkRequestVerb)verb data:(NSData *)data endpoint:(NSString *)endpoint authHeaders:(NSDictionary *)authHeaders completion:(APICompletionBlock)completion
{
    UPNetworkRequest *request = [[UPNetworkRequest alloc] initWithData:data endpoint:endpoint requestVerb:verb authHeaders:authHeaders completion:completion];
    return request;
}

+ (UPNetworkRequest *)requestForVerb:(UPNetworkRequestVerb)verb object:(id<NSObject>)object endpoint:(NSString *)endpoint authHeaders:(NSDictionary *)authHeaders completion:(APICompletionBlock)completion
{
    return [[self class] requestForVerb:verb object:object queryParams:nil endpoint:endpoint authHeaders:authHeaders completion:completion];
}

+ (UPNetworkRequest *)requestForVerb:(UPNetworkRequestVerb)verb object:(id<NSObject>)object queryParams:(NSDictionary *)queryParams endpoint:(NSString *)endpoint authHeaders:(NSDictionary *)authHeaders completion:(APICompletionBlock)completion
{
    JLObjectSerializer *serializer;
    NSData *bodyData;
    if (object) {
        serializer = [[JLObjectSerializer alloc] init];
        bodyData = [serializer dataWithObject:object];
    }
    UPNetworkRequest *request = [[UPNetworkRequest alloc] initWithData:bodyData queryParams:queryParams apiRoot:kRequestRootURLString endpoint:endpoint requestVerb:verb authHeaders:authHeaders completion:completion];
    return request;
}

- (void)start
{
    // Ideally I'd check for network status and decide whether or not to fire the request or immediately fail with a custom NSError that could be bubbled up
    [self.task resume];
}

- (void)cancel
{
    [self.task cancel];
    [self didCompleteRequest:nil error:nil];
}

- (void)startWithExpectedResponseObjectClass:(Class)class
{
    self.expectedReturnClass = class;
    [self start];
}

- (BOOL)processResponse:(NSURLResponse *)response responseData:(NSData *)responseData foundationError:(NSError *)foundationError error:(NSError * __autoreleasing *)error
{
    if (foundationError) {
        if ([foundationError.domain isEqualToString:NSURLErrorDomain]){
            if (error != NULL) *error = foundationError;
            return NO;
        }
    }
    if (![response isKindOfClass:[NSHTTPURLResponse class]]) {
        return NO;
    }
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    UPHTTPStatus responseStatusCode = (UPHTTPStatus)[httpResponse statusCode];
    BOOL success = YES;
    switch (responseStatusCode) {
        case UPHTTPStatusOk:
        case UPHTTPStatusCreated: {
            break;
        }
        case UPHTTPStatusNotFound:
        case UPHTTPStatusServerError:
        case UPHTTPStatusBadRequest:
        case UPHTTPStatusConflict:
        case UPHTTPStatusForbidden:
        case UPHTTPStatusRateLimit:
        case UPHTTPStatusUnauthorized:
        case UPHTTPStatusUnacceptableContentType:
        case UPHTTPStatusInvalidRequest: {
            if (error != NULL) *error = [self errorFromData:responseData statusCode:responseStatusCode];
            NSLog(@"Request error:%@", *error);
            success = NO;
            break;
        }
        default: {
            NSAssert(false, @"got return status: %ld from url:%@\nand don't know what to do", (long)responseStatusCode, response.URL);
            break;
        }
    }

    return success;
}

- (void)didCompleteRequest:(id<NSObject>)object error:(NSError *)error
{
    @synchronized(self) {
        if (self.completion) {
            self.completion(object, error);
            self.completion = nil;
        }
        [self.session finishTasksAndInvalidate];
    }
}

#pragma mark - Error handling

- (NSError *)errorFromData:(NSData *)responseData statusCode:(UPHTTPStatus)code
{
    UPServerError *errorData = [self errorResponseFromServerErrorData:responseData];
    return [NSError up_networkingErrorWithStatus:code serverError:errorData];
}

- (UPServerError *)errorResponseFromServerErrorData:(NSData *)errorData
{
    UPServerError *serverResponse = nil;
    if (errorData) {
        JLObjectMapper *mapper = [[JLObjectMapper alloc] init];
        NSError *mappingError;
        serverResponse = [mapper objectWithString:[[NSString alloc] initWithData:errorData encoding:NSUTF8StringEncoding] targetClass:[UPServerError class] error:&mappingError];
    }
    return serverResponse;
}

#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

#pragma mark - NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    NSError *wrappedError;
    BOOL success = [self processResponse:task.response responseData:self.responseData foundationError:error error:&wrappedError];
    if (!success && wrappedError.code == UPHTTPStatusUnauthorized) {
        // present login?
        return;
    }
    NSError *returnError = wrappedError;
    if (self.completion) {
        id jsonObject;
        if (success && self.responseData && !returnError) {
            JLObjectDeserializer *deserializer = [[JLObjectDeserializer alloc] init];
            NSError *deserializationError;
            jsonObject = [deserializer objectWithData:self.responseData targetClass:self.expectedReturnClass error:&deserializationError];
            returnError = deserializationError;
        }
        [self didCompleteRequest:jsonObject error:returnError];
    }
}

@end
