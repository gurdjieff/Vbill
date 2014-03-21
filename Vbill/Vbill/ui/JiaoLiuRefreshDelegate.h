//
//  JiaoLiuRefreshDelegate.h
//  Examination
//
//  Created by Zhang Bo on 13-8-22.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JiaoLiuRefreshDelegate <NSObject>
@optional
-(void)refreshJiaoLiu:(BOOL)flag;
@end