//
//  Common.h
//  Examination
//
//  Created by gurd on 13-7-15.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+ViewFrameGeometry.h"
#if 1
#define LFLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define LFLog(xx, ...)  ((void)0)
#endif


//#define serverIp @"http://114.113.155.86:80"

#define serverIp @"http://116.90.86.104:81"
#define appVersionCheck @"http://itunes.apple.com/lookup?id=548248143"
#define appDownLoadUrl @"https://itunes.apple.com/us/app/xin-rui-cai-jing/id548248143?mt=8"


//#define serverIp @"http://192.168.1.2:80"
#define askFont [UIFont systemFontOfSize:16]
#define askWidth 280.0f
#define choiceBtnHeight 50.0f
#define explainBtnHeight 25.0f


#define yellowColor [UIColor colorWithRed:0xef/255.0f green:0x96/255.0f blue:0x22/255.0f alpha:1.0]
#define testblackColor [UIColor blackColor]
#define cellBackColor [UIColor colorWithRed:0xe3/255.0f green:0xe1/255.0f blue:0xe1/255.0f alpha:1.0]
#define cellSeparateColor [UIColor colorWithRed:0xc3/255.0f green:0xc3/255.0f blue:0xc3/255.0f alpha:1.0]


@interface Common : NSObject
+(NSString *)getDeviceIdentifer;
+(NSOperationQueue *)getOperationQueue;
@end
