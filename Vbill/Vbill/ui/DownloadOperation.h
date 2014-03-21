//
//  DownloadOperation.h
//  Examination
//
//  Created by wingsmm on 13-10-14.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadOperation : NSOperation
    <NSURLConnectionDataDelegate>
{
    NSUInteger _opid;
    NSURL *_url;
    unsigned long long _startOffset;
    unsigned long long _length;

    BOOL done;
    
    NSURLConnection *_connection;
    NSMutableURLRequest * _request;
    NSString *_path;
    
    NSFileHandle * fileHandle;
}
@property (nonatomic, assign) NSUInteger opid;
@property (nonatomic, retain) NSURL *url;
@property (nonatomic, assign) unsigned long long startOffset;
@property (nonatomic, assign) unsigned long long length;
@property (nonatomic, retain) NSString * path;

- (id) initWithID:(NSUInteger)opid
              url:(NSURL *)url
            start:(unsigned long long)start
           length:(unsigned long long)len
             path:(NSString *)path;
+ (id) operationWithID:(NSUInteger)opid
                   url:(NSURL *)url
                 start:(unsigned long long)start
                length:(unsigned long long)len
                  path:(NSString *)path;


@end
