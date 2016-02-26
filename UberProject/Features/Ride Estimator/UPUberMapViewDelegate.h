//
//  UPUberMapViewDelegate.h
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

@import Foundation;
@import MapKit;

@class UPFareEstimate;
@class UPUberAPI;

typedef void(^FaresAvailableCompletion)(NSArray<UPFareEstimate *> * _Nullable fareEstimates);
typedef void(^MapMovingCallback)(void);

@interface UPUberMapViewDelegate : NSObject <MKMapViewDelegate>

@property (nonatomic, copy, nullable) FaresAvailableCompletion faresFoundCompletion;
@property (nonatomic, copy, nullable) MapMovingCallback mapMovingCallback;

NS_ASSUME_NONNULL_BEGIN

- (instancetype)initWithUberAPI:(UPUberAPI *)uberAPI mapView:(MKMapView *)mapView NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;


NS_ASSUME_NONNULL_END

@end
