//
//  UPServerError.h
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

@import Foundation;

@interface UPServerError : NSObject

@property (nonatomic, copy, readonly) NSString *message;
@property (nonatomic, copy, readonly) NSString *code;
@property (nonatomic, copy, readonly) NSDictionary *fields;

@end
