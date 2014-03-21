//
//  FeedBackViewCtr.m
//  Examination
//
//  Created by gurdjieff on 13-8-12.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "FeedBackViewCtr.h"

@interface FeedBackViewCtr ()

@end

@implementation FeedBackViewCtr

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [mpTextView becomeFirstResponder];
}


-(void)addSubViews
{
//    UILabel * lpLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 60, 30)];
//    lpLabel.backgroundColor = [UIColor clearColor];
//    lpLabel.text = @"笔记";
//    lpLabel.textColor = [UIColor colorWithRed:0x58/255.0f green:0x42/255.0f blue:0x2e/255.0f alpha:1.0];
    
    
//    [mpBaseView addSubview:lpLabel];
//    [lpLabel release];
    
    mpTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 300, appFrameHeigh-30-44)];
    mpTextView.font = [UIFont systemFontOfSize:16];
    //    mpTextView.text = @"人世间，比青春再可宝贵的东西实在没有，然而青春也最容易消逝。最可贵的东西却不甚为人所爱惜，最易消逝的东西却在促进它的消逝。谁能保持得永远的青春的，便是伟大的人。";
    [mpBaseView addSubview:mpTextView];
    [mpTextView release];
}

-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    if ([info ifInvolveStr:@"\"result\":\"1\""]) {
        [NewItoast showItoastWithMessage:@"提交成功"];
    }
    
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    
}

-(void)saveDataToService
{
    if (mpTextView.text.length == 0) {
        [NewItoast showItoastWithMessage:@"内容不能为容"];
        return;
    }
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/System/Feedback.action"];
    operation.tag = 101;
    NSString * info = [NSString stringWithString:mpTextView.text];
    
//    if (info.length == 0) {
//        [operation.argumentDic setValue:mpRemarkDic[@"GUID"] forKey:@"GUID"];
//    }
    [operation.argumentDic setValue:info forKey:@"Brief"];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
    [operation release];
}

-(void)rightBtnClick
{
    [self saveDataToService];
}

-(void)addRightBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(320-55, 7, 50, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [btn setTitle:@"发表" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:btn];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addLeftButton];
    mpTitleLabel.text = @"意见反馈";
    [self addRightBtn];
    [self addSubViews];
	// Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [mpTextView resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
