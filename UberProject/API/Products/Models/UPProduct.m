//
//  UPProduct.m
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

#import "NSObject+JLJSONMapping.h"
#import "UPPriceDetails.h"
#import "UPProduct.h"

@implementation UPProduct

+ (NSDictionary *)jl_propertyNameMap
{
    return @{ @"productID": @"product_id",
              @"displayName": @"display_name",
              @"desc": @"description",
              @"imageURLString": @"image",
              @"priceDetails": @"price_details"};
}

@end
