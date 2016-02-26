//
//  UPUberAPI.m
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

#import "UPUberAPI.h"
#import "UPUberAPIAuthenticationInfo.h"

@interface UPUberAPI ()

@property (nonatomic, readonly, nonnull) UPUberAPIAuthenticationInfo *apiAuthenticationInfo;

@end

@implementation UPUberAPI

- (instancetype)initWithAPIAuthenticationInfo:(UPUberAPIAuthenticationInfo *)authenticationInfo
{
    if (self = [super init]) {
        _apiAuthenticationInfo = authenticationInfo;
    }
    return self;
}

- (NSString *)apiInfo
{
    return self.apiAuthenticationInfo.secret;
}

- (NSDictionary *)serverAuthorizationHeaders
{
    return @{ @"Authorization": [NSString stringWithFormat:@"Token %@", self.apiAuthenticationInfo.serverToken] };
}

@end
