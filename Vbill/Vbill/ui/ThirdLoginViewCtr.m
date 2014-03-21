//
//  ThirdLoginViewCtr.m
//  Examination
//
//  Created by gurd on 13-8-12.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "ThirdLoginViewCtr.h"
#import "Common.h"

@interface ThirdLoginViewCtr ()

@end

@implementation ThirdLoginViewCtr

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)initTencentLogin
{
    NSString *appid = @"222222";
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:appid andDelegate:self];
    _tencentOAuth.redirectURI = @"www.qq.com";
//    NSArray* permissions =  @[kOPEN_PERMISSION_GET_USER_INFO,
//                              kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
//                              kOPEN_PERMISSION_ADD_ALBUM,
//                              kOPEN_PERMISSION_ADD_IDOL,
//                              kOPEN_PERMISSION_ADD_ONE_BLOG,
//                              kOPEN_PERMISSION_ADD_PIC_T,
//                              kOPEN_PERMISSION_ADD_SHARE,
//                              kOPEN_PERMISSION_ADD_TOPIC,
//                              kOPEN_PERMISSION_CHECK_PAGE_FANS,
//                              kOPEN_PERMISSION_DEL_IDOL,
//                              kOPEN_PERMISSION_DEL_T,
//                              kOPEN_PERMISSION_GET_FANSLIST,
//                              kOPEN_PERMISSION_GET_IDOLLIST,
//                              kOPEN_PERMISSION_GET_INFO,
//                              kOPEN_PERMISSION_GET_OTHER_INFO,
//                              kOPEN_PERMISSION_GET_REPOST_LIST,
//                              kOPEN_PERMISSION_LIST_ALBUM,
//                              kOPEN_PERMISSION_UPLOAD_PIC,
//                              kOPEN_PERMISSION_GET_VIP_INFO,
//                              kOPEN_PERMISSION_GET_VIP_RICH_INFO,
//                              kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
//                              kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,];
    NSArray * permissions = [NSArray arrayWithObjects:@"get_user_info", @"add_share", nil];
    [_tencentOAuth logout:self];
    [_tencentOAuth authorize:permissions inSafari:YES];//500
}

- (void)tencentDidLogin
{
//    _labelTitle.text = @"登录完成";
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length]) {
        // 记录登录用户的OpenID、Token以及过期时间
//        _labelAccessToken.text = _tencentOAuth.accessToken;
    } else {
//        _labelAccessToken.text = @"登录不成功 没有获取accesstoken";
    }
    
//    [_tencentOAuth accessToken] ;
//    [_tencentOAuth openId] ;
}

-(void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled) {
//        _labelTitle.text = @"用户取消登录";
    } else {
//        _labelTitle.text = @"登录失败";
    }
}


-(void)tencentDidNotNetWork
{
//    _labelTitle.text=@"无网络连接，请设置网络";
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addLeftButton];
    mpTitleLabel.text = mpTitleStr;
    [self initTencentLogin];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
