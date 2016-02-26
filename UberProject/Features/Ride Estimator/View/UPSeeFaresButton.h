//
//  UPSeeFaresButton.h
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSUInteger, UPSeeFaresButtonState) {
    UPSeeFaresButtonStateFaresAvailable,
    UPSeeFaresButtonStateNoFaresAvailable
};

NS_ASSUME_NONNULL_BEGIN

typedef void(^UPSeeFaresButtonClick)(UPSeeFaresButtonState state);

@interface UPSeeFaresButton : UIButton

@property (nonatomic, copy) UPSeeFaresButtonClick faresClickBlock;
@property (nonatomic) UPSeeFaresButtonState faresState;

- (instancetype)initWithFrame:(CGRect)frame clickHandler:(UPSeeFaresButtonClick)clickHandler NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

NS_ASSUME_NONNULL_END

@end
