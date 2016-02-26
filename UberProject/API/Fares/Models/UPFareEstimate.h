//
//  UPFareEstimate.h
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

@import CoreGraphics.CGBase;
@import Foundation;

// https://developer.uber.com/docs/v1-estimates-price
@interface UPFareEstimate : NSObject

@property (nonatomic, copy, readonly) NSString *productID;
@property (nonatomic, copy, readonly) NSString *currencyCode; //ISO 4217 currency code.
@property (nonatomic, copy, readonly) NSString *displayName;
@property (nonatomic, copy, readonly) NSString *estimate; //Formatted string of estimate in local currency of the start location.
@property (nonatomic, readonly) NSInteger lowEstimate;
@property (nonatomic, readonly) NSInteger highEstimate;
@property (nonatomic, readonly) CGFloat surgeMultiplier; //Surge is active if surge_multiplier is greater than 1. Price estimate already factors in the surge multiplier.
@property (nonatomic, readonly) NSInteger duration; //in seconds, but always show in minutes
@property (nonatomic, readonly) CGFloat distance; //always in miles, weird

@end
