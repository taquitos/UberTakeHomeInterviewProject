//
//  UPUberAPIAuthenticationInfo.m
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

#import "UPUberAPIAuthenticationInfo.h"

// ideally we would obfuscate these a little more, but that is out of scope for this project
// you could have an api that accepts username/password and returns this information, then you could
// store it in the keychain so you never have to distribute this stuff. 

static NSString * const kUberAPIClientID = @"uoXQkWXlMV5B1oso1xaaKK7v6cb9vvaT";
static NSString * const kUberAPISecret = @"-FmJyJnJ0We68qU5wZQqF_E_obOdRUG35vGtqrNS";
static NSString * const kUberAPIServerToken = @"_Zmah7s9tbnCCGElHwZugLca7OP2gSV44lm_rIW9";

@implementation UPUberAPIAuthenticationInfo

+ (instancetype)defaultAuthenticationInfo
{
    return [[UPUberAPIAuthenticationInfo alloc] initWithClientID:kUberAPIClientID secret:kUberAPISecret serverToken:kUberAPIServerToken];
}

- (instancetype)initWithClientID:(NSString *)clientID secret:(NSString *)secret serverToken:(NSString *)serverToken
{
    if (self = [super init]) {
        _clientID = [clientID copy];
        _secret = [secret copy];
        _serverToken = [serverToken copy];
    }
    return self;
}

@end
