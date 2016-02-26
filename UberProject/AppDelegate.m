//
//  AppDelegate.m
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

#import "AppDelegate.h"
#import "UPUberAPI.h"
#import "UPUberAPIAuthenticationInfo.h"
#import "UPUberMapViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] init];

    // Injection AWWWW YEAHHH
    UPUberAPIAuthenticationInfo *apiAuthInfo = [UPUberAPIAuthenticationInfo defaultAuthenticationInfo];
    UPUberAPI *uberAPI = [[UPUberAPI alloc] initWithAPIAuthenticationInfo:apiAuthInfo];

    self.window.rootViewController = [[UPUberMapViewController alloc] initWithUberAPI:uberAPI];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
