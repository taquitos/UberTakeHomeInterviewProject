
#import <Foundation/Foundation.h>

@interface NSString (JLAdditions)

+ (NSString *)jl_trim:(NSString *)string;
+ (BOOL)jl_isEmpty:(NSString *)string;

- (BOOL)jl_containsString:(NSString *)string;

@end
