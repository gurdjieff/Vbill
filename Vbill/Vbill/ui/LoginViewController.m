//
//  LoginViewController.m
//  Examination
//
//  Created by gurdjieff on 13-7-22.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "LoginViewController.h"
#import "NSString+CustomCategory.h"
#import "RegisterViewController.h"
#import "CustomAlertView.h"
#import "NewItoast.h"
#import "FirstViewController.h"
#import "ThirdLoginViewCtr.h"
#import "SinaWeiBoViewCtr.h"
#import "AppDelegate.h"
#import "BaseNetWorkClient.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

-(void)initNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboarWilldHidden)
												 name:UIKeyboardWillHideNotification
											   object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

-(void)keyboarWilldHidden
{
    [UIView animateWithDuration:0.25 animations:^{
        mpBaseView.center = center;
    }];
}

-(void)keyboardWillShow:(NSNotification *)aNotification
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    
    NSDictionary* lpinfo=[aNotification userInfo];
    NSValue* lpValue=[lpinfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize=[lpValue CGRectValue].size;
    mpBaseView.center = CGPointMake(center.x, center.y - keyboardSize.height+20);
    [UIView commitAnimations];
}


-(void)addSubViews
{
    float textFieldHeight = 35;
    float textFieldWidth = 200;
    
    UIImageView * lpView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, appFrameHeigh-44)];
    lpView.image = [UIImage imageNamed:@"purple.png"];
    [mpBaseView addSubview:lpView];
    [lpView release];
    
    //    456 169
//    UIImageView * lpView2 = [[UIImageView alloc] initWithFrame:CGRectMake(80, 50, 200, 75)];
//    lpView2.image = [UIImage imageNamed:@"platform.png"];
//    [mpBaseView addSubview:lpView2];
//    [lpView2 release];
    
    
    
    UILabel * lpLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(25, 200, 70, textFieldHeight)];
    lpLabel1.backgroundColor = [UIColor grayColor];
    lpLabel1.textAlignment = NSTextAlignmentCenter;
    lpLabel1.text = @"昵称";
    UILabel * lpLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(25, 200+40, 70, textFieldHeight)];
    lpLabel2.textAlignment = NSTextAlignmentCenter;
    lpLabel2.text = @"密码";
    lpLabel2.backgroundColor = [UIColor grayColor];
    [mpBaseView addSubview:lpLabel1];
    [mpBaseView addSubview:lpLabel2];
    [lpLabel1 release];
    [lpLabel2 release];
    
    mpName = [[UITextField alloc] initWithFrame:CGRectMake(lpLabel1.left, 200, textFieldWidth, textFieldHeight)];
    mpName.backgroundColor = [UIColor whiteColor];
    mpName.borderStyle = UITextBorderStyleNone;
    mpName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [mpBaseView addSubview:mpName];
    [mpName release];
    
    mpPassword = [[UITextField alloc] initWithFrame:CGRectMake(lpLabel1.left, 240, textFieldWidth, textFieldHeight)];
    mpPassword.backgroundColor = [UIColor whiteColor];
    mpPassword.borderStyle = UITextBorderStyleNone;
    mpPassword.secureTextEntry = YES;
    mpPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [mpBaseView addSubview:mpPassword];
    [mpPassword release];
    
    
//    NSArray * lpAry = [NSArray arrayWithObjects:@"注册",@"确定", nil];
    NSArray * lpImages = [NSArray arrayWithObjects:@"qq.png",@"sinaWeibo.png",@"registerBtn.png",@"loginBtn.png", nil];
    for (int i = 0; i < 4; i++) {
        UIButton * lpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        lpBtn.frame = CGRectMake(25+i*70, 330, 60, 40);
        [lpBtn setBackgroundImage:[UIImage imageNamed:lpImages[i]] forState:UIControlStateNormal];
        lpBtn.tag = 100+i;
        lpBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [lpBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [mpBaseView addSubview:lpBtn];

    }
}


#pragma mark - Tencent


-(void)initTencentLogin
{
    NSString *appid = @"100508523";
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:appid andDelegate:self];
    _tencentOAuth.redirectURI = @"mlearning.cc?a=b&c=d";

    NSArray* permissions =  @[kOPEN_PERMISSION_GET_USER_INFO,
                              kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                              kOPEN_PERMISSION_ADD_ALBUM,
                              kOPEN_PERMISSION_ADD_IDOL,
                              kOPEN_PERMISSION_ADD_ONE_BLOG,
                              kOPEN_PERMISSION_ADD_PIC_T,
                              kOPEN_PERMISSION_ADD_SHARE,
                              kOPEN_PERMISSION_ADD_TOPIC,
                              kOPEN_PERMISSION_CHECK_PAGE_FANS,
                              kOPEN_PERMISSION_DEL_IDOL,
                              kOPEN_PERMISSION_DEL_T,
                              kOPEN_PERMISSION_GET_FANSLIST,
                              kOPEN_PERMISSION_GET_IDOLLIST,
                              kOPEN_PERMISSION_GET_INFO,
                              kOPEN_PERMISSION_GET_OTHER_INFO,
                              kOPEN_PERMISSION_GET_REPOST_LIST,
                              kOPEN_PERMISSION_LIST_ALBUM,
                              kOPEN_PERMISSION_UPLOAD_PIC,
                              kOPEN_PERMISSION_GET_VIP_INFO,
                              kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                              kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                              kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,];
//    NSArray * perm  mnissions = [NSArray arrayWithObjects:@"get_user_info", @"add_share", nil];
    [_tencentOAuth logout:self];
    [_tencentOAuth authorize:permissions inSafari:NO];//500
}

- (void)getUserInfoResponse:(APIResponse*) response {
	
	
	
	if (response.retCode == URLREQUEST_SUCCEED)
	{
        NSDictionary * dicTemp = [NSDictionary dictionaryWithDictionary:response.jsonResponse];
        NSString *name = dicTemp[@"nickname"];
        NSString *figureurl_qq_2 = dicTemp[@"figureurl_qq_2"];
        //                "figureurl_qq_2" = "http://q.qlogo.cn/qqapp/100508523/8FC6C19F765869D3ED2F6B0F785476B1/100";
        commonDataOperation * operation = [[commonDataOperation alloc] init];
        operation.urlStr = [serverIp stringByAppendingFormat:@"/User/AuthLogin.action"];
        operation.downInfoDelegate = self;
        [operation.argumentDic setValue:name forKey:@"UserName"];
        [operation.argumentDic setValue:figureurl_qq_2 forKey:@"HeadPhotoUrl"];
        [operation.argumentDic setValue:[_tencentOAuth.openId stringFromMD5] forKey:@"Password"];
        operation.isPOST = YES;
        [mpOperationQueue addOperation:operation];
        [operation release];
    } else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%@", response.errorMsg]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
        [alert release];
	}
}

- (void)showInvalidTokenOrOpenIDMessage{
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"api调用失败"
													 message:@"可能授权已过期，请重新获取"
													delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease];
    [alert show];
}


#pragma mark - TencentLoginDelegate

- (void)tencentDidLogin
{
    //    _labelTitle.text = @"登录完成";
    if (_tencentOAuth.accessToken
		&& 0 != [_tencentOAuth.accessToken length])
	{
        if(![_tencentOAuth getUserInfo]){
            [self showInvalidTokenOrOpenIDMessage];
        }
// 记录登录用户的OpenID、Token以及过期时间
//        _labelAccessToken.text = _tencentOAuth.accessToken;
    } else {
 //        _labelAccessToken.text = @"登录不成功 没有获取accesstoken";
    }
    
    [_tencentOAuth accessToken] ;
    [_tencentOAuth openId] ;
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





-(void)btnClick:(UIButton *)btn
{
     if (btn.tag == 100) {
        [self initTencentLogin];
		 
    } else if (btn.tag == 101) {
        SinaWeiBoViewCtr * lpViewCtr = [[SinaWeiBoViewCtr alloc] init];
        [self.navigationController pushViewController:lpViewCtr animated:YES];
        [lpViewCtr release];
    } else if (btn.tag == 102) {
        RegisterViewController * lpViewCtr = [[RegisterViewController alloc] init];
        [self.navigationController pushViewController:lpViewCtr animated:YES];
        [lpViewCtr release];
    } else if (btn.tag == 103) {
        [self sendLoginRequest];
    }
}

-(void)initData
{
    center = mpBaseView.center;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    mpTitleLabel.text = NSLocalizedString(@"登  录", nil);
    [self initNotification];
    [self addSubViews];
	// Do any additional setup after loading the view.
}









-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    if ([info ifInvolveStr:@"\"result\":\"1\""]) {
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *cookie in [cookieJar cookies]) {
            if ([cookie.name isEqualToString:@"AutoReLogin"]) {
                [userDefaults setValue:cookie.value forKey:@"cookie"];
                break;
            }
        }
		
		NSDictionary * dic = [info JSONValue];
        [userDefaults setObject:[dic objectForKey:@"UserName"] forKey:@"UserName"];
		[userDefaults setObject:[dic objectForKey:@"UserID"] forKey:@"UserID"];		
		[userDefaults setObject:[dic objectForKey:@"NickName"] forKey:@"NickName"];
        [userDefaults setBool:YES forKey:@"ifLogin"];
        [userDefaults synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateLoginState" object:nil];
        [[FirstViewController shareFirstViewCtr] getDataFromService];
        [self dismissModalViewControllerAnimated:YES];
    } else {
        NSDictionary * dic = [NSDictionary dictionaryWithDictionary:[info JSONValue]];
        CustomAlertView * alertView = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:dic[@"msg"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        [alertView release];
    }
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    
}

-(void)sendLoginRequest
{
    if (mpPassword.text.length == 0) {
        [NewItoast showItoastWithMessage:@"昵称不能为空"];
        //        CustomAlertView * alertView = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:@"密码不能为空" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        //        [alertView show];
        //        [alertView release];
        return;
    }
    
    if (mpName.text.length == 0) {
        CustomAlertView * alertView = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:@"昵称不能为空" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        [alertView release];
        return;
    }
    
    
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/User/Login.action"];
    operation.downInfoDelegate = self;
    
    [operation.argumentDic setValue:mpName.text forKey:@"UserName"];
    [operation.argumentDic setValue:[mpPassword.text stringFromMD5] forKey:@"Password"];
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
    [operation release];
}

-(void)__sendLoginRequest
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/User/Login.action"];
    operation.downInfoDelegate = self;
    
    [operation.argumentDic setValue:@"gurdjieff" forKey:@"UserName"];
    [operation.argumentDic setValue:[@"222" stringFromMD5] forKey:@"Password"];
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
    [operation release];
}


-(void)test
{
    NSString * path = @"/User/Login.action";
    void (^onSuccess)(id object, int tag) = ^(id object, int tag) {
        NSLog(@"%@", object);
    };
    
    void (^onFailure)(id object, int tag) = ^(id object, int tag) {
        NSLog(@"%@", object);
    };
    NSDictionary * parameters = @{@"UserName":@"gurdjieff", @"Password":[@"222" stringFromMD5]};
    
    BaseNetWorkClient * client = [[BaseNetWorkClient alloc] init];
    client.path = path;
    client.url = serverIp;
    client.success = onSuccess;
    client.failure = onFailure;
    client.tag = 100;
    [client.parameters setDictionary:parameters];
    [client startRequset];
    [client release];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [mpName resignFirstResponder];
    [mpPassword resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

@end
