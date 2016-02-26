//
//  NSError+UberProject.m
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

#import "NSError+UberProject.h"

NSString * const kUberProjectErrorDomain = @"com.mydoghatestechnology.UberProject";
NSString * const kUberProjectErrorReasonKey = @"UberProjectErrorReason";
NSString * const kUberProjectNetworkErrorObjectKey = @"UberProjectNetworkErrorObject";

static const NSInteger kUberProjectNetworkingErrorCode = 400;

@implementation NSError(UberProject)

+ (NSError *)up_networkingErrorWithStatus:(UPHTTPStatus)status serverError:(UPServerError *)serverError
{
    NSMutableDictionary *info = [NSMutableDictionary new];
    if (serverError) {
        info[kUberProjectNetworkErrorObjectKey] = serverError;
    }
    info[kUberProjectErrorReasonKey] = @(status);

    return [[NSError alloc] initWithDomain:kUberProjectErrorDomain code:kUberProjectNetworkingErrorCode userInfo:info];
}

+ (NSError *)up_networkingErrorWithStatus:(UPHTTPStatus)status
{
    return [self up_networkingErrorWithStatus:status serverError:nil];
}

- (BOOL)isUberProjectError
{
    return [self.domain isEqualToString:kUberProjectErrorDomain];
}

- (BOOL)isUberNetworkingError
{
    return [self isUberNetworkingError] && (self.code == kUberProjectNetworkingErrorCode);
}

- (UPServerError *)uberServerError
{
    return self.userInfo[kUberProjectNetworkErrorObjectKey];
}

@end
