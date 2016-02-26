//
//  UPFareEstimateResponse.h
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

@import Foundation;

@class UPFareEstimate;

@interface UPFareEstimateResponse : NSObject

@property(nonatomic, copy, readonly) NSArray<UPFareEstimate *> *prices;

@end
