//
//  UIButton+BlockBased.h
//
//  Created by Joshua Liebowitz on 9/26/15.
//  Copyright © 2015 Joshua Liebowitz. All rights reserved.
//

@import UIKit;

typedef void(^ButtonCallback)(void);

@interface UIButton (BlockBased)

- (void)setCallback:(ButtonCallback)callback;

@end
