//
//  DateSource.m
//  economicInfo
//
//  Created by gurdjieff on 12-11-22.
//
//

#import "DateSource.h"

@implementation DateSource
@synthesize appVersionInfo = mpAppVersionInfo;


+(id)sharedDateSource
{
    static DateSource * dateSourceInstance = nil;
    if (dateSourceInstance == nil) {
        dateSourceInstance = [[DateSource alloc] init];
    }
    return dateSourceInstance;
}


+(NSMutableDictionary *)getNewVersionInfo
{
    DateSource * instance = [DateSource sharedDateSource];
    return instance.appVersionInfo;
}

-(id)init
{
    if ((self = [super init])) {
        mpAppVersionInfo = [[NSMutableDictionary alloc] init];
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary * dic = [defaults objectForKey:@"appVersionInfo"];
        if (dic) {
            [mpAppVersionInfo setDictionary:dic];
        }
    }
    return self;
}

+(void)storeInfomationStore
{
    DateSource * instance = [DateSource sharedDateSource];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:instance.appVersionInfo forKey:@"appVersionInfo"];
    [defaults synchronize];
}

-(void)dealloc{
    [mpAppVersionInfo release], mpAppVersionInfo = nil;
    [super dealloc];
}

@end
