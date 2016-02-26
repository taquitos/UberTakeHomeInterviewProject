//
//  NSError+UberProject.h
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

@import Foundation;

#import "UPNetworkRequest+Status.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const kUberProjectErrorDomain;
FOUNDATION_EXPORT NSString * const kUberProjectErrorReasonKey;

@class UPServerError;

@interface NSError(UberProject)

+ (NSError *)up_networkingErrorWithStatus:(UPHTTPStatus)status;
+ (NSError *)up_networkingErrorWithStatus:(UPHTTPStatus)status serverError:(UPServerError * _Nullable)serverError;

- (BOOL)isUberProjectError;
- (BOOL)isUberNetworkingError;
- (UPServerError * _Nullable)uberServerError;

NS_ASSUME_NONNULL_END

@end
