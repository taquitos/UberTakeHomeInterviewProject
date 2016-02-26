//
//  UPFareViewModel.m
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

#import "UPFareViewModel.h"

@implementation UPFareViewModel

- (instancetype)initWithTitle:(NSString *)title time:(NSInteger)time cost:(NSString *)cost
{
    if (self = [super init]) {
        NSInteger minutes = 1;
        if (time > 60) {
            minutes = time / 60;
        }
        NSString *minuteText = (minutes != 1)? @"minutes": @"minute";
        _time = [NSString stringWithFormat:@"%li %@", minutes, minuteText];
        _cost = [cost copy];
        _title = [title copy];
    }
    return self;
}

@end
