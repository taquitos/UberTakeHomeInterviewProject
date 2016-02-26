//
//  UPSeeFaresButton.m
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

#import "UIButton+BlockBased.h"
#import "UIView+JLAdditions.h"
#import "UPSeeFaresButton.h"

@implementation UPSeeFaresButton

- (instancetype)initWithFrame:(CGRect)frame clickHandler:(UPSeeFaresButtonClick)clickHandler
{
    if (self = [super initWithFrame:frame]) {
        _faresClickBlock = [clickHandler copy];
        _faresState = UPSeeFaresButtonStateNoFaresAvailable;
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:.85];
        self.contentEdgeInsets = UIEdgeInsetsMake(10, 15, 10, 15);
        self.layer.borderWidth = [UIView jl_onePixelForMainScreen];
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.cornerRadius = 5.0;

        // default to yes
        [self setTextForState:UPSeeFaresButtonStateNoFaresAvailable];
        __weak typeof(self) weakSelf = self;
        [self setCallback:^{
            typeof(self)strongSelf = weakSelf;
            if (strongSelf && strongSelf.faresClickBlock) {
                strongSelf.faresClickBlock(strongSelf.faresState);
            }
        }];
    }
    return self;
}

- (void)setTextForState:(UPSeeFaresButtonState)faresState
{
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleCallout];
    UIColor *textColor = [UIColor blackColor];
    NSDictionary *attrs = @{ NSForegroundColorAttributeName : textColor,
                             NSFontAttributeName : font,
                             NSTextEffectAttributeName : NSTextEffectLetterpressStyle};
    NSAttributedString *attrString;
    switch (faresState) {
        case UPSeeFaresButtonStateFaresAvailable: {
            attrString = [[NSAttributedString alloc] initWithString:@"See available fares." attributes:attrs];
            break;
        }
        case UPSeeFaresButtonStateNoFaresAvailable: {
            attrString = [[NSAttributedString alloc] initWithString:@"No fares available." attributes:attrs];
            break;
        }
    }
    [self setAttributedTitle:attrString forState:UIControlStateNormal];
    [self sizeToFit];
}

- (void)setFaresState:(UPSeeFaresButtonState)faresState
{
    _faresState = faresState;
    [self setTextForState:faresState];
}

@end
