//
//  UPServerError.m
//  UberProject
//
//  Created by Joshua Liebowitz on 2/25/16.
//  Copyright © 2016 Joshua Liebowitz. All rights reserved.
//

#import "UPServerError.h"

@implementation UPServerError

- (NSString *)description
{
    return [NSString stringWithFormat:@"Error code:%@\nMessage:%@\nFields:%@", self.code, self.message, self.fields];
}

@end
