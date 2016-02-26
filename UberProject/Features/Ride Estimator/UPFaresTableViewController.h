//
//  UPFaresTableViewController.h
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

@import UIKit;

@class UPFareEstimate;

@interface UPFaresTableViewController : UITableViewController

NS_ASSUME_NONNULL_BEGIN

- (instancetype)initWithFares:(NSArray<UPFareEstimate *> *)fares NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithStyle:(UITableViewStyle)style NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

NS_ASSUME_NONNULL_END
@end
