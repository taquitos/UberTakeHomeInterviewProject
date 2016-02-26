//
//  UPFaresTableViewController.m
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

#import "UPFareEstimate.h"
#import "UPFaresTableViewController.h"
#import "UPFareViewModel.h"
#import "UPProductTableViewCell.h"

@interface UPFaresTableViewController ()

@property (nonatomic, copy, readonly) NSArray<UPFareEstimate *> *fares;

@end

@implementation UPFaresTableViewController

- (instancetype)initWithFares:(NSArray<UPFareEstimate *> *)fares
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        _fares = [fares copy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:UPProductTableViewCellNibName bundle:nil] forCellReuseIdentifier:UPProductTableViewCellReuseID];
    self.tableView.allowsSelection = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fares.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UPProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UPProductTableViewCellReuseID forIndexPath:indexPath];
    UPFareEstimate *fare = self.fares[indexPath.row];

    cell.cellViewModel = [[UPFareViewModel alloc] initWithTitle:fare.displayName time:fare.duration cost:fare.estimate];
    return cell;
}

@end
