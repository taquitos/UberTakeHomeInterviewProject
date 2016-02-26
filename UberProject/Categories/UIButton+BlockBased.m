//
//  UIButton+BlockBased.m
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2015 Joshua Liebowitz. All rights reserved.
//

#import <objc/runtime.h> //ObjcFunTime!
#import "UIButton+BlockBased.h"

@implementation UIButton (BlockBased)

- (void)setCallback:(ButtonCallback)callback
{
    objc_setAssociatedObject(self, @"callback", callback, OBJC_ASSOCIATION_COPY);

    [self removeTarget:self action:@selector(performCallback) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(performCallback) forControlEvents:UIControlEventTouchUpInside];
}

- (void)performCallback
{
    ButtonCallback callback = objc_getAssociatedObject(self, @"callback");
    if (callback) {
        callback();
    }
}


@end
