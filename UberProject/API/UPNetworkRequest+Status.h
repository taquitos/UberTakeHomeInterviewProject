//
//  UPNetworkRequest_Status.h
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

#import "UPNetworkRequest.h"

typedef NS_ENUM(NSInteger, UPHTTPStatus) {
// from https://developer.uber.com/docs/api-reference
    UPHTTPStatusOk = 200,
    UPHTTPStatusCreated = 201,
    UPHTTPStatusBadRequest = 400,
    UPHTTPStatusUnauthorized = 401,
    UPHTTPStatusForbidden = 403,
    UPHTTPStatusNotFound = 404,
    UPHTTPStatusUnacceptableContentType = 406,
    UPHTTPStatusConflict = 409,
    UPHTTPStatusInvalidRequest = 422,
    UPHTTPStatusRateLimit = 429,
    UPHTTPStatusServerError = 500
};

@interface UPNetworkRequest(Status)

@end
