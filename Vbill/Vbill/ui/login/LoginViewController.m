//
//  LoginViewController.m
//  Examination
//
//  Created by gurdjieff on 13-7-22.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "LoginViewController.h"
#import "NSString+CustomCategory.h"
#import "NewItoast.h"
#import "FirstViewController.h"
#import "AppDelegate.h"


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
    
    UIImageView * lpView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, appFrameHeigh)];
    lpView.image = [UIImage imageNamed:@"login.jpg"];
    [mpBaseView addSubview:lpView];
    
    
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
    
    mpName = [[UITextField alloc] initWithFrame:CGRectMake(lpLabel1.left, 200, textFieldWidth, textFieldHeight)];
    mpName.backgroundColor = [UIColor whiteColor];
    mpName.borderStyle = UITextBorderStyleNone;
    mpName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [mpBaseView addSubview:mpName];
    
    mpPassword = [[UITextField alloc] initWithFrame:CGRectMake(lpLabel1.left, 240, textFieldWidth, textFieldHeight)];
    mpPassword.backgroundColor = [UIColor whiteColor];
    mpPassword.borderStyle = UITextBorderStyleNone;
    mpPassword.secureTextEntry = YES;
    mpPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [mpBaseView addSubview:mpPassword];
    
    
    UIButton * lpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lpBtn.frame = CGRectMake(120, appFrameHeigh-80, 100, 40);
//    [lpBtn setBackgroundImage:[UIImage imageNamed:lpImages[i]] forState:UIControlStateNormal];
    lpBtn.tag = 100;
    [lpBtn setTitle:@"登录" forState:UIControlStateNormal];
    lpBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [lpBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mpBaseView addSubview:lpBtn];
    return;
    
//    NSArray * lpAry = [NSArray arrayWithObjects:@"注册",@"确定", nil];
    NSArray * lpImages = [NSArray arrayWithObjects:@"qq.png",@"sinaWeibo.png",@"registerBtn.png",@"loginBtn.png", nil];
    for (int i = 0; i < 1; i++) {
        UIButton * lpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        lpBtn.frame = CGRectMake(25+i*70, appFrameHeigh-80, 60, 40);
        lpBtn.backgroundColor = [UIColor grayColor];
        [lpBtn setBackgroundImage:[UIImage imageNamed:lpImages[i]] forState:UIControlStateNormal];
        lpBtn.tag = 100+i;
        lpBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [lpBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [mpBaseView addSubview:lpBtn];

    }
}


#pragma mark - Tencent


-(void)btnClick:(UIButton *)btn
{
    if ([mpPassword.text isEqualToString:@"1"]
        && [mpName.text isEqualToString:@"1"]) {
        [self dismissViewControllerAnimated:YES completion:nil];

    }
//    [self sendLoginRequest];
}

-(void)initData
{
    center = mpBaseView.center;
}

-(void)resetMpbaseviewFrame
{
    mpBaseView.frame = CGRectMake(0, 0, 320, appFrameHeigh);
    mpBaseView.backgroundColor = [UIColor clearColor];
    mpBaseView.userInteractionEnabled = YES;
    
    int version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        mpNavitateView.frame = CGRectMake(0, 20, 1024, 44);
        mpBaseView.frame = CGRectMake(0, 20, 320, appFrameHeigh-20);
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self resetMpbaseviewFrame];
    [self initData];
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
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
//        NSDictionary * dic = [NSDictionary dictionaryWithDictionary:[info JSONValue]];
//        CustomAlertView * alertView = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:dic[@"msg"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alertView show];
//        [alertView release];
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
//        CustomAlertView * alertView = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:@"昵称不能为空" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alertView show];
//        [alertView release];
        return;
    }
    
    
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/User/Login.action"];
    operation.downInfoDelegate = self;
    
    [operation.argumentDic setValue:mpName.text forKey:@"UserName"];
    [operation.argumentDic setValue:[mpPassword.text stringFromMD5] forKey:@"Password"];
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
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
}

@end
