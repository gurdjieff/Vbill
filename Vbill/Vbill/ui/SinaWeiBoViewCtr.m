//
//  SinaWeiBoViewCtr.m
//  Examination
//
//  Created by gurd on 13-8-12.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "SinaWeiBoViewCtr.h"
#import "FirstViewController.h"

@interface SinaWeiBoViewCtr ()

@end

@implementation SinaWeiBoViewCtr

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        NSDictionary * userInfo = [NSDictionary dictionaryWithDictionary:result];
        NSString * name = userInfo[@"name"];
        NSString * userId = [NSString stringWithString:[WeiBoEngine shareWeiboEngine]->sinaweibo.userID];
//        "avatar_large" = "http://tp4.sinaimg.cn/1611499643/180/5673060234/1";
        NSString * avatar_large = userInfo[@"avatar_large"];

//        NSString * accessToken = [NSString stringWithString:[WeiBoEngine shareWeiboEngine]->sinaweibo.accessToken];
        
        commonDataOperation * operation = [[commonDataOperation alloc] init];
        operation.urlStr = [serverIp stringByAppendingFormat:@"/User/AuthLogin.action"];
        operation.downInfoDelegate = self;
        [operation.argumentDic setValue:name forKey:@"UserName"];
        [operation.argumentDic setValue:avatar_large forKey:@"HeadPhotoUrl"];
        [operation.argumentDic setValue:[userId stringFromMD5] forKey:@"Password"];
        operation.isPOST = YES;
        [mpOperationQueue addOperation:operation];
        [operation release];

    }
}


- (void)sinaweiboDidLogIn:(SinaWeibo *)apSinaWeibo
{
    SinaWeibo *sinaweibo = [WeiBoEngine shareWeiboEngine]->sinaweibo;
    [sinaweibo requestWithURL:@"users/show.json"
                                                                               params:[NSMutableDictionary dictionaryWithObject:sinaweibo.userID forKey:@"uid"]
                                                                           httpMethod:@"GET"
                                                                             delegate:self];
}

-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    if ([info ifInvolveStr:@"UserID"]) {
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
        [[self parentViewController] dismissModalViewControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:NO];
    } else {
//        [NewItoast showItoastWithMessage:@""];
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addLeftButton];
    mpTitleLabel.text = @"新浪微博登录";
    mpTitleLabel.font = [UIFont boldSystemFontOfSize:20];
    WeiBoEngine * engine = [WeiBoEngine shareWeiboEngine];
    engine.weiBoDelegate = self;
    [engine->sinaweibo logOut];
    if (![engine->sinaweibo isAuthValid]) {
        [mpBaseView addSubview:[engine->sinaweibo logInView]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
