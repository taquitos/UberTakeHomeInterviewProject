//
//  UPUberAPI+Fares.m
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

#import "UPFareEstimateRequest.h"
#import "UPFareEstimateResponse.h"
#import "UPNetworkRequest.h"
#import "UPUberAPI+Fares.h"

@implementation UPUberAPI(Fares)

- (UPNetworkRequest *)fareEstimateWithRequest:(UPFareEstimateRequest *)estimateRequest completion:(FareEstimateRequestCompletion)completion
{
    UPNetworkRequest *request = [UPNetworkRequest requestForVerb:UPNetworkRequestVerbGET object:nil queryParams:[estimateRequest queryParams] endpoint:@"/v1/estimates/price" authHeaders:[self serverAuthorizationHeaders] completion:^(UPFareEstimateResponse *fareEstimateResponse, NSError *error) {
        if (completion != NULL) {
            completion(fareEstimateResponse, error);
        }
    }];
    [request startWithExpectedResponseObjectClass:[UPFareEstimateResponse class]];
    return request;
}

@end
