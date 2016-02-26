//
//  UPFareEstimateRequest.h
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

@import CoreGraphics.CGBase;
@import Foundation;
@import MapKit;

#import "UPQueryParamRequest.h"

@interface UPFareEstimateRequest : NSObject <UPQueryParamRequest>

NS_ASSUME_NONNULL_BEGIN

@property (nonatomic, readonly) CGFloat startLatitude;
@property (nonatomic, readonly) CGFloat endLatitude;
@property (nonatomic, readonly) CGFloat startLongitude;
@property (nonatomic, readonly) CGFloat endLongitude;

+ (UPFareEstimateRequest *)requestWithStartLocation:(CLLocationCoordinate2D)startLocation endLocation:(CLLocationCoordinate2D)endLocation;
- (instancetype)init NS_UNAVAILABLE;

NS_ASSUME_NONNULL_END

@end
