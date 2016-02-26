//
//  UPProductsRequest.m
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

#import "UPProductsRequest.h"

static NSString * const kUPProductsRequestLatitudeQueryParam = @"latitude";
static NSString * const kUPProductsRequestLongitudeQueryParam = @"longitude";

@implementation UPProductsRequest

+ (UPProductsRequest *)requestWithLocation:(CLLocationCoordinate2D)location
{
    return [[UPProductsRequest alloc] initWithLocation:location];
}

- (instancetype)initWithLocation:(CLLocationCoordinate2D)location
{
    if (self = [super init]) {
        _latitude = location.latitude;
        _longitude = location.longitude;
    }
    return self;
}

- (NSDictionary *)queryParams
{
    return @{ kUPProductsRequestLatitudeQueryParam: @(self.latitude),
              kUPProductsRequestLongitudeQueryParam: @(self.longitude) };
}

@end
