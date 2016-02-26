//
//  UPUberAPIAuthenticationInfo.h
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

@import Foundation;

@interface UPUberAPIAuthenticationInfo : NSObject

NS_ASSUME_NONNULL_BEGIN

@property (nonatomic, copy, readonly) NSString *clientID;
@property (nonatomic, copy, readonly) NSString *secret;
@property (nonatomic, copy, readonly) NSString *serverToken;

+ (instancetype)defaultAuthenticationInfo;
- (instancetype)initWithClientID:(NSString *)clientID secret:(NSString *)secret serverToken:(NSString *)serverToken NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

NS_ASSUME_NONNULL_END

@end
