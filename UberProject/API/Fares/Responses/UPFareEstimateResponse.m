//
//  UPFareEstimateResponse.m
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

#import "NSObject+JLJSONMapping.h"
#import "UPFareEstimate.h"
#import "UPFareEstimateResponse.h"

@implementation UPFareEstimateResponse

+ (NSDictionary *)jl_propertyTypeMap
{
    return @{ @"prices": [UPFareEstimate class] };
}

@end
