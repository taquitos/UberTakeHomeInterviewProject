//
//  UPPriceDetails.m
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

#import "NSObject+JLJSONMapping.h"
#import "UPPriceDetails.h"
#import "UPServiceFee.h"

@implementation UPPriceDetails

+ (NSDictionary *)jl_propertyNameMap
{
    return @{ @"costPerMinute": @"cost_per_minute",
              @"costPerDistance": @"cost_per_distance",
              @"distanceUnit": @"distance_unit",
              @"cancellationFee": @"cancellation_fee",
              @"currencyCode": @"currency_code",
              @"serviceFees": @"service_fees"};
}

+ (NSDictionary *)jl_propertyTypeMap
{
    return @{ @"serviceFees": [UPServiceFee class]};
}

@end
