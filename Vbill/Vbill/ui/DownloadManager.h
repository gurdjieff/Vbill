//
//  DownloadManager.h
//  Examination
//
//  Created by wingsmm on 13-10-14.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DownloadManager;

typedef void (^FinishBlockT) (DownloadManager *dm, NSData *data);

@interface DownloadManager : NSObject
<NSURLConnectionDelegate>
{
    NSURL *_url;
    unsigned long long _size;
    /* 启动几个operation/thread来下载 */
    NSUInteger _maxOperations;
    
    NSOperationQueue * _downloadQueue;
    NSUInteger _finishOperations;
    
    FinishBlockT _finishBlock;
    //void (^finishBlock)(DownloadManager *dm, NSData *data);
}

@property (nonatomic, retain) NSURL *url;
@property (nonatomic, assign) NSUInteger maxOperations;
@property (nonatomic, retain) NSString * imageName;

- (id) initWithURL:(NSURL *)url;
- (void) start;
//- (void) setFinishBlock:(void (^)(DownloadManager *dm, NSData *data))block;
- (void) setFinishBlock:(FinishBlockT)block;
@end

@interface DownloadHelper : NSObject

+(void)writeDataToSqlite:(NSString *)name with:(NSString *)info;
+(BOOL)readDataFromSqlite:(NSString *)name;



@end


