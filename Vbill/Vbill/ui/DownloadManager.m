//
//  DownloadManager.m
//  Examination
//
//  Created by wingsmm on 13-10-14.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "DownloadManager.h"
#import "DownloadOperation.h"
#import "sqliteDataManage.h"

@implementation DownloadManager
@synthesize url = _url;
@synthesize maxOperations = _maxOperations;
@synthesize imageName = _imageName;

- (id) initWithURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        self.url = url;
        _size = 0;
        _maxOperations = 1;
        _finishOperations = 0;
        _downloadQueue = [[NSOperationQueue alloc] init];
        _finishBlock = nil;
    }
    return self;
}
- (id) init
{
    return [self initWithURL:nil];
}
- (void) dealloc
{
    [_downloadQueue release], _downloadQueue = nil;
    self.imageName = nil;
    self.url = nil;
    [super dealloc];
}


- (void) start
{
    NSURLRequest *_request = [[NSURLRequest alloc]
                              initWithURL:_url
                              cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                              timeoutInterval:60];
    NSURLConnection *_connection = [[NSURLConnection alloc] initWithRequest:_request delegate:self startImmediately:YES];
    [_request release];
    [_connection release];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [connection cancel];
    _size = [response expectedContentLength];
 
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    NSLog(@"image size is %llu", _size);
    NSLog(@"response header is %@", res.allHeaderFields);
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    NSString * imageName = [[_url absoluteString] lastPathComponent];

    
    path = [path stringByAppendingPathComponent:_imageName];

    NSFileManager *fm = [NSFileManager defaultManager];
    
    BOOL  isExist = [fm fileExistsAtPath:path];

    if (isExist)
        [fm removeItemAtPath:path error:nil];
    
    [fm createFileAtPath:path contents:nil attributes:nil];

    

    unsigned long long eachSize = _size/_maxOperations;
    unsigned long long startOffset = 0;

    for (int i = 0; i <_maxOperations; i++) {
        if (i == _maxOperations - 1) {
            eachSize += (_size-eachSize*_maxOperations);
        }
        NSLog(@"op %d start %llu len %llu",
              i, startOffset, eachSize);
        
        
        DownloadOperation * op = [DownloadOperation operationWithID:(i+1) url:_url start:startOffset length:eachSize path:path];
        [op setCompletionBlock:^(void){
            NSLog(@"task is finish");
            _finishOperations++;
            if (_finishOperations == _maxOperations) {
                
                NSLog(@"url downloading is finished \n %@",[self.url relativeString]);

                
                

                
                NSString * movieName =[self.url relativeString];
                NSInteger movielength =[movieName length];
                
                NSArray * strArray =[[movieName substringToIndex:movielength-4] componentsSeparatedByString:@"="];
                
                [DownloadHelper writeDataToSqlite:[strArray lastObject] with:@"yes"];

                
                if (_finishBlock) {
                    NSData *data = [NSData dataWithContentsOfFile:path];
                    _finishBlock(self, data);
                }
            }
        }];
        [_downloadQueue addOperation:op];
        startOffset += eachSize;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{

}

- (void) setFinishBlock:(FinishBlockT)block
{
    [_finishBlock release];
    _finishBlock = [block copy];
}

@end


@implementation DownloadHelper

+(void)writeDataToSqlite:(NSString *)name with:(NSString *)info
{
    
    
    sqliteDataManage * sqliteInstance = [sqliteDataManage sharedSqliteDataManage];
    char *errorMsg = NULL;
    char *insert = "INSERT OR REPLACE into cacheDownload (moviename, movieinfo) values(?,?);";
    sqlite3 * database = sqliteInstance->database;
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, insert, -1, &stmt, nil)==SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [name UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [info UTF8String], -1, NULL);
    }
    
    if (sqlite3_step(stmt)!=SQLITE_DONE) {
        NSLog(@"Error updating table:%s",errorMsg);
    }
    sqlite3_finalize(stmt);
    
    [sqliteInstance closeSqlite];
}

+(BOOL)readDataFromSqlite:(NSString *)name
{
    sqliteDataManage * sqliteInstance = [sqliteDataManage sharedSqliteDataManage];
    NSString * selectSql = [NSString stringWithFormat:@"select movieinfo from cacheDownload where moviename = '%@'", name];
    
 
    sqlite3_stmt * statement = [sqliteInstance selectData:selectSql];
    NSString * dateStr = nil;
    if (sqlite3_step(statement) == SQLITE_ROW) {
        dateStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
    }
    sqlite3_finalize(statement);
    [sqliteInstance closeSqlite];
    
    if (dateStr) {
       
        if ([dateStr isEqualToString:@"yes"]) {
            return YES;
        }else{
            return NO;
        }
        
    }
    return NO;

}

@end


