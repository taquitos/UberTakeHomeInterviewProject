//
//  UPProductsResponse.m
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

#import "NSObject+JLJSONMapping.h"
#import "UPProduct.h"
#import "UPProductsResponse.h"

@implementation UPProductsResponse

+ (NSDictionary *)jl_propertyTypeMap
{
    return @{ @"products": [UPProduct class]};
}

@end
