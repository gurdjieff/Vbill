//
//  DownloadOperation.m
//  Examination
//
//  Created by wingsmm on 13-10-14.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "DownloadOperation.h"

@implementation DownloadOperation
@synthesize opid = _opid;
@synthesize url = _url;
@synthesize startOffset = _startOffset, length = _length;
@synthesize path = _path;

- (id) initWithID:(NSUInteger)opid
              url:(NSURL *)url
            start:(unsigned long long)start
           length:(unsigned long long)len
             path:(NSString *)path
{
    self = [super init];
    if (self) {
        self.opid = opid;
        self.url = url;
        self.startOffset = start;
        self.length = len;
        self.path = path;
    }
    return self;
}
+ (id) operationWithID:(NSUInteger)opid
                   url:(NSURL *)url
                 start:(unsigned long long)start
                length:(unsigned long long)len
                  path:(NSString *)path
{
    return [[[[self class] alloc] initWithID:opid url:url start:start length:len path:path] autorelease];
}

- (void) main
{
    done = NO;
     NSString *rangeValue = [NSString stringWithFormat:
                            @"bytes=%llu-%llu",
                            _startOffset,
                            _startOffset+_length-1];
    NSLog(@"range value is %@", rangeValue);
    _request = [[NSMutableURLRequest alloc] initWithURL:_url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0f];
    [_request setValue:rangeValue forHTTPHeaderField:@"Range"];
    [_request setHTTPShouldHandleCookies:NO];
    _connection = [[NSURLConnection alloc] initWithRequest:_request delegate:self];
    while (!done) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}
- (void) dealloc
{
    self.path = nil;
    self.url = nil;
    [fileHandle release];
    [super dealloc];
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    NSLog(@"opid  %d response header is %@",
          _opid, res.allHeaderFields);
   
    NSFileHandle *fh = [NSFileHandle fileHandleForWritingAtPath:_path];
    [fh seekToFileOffset:_startOffset];
    fileHandle = [fh retain];
}
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSUInteger len = [data length];
    NSLog(@"opid %d len %d", _opid, len);
    [fileHandle writeData:data];
}
- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"opid %d finish", _opid);
    [_connection release], _connection = nil;
    [_request release], _request = nil;
    [fileHandle synchronizeFile];
    [fileHandle closeFile];
    done = YES;
}


@end
