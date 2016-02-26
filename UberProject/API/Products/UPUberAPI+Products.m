//
//  UPUberAPI+Products.m
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

#import "NSError+UberProject.h"
#import "UPNetworkRequest.h"
#import "UPProductsRequest.h"
#import "UPProductsResponse.h"
#import "UPUberAPI+Products.h"

@implementation UPUberAPI(Products)

- (UPNetworkRequest *)productsWithRequest:(UPProductsRequest *)productsRequest completion:(ProductRequestCompletion)completion
{
    UPNetworkRequest *request = [UPNetworkRequest requestForVerb:UPNetworkRequestVerbGET object:nil queryParams:[productsRequest queryParams] endpoint:@"/v1/products" authHeaders:[self serverAuthorizationHeaders] completion:^(UPProductsResponse *productResponse, NSError *error) {
        if (completion != NULL) {
            completion(productResponse, error);
        }
    }];
    [request startWithExpectedResponseObjectClass:[UPProductsResponse class]];
    return request;
}

@end
