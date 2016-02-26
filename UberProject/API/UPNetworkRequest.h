//
//  UPNetworkRequest.h
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

@import Foundation;

typedef NS_ENUM(NSInteger, UPNetworkRequestVerb) {
    UPNetworkRequestVerbGET,
    UPNetworkRequestVerbPOST,
    UPNetworkRequestVerbPUT,
    UPNetworkRequestVerbDELETE,
    UPNetworkRequestVerbOPTIONS,
    UPNetworkRequestVerbPATCH
};

NS_ASSUME_NONNULL_BEGIN

typedef void(^APICompletionBlock)(id<NSObject> _Nullable jsonObject, NSError * _Nullable error);

@interface UPNetworkRequest : NSObject

@property (nonatomic, readonly) NSHTTPURLResponse *response;
@property (nonatomic, readonly) UPNetworkRequestVerb verb;
@property (nonatomic, readonly) NSString *apiRoot;

+ (UPNetworkRequest *)requestForVerb:(UPNetworkRequestVerb)verb endpoint:(NSString *)endpoint authHeaders:(NSDictionary *)authHeaders completion:(APICompletionBlock)completion;
+ (UPNetworkRequest *)requestForVerb:(UPNetworkRequestVerb)verb data:(NSData * _Nullable)data endpoint:(NSString *)endpoint authHeaders:(NSDictionary *)authHeaders completion:(APICompletionBlock)completion;
+ (UPNetworkRequest *)requestForVerb:(UPNetworkRequestVerb)verb object:(id<NSObject> _Nullable)object endpoint:(NSString *)endpoint authHeaders:(NSDictionary *)authHeaders completion:(APICompletionBlock)completion;
+ (UPNetworkRequest *)requestForVerb:(UPNetworkRequestVerb)verb object:(id<NSObject> _Nullable)object queryParams:(NSDictionary * _Nullable)queryParams endpoint:(NSString *)endpoint authHeaders:(NSDictionary *)authHeaders completion:(APICompletionBlock)completion;

- (void)cancel;
- (void)start;
- (void)startWithExpectedResponseObjectClass:(Class)class;

NS_ASSUME_NONNULL_END
@end
