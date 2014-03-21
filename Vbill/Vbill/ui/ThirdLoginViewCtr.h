//
//  ThirdLoginViewCtr.h
//  Examination
//
//  Created by gurd on 13-8-12.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>

@interface ThirdLoginViewCtr : BaseViewController
<TencentSessionDelegate>
{
    TencentOAuth * _tencentOAuth;
@public;
    NSString * mpTitleStr;
}
@end
