//
//  UPFareEstimateRequest.m
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

#import "NSObject+JLJSONMapping.h"
#import "UPFareEstimateRequest.h"

@implementation UPFareEstimateRequest

+ (UPFareEstimateRequest *)requestWithStartLocation:(CLLocationCoordinate2D)startLocation endLocation:(CLLocationCoordinate2D)endLocation
{
    UPFareEstimateRequest *request = [[UPFareEstimateRequest alloc] initWithStart:startLocation end:endLocation];
    return request;
}

- (instancetype)initWithStart:(CLLocationCoordinate2D)start end:(CLLocationCoordinate2D)end
{
    if (self = [super init]) {
        _startLatitude = start.latitude;
        _endLatitude = end.latitude;
        _startLongitude = start.longitude;
        _endLongitude = end.longitude;
    }
    return self;
}

- (NSDictionary *)queryParams
{
    return @{ @"start_latitude": @(self.startLatitude),
              @"end_latitude": @(self.endLatitude),
              @"start_longitude": @(self.startLongitude),
              @"end_longitude": @(self.endLongitude)};
}

@end
