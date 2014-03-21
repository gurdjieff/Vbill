//
//  NSString+CustomCategory.m
//  FinanceTrade
//
//  Created by gurdjieff on 13-4-2.
//  Copyright (c) 2013年 cn.com.wxxr. All rights reserved.
//

#import "NSString+CustomCategory.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (CustomCategory)

+(NSString *)getAppPath
{
    NSArray * documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [documentPaths objectAtIndex:0];
}

-(BOOL)ifInvolveStr:(NSString *)str
{
    return [self rangeOfString:str options:NSCaseInsensitiveSearch].length > 0;
}

- (NSString *) stringFromMD5{
    
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return [outputString autorelease];
}



@end
