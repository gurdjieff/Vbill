//
//  FirstViewThreeController.h
//  Examination
//
//  Created by gurdjieff on 13-7-19.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface FirstViewThreeController : BaseViewController
<downLoadDelegate, UIWebViewDelegate>
{
    NSDictionary * mpInfoDic;
//    NSMutableArray * mpDataAry;
    NSMutableDictionary * mpDictionary;
    UIImageView * mpImageBackView;
    UIWebView * mpWebView;
    NSMutableDictionary * contentDict;
    UIView * mpScoredView;
    AVPlayerLayer *playerLayer;
}
@property(nonatomic, retain) NSDictionary * infoDic;

@end
