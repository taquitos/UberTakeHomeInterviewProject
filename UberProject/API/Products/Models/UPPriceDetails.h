//
//  UPPriceDetails.h
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

@import CoreGraphics.CGBase;
@import Foundation;

@interface UPPriceDetails : NSObject

@property (nonatomic, readonly) CGFloat base;
@property (nonatomic, readonly) CGFloat minimum;
@property (nonatomic, readonly) CGFloat costPerMinute;
@property (nonatomic, readonly) CGFloat costPerDistance;
@property (nonatomic, copy, readonly) NSString *distanceUnit;
@property (nonatomic, readonly) CGFloat cancellationFee;
@property (nonatomic, copy, readonly) NSString *currencyCode;
@property (nonatomic, copy, readonly) NSArray *serviceFees;

@end
