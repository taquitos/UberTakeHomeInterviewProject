//
//  UPProductTableViewCell.h
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

@import UIKit;

FOUNDATION_EXPORT NSString * const UPProductTableViewCellReuseID;
FOUNDATION_EXPORT NSString * const UPProductTableViewCellNibName;

@class UPFareViewModel;

@interface UPProductTableViewCell : UITableViewCell

@property (nonatomic) UPFareViewModel *cellViewModel;

@end
