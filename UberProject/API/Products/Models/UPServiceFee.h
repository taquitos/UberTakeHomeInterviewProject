//
//  UPServiceFee.h
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

@import CoreGraphics.CGBase;
@import Foundation;

@interface UPServiceFee : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, readonly) CGFloat fee;

@end
