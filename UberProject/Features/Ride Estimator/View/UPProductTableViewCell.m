//
//  UPProductTableViewCell.m
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

#import "UPFareViewModel.h"
#import "UPProductTableViewCell.h"

NSString * const UPProductTableViewCellReuseID = @"UPProductTableViewCell";
NSString * const UPProductTableViewCellNibName = @"UPProductTableViewCell";

@interface UPProductTableViewCell()

@property (strong, nonatomic) IBOutlet UILabel *productTitle;
@property (strong, nonatomic) IBOutlet UILabel *timeTitle;
@property (strong, nonatomic) IBOutlet UILabel *costTitle;

@end

@implementation UPProductTableViewCell

- (void)setCellViewModel:(UPFareViewModel *)cellViewModel
{
    _cellViewModel = cellViewModel;
    self.productTitle.text = _cellViewModel.title;
    self.costTitle.text = _cellViewModel.cost;
    self.timeTitle.text = _cellViewModel.time;
}

- (void)awakeFromNib
{

}


@end
