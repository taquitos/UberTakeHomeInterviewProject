//
//  UPProductsRequest.h
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

@import CoreGraphics;
@import CoreLocation;
@import Foundation;

#import "UPQueryParamRequest.h"

@interface UPProductsRequest : NSObject <UPQueryParamRequest>

NS_ASSUME_NONNULL_BEGIN

@property (nonatomic, readonly) CGFloat latitude;
@property (nonatomic, readonly) CGFloat longitude;

+ (UPProductsRequest *)requestWithLocation:(CLLocationCoordinate2D)location;
- (instancetype)init NS_UNAVAILABLE;

NS_ASSUME_NONNULL_END

@end
