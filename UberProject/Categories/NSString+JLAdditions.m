
#import <CommonCrypto/CommonDigest.h>
#import "NSString+JLAdditions.h"

@implementation NSString (JLAdditions)

+ (NSString *)jl_trim:(NSString *)string
{
    if (!string) {
        return nil;
    }
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (BOOL)jl_isEmpty:(NSString *)string
{
    if (!string) {
        return YES;
    }
    return ([[NSString jl_trim:string] length] == 0);
}

- (NSString *)MD5
{
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    // Create 16 byte MD5 hash value, store in buffer
    NSData *stringData = [self dataUsingEncoding:NSUTF8StringEncoding];
    CC_MD5(stringData.bytes, (CC_LONG)stringData.length, md5Buffer);
    // Convert unsigned char buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",md5Buffer[i]];
    }
    return output;
}

- (BOOL)jl_containsString:(NSString *)string
{
    if ([self respondsToSelector:@selector(containsString:)]) {
        return [self containsString:string];
    } else {
        return ([self rangeOfString:string].location != NSNotFound);
    }
}

@end
