//
//  AppDelegate.h
//  Vbill
//
//  Created by daiyuzhang on 14-3-21.
//  Copyright (c) 2014年 daiyuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseDataOperation.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, downLoadDelegate>
{
    NSOperationQueue * mpOperationQueue;
}
@property (assign, nonatomic) NSOperationQueue * operationQueue;
@property (strong, nonatomic) UIWindow *window;

@end
