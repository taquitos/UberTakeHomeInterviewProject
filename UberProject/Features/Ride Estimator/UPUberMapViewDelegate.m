//
//  UPUberMapViewDelegate.m
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

@import MapKit;

#import "UPFareEstimateRequest.h"
#import "UPFareEstimateResponse.h"
#import "UPNetworkRequest.h"
#import "UPUberAPI+Fares.h"
#import "UPUberMapViewDelegate.h"

@interface UPUberMapViewDelegate()

@property (nonatomic, readonly) MKMapView *mapView;
@property (nonatomic, readonly) UPUberAPI *uberAPI;

@property (nonatomic) MKPolyline *routeLine;
@property (nonatomic) MKPolylineView *routeLineView;

@property (nonatomic) UPNetworkRequest *currentFareEstimateRequest;
@property (nonatomic) MKDirections *directions;

@end

@implementation UPUberMapViewDelegate

- (instancetype)initWithUberAPI:(UPUberAPI *)uberAPI mapView:(MKMapView *)mapView
{
    if (self = [super init]) {
        _mapView = mapView;
        _uberAPI = uberAPI;
    }
    return self;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    // the 25, and 50 is the fudge factor, to make map draw better. Totally a magic numbers.
    CLLocationCoordinate2D lowerLeft = [mapView convertPoint:CGPointMake(25, CGRectGetHeight(mapView.bounds) - 25.0) toCoordinateFromView:mapView];
    CLLocationCoordinate2D topRight = [mapView convertPoint:CGPointMake(CGRectGetWidth(mapView.bounds)-25, 50) toCoordinateFromView:mapView];

    UPFareEstimateRequest *request = [UPFareEstimateRequest requestWithStartLocation:lowerLeft endLocation:topRight];
    __weak typeof(self) weakSelf = self;
    UPNetworkRequest *faresRequest = [self.uberAPI fareEstimateWithRequest:request completion:^(UPFareEstimateResponse *fareEstimateResponse, NSError * error) {
        typeof(self) strongSelf = weakSelf;
        if (strongSelf && strongSelf.faresFoundCompletion) {
            // If we have nothing returned, that means the request was cancelled
            if (!fareEstimateResponse && !error) {
                return;
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                strongSelf.faresFoundCompletion(fareEstimateResponse.prices);
                if (fareEstimateResponse.prices.count > 0) {
                    [strongSelf drawRouteWithStart:lowerLeft end:topRight];
                }
            });

            if (error) {
                NSLog(@"Encountered an error trying to request fares");
            }
        }
    }];
    self.currentFareEstimateRequest = faresRequest;
}

- (void)drawRouteWithStart:(CLLocationCoordinate2D)start end:(CLLocationCoordinate2D)end
{
    MKPlacemark *startPlacemark = [[MKPlacemark alloc] initWithCoordinate:start addressDictionary:nil];
    MKPlacemark *endPlacemark = [[MKPlacemark alloc] initWithCoordinate:end addressDictionary:nil];
    MKMapItem *startMapItem = [[MKMapItem alloc] initWithPlacemark:startPlacemark];
    MKMapItem *endMapItem = [[MKMapItem alloc] initWithPlacemark:endPlacemark];
    [startMapItem setName:@"Start"];
    [endMapItem setName:@"End"];

    MKDirectionsRequest *directionsRequest = [[MKDirectionsRequest alloc] init];
    directionsRequest.source = startMapItem;
    directionsRequest.destination = endMapItem;

    self.directions = [[MKDirections alloc] initWithRequest:directionsRequest];
    [self.directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        if (response) {
            [self showRoute:response];
        } else if (error) {
            NSLog(@"Error finding directions between start and finish");
            //swallow
        }
    }];
}

- (void)showRoute:(MKDirectionsResponse *)response
{
    for (MKRoute *route in response.routes) {
        [self.mapView addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 5.0;
    return renderer;
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    if (self.mapMovingCallback) {
        self.mapMovingCallback();
    }
    [self.currentFareEstimateRequest cancel];
    [self.directions cancel];
    [self.mapView removeOverlays:self.mapView.overlays];
}

@end
