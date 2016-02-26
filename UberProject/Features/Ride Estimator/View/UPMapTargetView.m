//
//  UPMapTargetView.m
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

#import "UIView+JLAdditions.h"
#import "UPMapTargetView.h"

static const CGSize targetSize = {.height = 42.0, .width = 42.0};

@implementation UPMapTargetView

- (instancetype)init
{
    return [self initWithFrame:CGRectMake(0, 0, targetSize.width, targetSize.height)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), targetSize.width, targetSize.height)]) {
        [self drawView];
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return targetSize;
}

- (void)drawView
{
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.cornerRadius = targetSize.width/2.0;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.15];

    UIView *pinView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4.0, 4.0)];
    pinView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    pinView.layer.borderWidth = 1.0;
    pinView.layer.cornerRadius = 4.0/2.0;
    pinView.clipsToBounds = YES;
    pinView.backgroundColor = [UIColor darkGrayColor];

    CGRect pinViewFrame = [self jl_frameCenteredFrameForChildBounds:pinView.frame];
    pinView.frame = pinViewFrame;
    [self addSubview:pinView];
}

@end
