//
//  UPFareEstimate.m
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

#import "NSObject+JLJSONMapping.h"
#import "UPFareEstimate.h"

@implementation UPFareEstimate

+ (NSDictionary *)jl_propertyNameMap
{
    return @{ @"productID": @"product_id",
              @"currencyCode": @"currency_code",
              @"displayName": @"display_name",
              @"lowEstimate": @"low_estimate",
              @"highEstimate": @"high_estimate",
              @"surgeMultiplier": @"surge_multiplier" };
}

@end
