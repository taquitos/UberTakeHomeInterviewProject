//
//  UPUberAPI+Products.h
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

@import Foundation;

#import "UPUberAPI.h"

@class UPNetworkRequest;
@class UPProductsRequest;
@class UPProductsResponse;

NS_ASSUME_NONNULL_BEGIN

typedef void(^ProductRequestCompletion)(UPProductsResponse * _Nullable productResponse, NSError * _Nullable error);

@interface UPUberAPI(Products)

- (UPNetworkRequest *)productsWithRequest:(UPProductsRequest *)productsRequest completion:(ProductRequestCompletion)completion;

NS_ASSUME_NONNULL_END

@end
