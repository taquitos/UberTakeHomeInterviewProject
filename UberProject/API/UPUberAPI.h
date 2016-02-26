//
//  UPUberAPI.h
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

@import Foundation;

@class UPUberAPIAuthenticationInfo;

NS_ASSUME_NONNULL_BEGIN

@interface UPUberAPI : NSObject

- (instancetype)initWithAPIAuthenticationInfo:(UPUberAPIAuthenticationInfo *)authenticationInfo;
- (NSDictionary *)serverAuthorizationHeaders;
- (NSString *)apiInfo;

NS_ASSUME_NONNULL_END

@end
