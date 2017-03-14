//
//  NSString+ZZURLEncoding.m
//
//

#import "NSString+ZZPercentEscape.h"

@implementation NSString (ZZPercentEscape)


- (NSString *)percentEscapeAdd
{
    NSString *result = ( NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            NULL,
                                            CFSTR("!*();+$,%#[] "),
                                            kCFStringEncodingUTF8));
    return result;
}

- (NSString*)percentEscapesReplace
{
    NSString *result = ( NSString *)
    CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                            (CFStringRef)self,
                                                            CFSTR(""),
                                                            kCFStringEncodingUTF8));
    return result;
}

@end

