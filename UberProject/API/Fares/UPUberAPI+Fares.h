//
//  UPUberAPI+Fares.h
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

@import Foundation;

#import "UPUberAPI.h"

@class UPFareEstimateRequest;
@class UPFareEstimateResponse;

NS_ASSUME_NONNULL_BEGIN

typedef void(^FareEstimateRequestCompletion)(UPFareEstimateResponse * _Nullable fareEstimateResponse, NSError * _Nullable error);

@interface UPUberAPI(Fares)

- (UPNetworkRequest *)fareEstimateWithRequest:(UPFareEstimateRequest *)estimateRequest completion:(FareEstimateRequestCompletion)completion;

NS_ASSUME_NONNULL_END

@end
