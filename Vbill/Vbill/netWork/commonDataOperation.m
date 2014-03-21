//
//  commonDataOperation.m
//  economicInfo
//
//  Created by daiyu zhang on 12-9-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "commonDataOperation.h"
#import "ASIFormDataRequest.h"
#import "AppDelegate.h"
#import "NSString+CustomCategory.h"
#import "iLoadAnimationView.h"
#import "JSON.h"
#import "sqliteDataManage.h"



@implementation commonDataOperation
@synthesize urlStr = mpUrlStr;
@synthesize argumentDic = mpArgumentDic;
@synthesize isPOST;
@synthesize isImage;
@synthesize newimage;
@synthesize showAnimation;
@synthesize useCache;

-(id)init
{
    if ((self = [super init])) {
        mpArgumentDic = [[NSMutableDictionary alloc] init];
        isPOST = NO;
        isImage = NO;
        showAnimation = YES;
    }
    return self;
}

-(void)cacheDataToDataBase:(NSString *)info
{
    if (!useCache) {
        return;
    }
    NSMutableString * argumetStr = [[NSMutableString alloc] init];
    for (NSString * key in [mpArgumentDic allKeys]) {
        [argumetStr appendString:key];
        NSString * arg = mpArgumentDic[key];
        [argumetStr appendString:arg];
    }

    NSString * identifer = [NSString stringWithFormat:@"%@%@", mpUrlStr, argumetStr];
    [argumetStr release];
    NSString * identiferMD5 = [identifer stringFromMD5];
    
    sqliteDataManage * sqliteInstance = [sqliteDataManage sharedSqliteDataManage];
    char *errorMsg = NULL;
    char *insert = "INSERT OR REPLACE into cacheData (identifer, info) values(?,?);";
    sqlite3 * database = sqliteInstance->database;
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, insert, -1, &stmt, nil)==SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [identiferMD5 UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [info UTF8String], -1, NULL);
    }
    
    if (sqlite3_step(stmt)!=SQLITE_DONE) {
        NSLog(@"Error updating table:%s",errorMsg);
    }
    sqlite3_finalize(stmt);
}

-(void)backToMainThread:(NSString *)dataString
{
    if (![dataString ifInvolveStr:@"result"]) {
        if ([downInfoDelegate respondsToSelector:@selector(requestFailed:withTag:)]) {
            [downInfoDelegate requestFailed:@"数据格式不对" withTag:miTag];
        }
    } else if ([downInfoDelegate respondsToSelector:@selector(downLoadWithInfo:with:)]) {
//        {"result":"2","msg":"请先登录！"}
        if ([dataString ifInvolveStr:@"\"result\":\"2\""]) {
            NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
            for (id obj in _tmpArray) {
                [cookieJar deleteCookie:obj];
            }
            
            NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setBool:NO forKey:@"ifLogin"];
            [userDefaults synchronize];
        } else {
            [self cacheDataToDataBase:dataString];
            [downInfoDelegate downLoadWithInfo:dataString with:miTag];
        }
    }
}

-(void)requestFailBackToMainThread:(NSString *)dataString
{
    if ([downInfoDelegate respondsToSelector:@selector(requestFailed:withTag:)]) {
        [downInfoDelegate requestFailed:@"数据请求失败" withTag:miTag];
    }
}

-(void)startTask
{
    NSString * lpMethod = @"GET";
    if (isPOST) {
        lpMethod = @"POST";
    }
    mpFormDataRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:mpUrlStr]];
    [mpFormDataRequest setRequestMethod:lpMethod];
    for (NSString * key in mpArgumentDic) {
        [mpFormDataRequest setPostValue:[mpArgumentDic objectForKey:key] forKey:key];
    }
    
    if (isImage) {
         NSData *png = UIImagePNGRepresentation(newimage);
		[mpFormDataRequest setPostValue:@"test.png" forKey:@"UploadHeadPhoto"];
	

		[mpFormDataRequest addData:png forKey:@"HeadPhoto"];
    }
    
    [mpFormDataRequest setTimeOutSeconds:15];
    [mpFormDataRequest startSynchronous];  
    
    NSInteger liCode = [mpFormDataRequest responseStatusCode];
    NSLog(@"code:%ld", (long)liCode);
    
    NSLog(@"%@",[mpFormDataRequest responseString]);
    
    if (liCode == 200) {
        NSString * lpInfo = [mpFormDataRequest responseString];
        [self performSelectorOnMainThread:@selector(backToMainThread:) withObject:lpInfo waitUntilDone:NO];
    } else {
        [self performSelectorOnMainThread:@selector(requestFailBackToMainThread:) withObject:nil waitUntilDone:NO];
    }
}

-(void)getDataFromCache
{
    if (useCache == NO) {
        return;
    }
    NSMutableString * argumetStr = [[NSMutableString alloc] init];
    for (NSString * key in [mpArgumentDic allKeys]) {
        [argumetStr appendString:key];
        NSString * arg = mpArgumentDic[key];
        [argumetStr appendString:arg];
    }
    NSString * identifer = [NSString stringWithFormat:@"%@%@", mpUrlStr, argumetStr];
    [argumetStr release];
    NSString * identiferMD5 = [identifer stringFromMD5];
    
    sqliteDataManage * sqliteInstance = [sqliteDataManage sharedSqliteDataManage];
    NSString * selectSql = [NSString stringWithFormat:@"select info from cacheData where identifer = '%@'", identiferMD5];
    sqlite3_stmt * statement = [sqliteInstance selectData:selectSql];
    NSString * dateStr = nil;
    if (sqlite3_step(statement) == SQLITE_ROW) {
        dateStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
    }
    sqlite3_finalize(statement);
    [sqliteInstance closeSqlite];
    
    if (dateStr) {
        [self performSelectorOnMainThread:@selector(backToMainThread:) withObject:dateStr waitUntilDone:NO];
    }
}

- (void) main
{
    if (showAnimation) {
        [iLoadAnimationView startLoadAnimation];
    }
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    [self getDataFromCache];
    [self startTask];
    [pool release];
    [iLoadAnimationView stopLoadAnimation];
}

-(void)dealloc
{
    [newimage release],newimage = nil;
    [iLoadAnimationView stopLoadAnimation];
    [mpUrlStr release], mpUrlStr = nil;
    [mpArgumentDic release], mpArgumentDic = nil;
    [super dealloc];
}




@end
