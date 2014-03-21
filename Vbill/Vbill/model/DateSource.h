//
//  DateSource.h
//  economicInfo
//
//  Created by gurdjieff on 12-11-22.
//
//

#import <Foundation/Foundation.h>

@interface DateSource : NSObject
{
    NSMutableDictionary * mpAppVersionInfo;
    NSString * currentVersion;
}

@property (assign, nonatomic) NSMutableDictionary * appVersionInfo;

+(id)sharedDateSource;
+(NSMutableDictionary *)getNewVersionInfo;
+(void)storeInfomationStore;



@end
