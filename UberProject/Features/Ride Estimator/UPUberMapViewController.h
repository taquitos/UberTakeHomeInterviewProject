//
//  ViewController.h
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

@import UIKit;

@class UPUberAPI;

@interface UPUberMapViewController : UIViewController

NS_ASSUME_NONNULL_BEGIN
- (instancetype)initWithUberAPI:(UPUberAPI *)uberAPI NS_DESIGNATED_INITIALIZER;

// We're not going to allow XIB instantiation, hydration through XIB, or through init... just our api
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
NS_ASSUME_NONNULL_END

@end

