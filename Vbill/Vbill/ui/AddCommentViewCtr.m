//
//  AddCommentViewCtr.m
//  Examination
//
//  Created by gurdjieff on 13-8-4.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "AddCommentViewCtr.h"
#import "CustomAlertView.h"

@interface AddCommentViewCtr ()

@end

@implementation AddCommentViewCtr
@synthesize infoDic = mpInfoDic;
@synthesize ctrStyle = _ctrStyle;



-(id)init
{
    return [self initWithNibName:nil bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        screenHeight = [UIScreen mainScreen].bounds.size.height;
        screenWidth = [UIScreen mainScreen].bounds.size.width;

    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [mpTextView becomeFirstResponder];
}

-(void)addSubViews
{
    UILabel * lpLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 60, 30)];
    lpLabel.backgroundColor = [UIColor clearColor];
    lpLabel.text = @"笔记";
    [mpBaseView addSubview:lpLabel];
    [lpLabel release];
    
    mpTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 300, appFrameHeigh-44-50)];
    mpTextView.font = [UIFont systemFontOfSize:16];
    //    mpTextView.text = @"人世间，比青春再可宝贵的东西实在没有，然而青春也最容易消逝。最可贵的东西却不甚为人所爱惜，最易消逝的东西却在促进它的消逝。谁能保持得永远的青春的，便是伟大的人。";
    [mpBaseView addSubview:mpTextView];
    [mpTextView release];
}

//request url:http://www.punchbox.org/click/get_vg?country_code=CN&device_type=iPhone&app_id=B3189BF0-BB0F-09E5-0816-6ACCAF994845&os_version=6.1.4&library_version=1.4.3&language_code=zh&lad=0&timestamp=1375846180.429569&api_ver=2&mac_address=786C1CBEBFC3&token=DA4329414FA1FD41E0B964EF98F9EB22&udid=3894d5131d010d1a720a31b313fb0058772940bb&device_name=iPhone5,2&app_version=1.8.10


-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    if ([info ifInvolveStr:@"\"result\":\"1\""]) {
        CustomAlertView * alertView = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:@"提交成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        [alertView release];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    
}

-(void)saveDataToService
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/Remark.action"];
    operation.tag = 102;
    
    if (_ctrStyle==pinglun){
        [operation.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"CourseID"];
        operation.tag = 101;
    }
    
    NSString * info = [NSString stringWithString:mpTextView.text];
    [operation.argumentDic setValue:info forKey:@"Brief"];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
    [operation release];
}


-(void)leftBtnClick
{
//    if (_ctrStyle==pinglun) {
//        [self saveDataToService];
//    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    if (_ctrStyle==pinglun) {
        mpTitleLabel.text = @"发表评论";
    } else {
        mpTitleLabel.text = @"发表交流";
    }
    
    [self addRightButton:@"提交"];
    [self addLeftButton];
    [self addSubViews];
	// Do any additional setup after loading the view.
}

-(void)dealloc
{
    [mpInfoDic release], mpInfoDic = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)addRightButton:(NSString *)title
{
    UIButton * lpRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth-80,3, 70, 38)];
    [lpRightBtn setTitle:title forState:UIControlStateNormal];
    [lpRightBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    lpRightBtn.frame = CGRectMake(320-55, 7, 50, 30);
    [lpRightBtn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [lpRightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:lpRightBtn];
    [lpRightBtn release];
}



-(void)rightBtnClick
{
    [self saveDataToService];
}



@end
