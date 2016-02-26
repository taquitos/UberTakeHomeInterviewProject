//
//  NSDictionary+QueryString.m
//
//  Created by Joshua Liebowitz on 4/9/15.
//  Copyright © 2015 Joshua Liebowitz. All rights reserved.
//

#import "NSDictionary+QueryString.h"

@implementation NSDictionary (QueryString)

- (NSString *)queryStringValue
{
    NSMutableArray *pairs = [NSMutableArray array];
    for (NSString *key in [self keyEnumerator]) {
        id<NSObject> value = [self objectForKey:key];
        NSString *escapedValue = nil;
        if ([value isKindOfClass:[NSNumber class]]) {
            escapedValue = ((NSNumber *)value).stringValue;
        } else if ([value isKindOfClass:[NSString class]]){
            escapedValue = [self URLEncodedString:(NSString *)value];
        } else {
            NSLog(@"Value in dictionary is not a NSString or NSNumber, class:%@", [value class]);
        }
        if (escapedValue) {
            [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escapedValue]];
        }
    }
    return [pairs componentsJoinedByString:@"&"];
}

- (NSString *)URLEncodedString:(NSString *)string
{
    static NSString * const unsafeChars = @":!*();@/&?#[]+$,='%’\" ";
    static NSCharacterSet *allowedChars;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSCharacterSet *disallowedChars = [NSCharacterSet characterSetWithCharactersInString:unsafeChars];
        allowedChars = disallowedChars.invertedSet;
    });
    
    return [string stringByAddingPercentEncodingWithAllowedCharacters:allowedChars];
}

@end
