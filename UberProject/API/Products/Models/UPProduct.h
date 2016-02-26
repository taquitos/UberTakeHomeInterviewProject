//
//  UPProduct.h
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

@import Foundation;

@class UPPriceDetails;

@interface UPProduct : NSObject

@property (nonatomic, copy, readonly) NSString *productID;
@property (nonatomic, copy, readonly) NSString *displayName;
@property (nonatomic, copy, readonly) NSString *desc;
@property (nonatomic, readonly) NSInteger capacity;
@property (nonatomic, copy, readonly) NSString *imageURLString;
@property (nonatomic, readonly) UPPriceDetails *priceDetails;

@end
