//
//  BaseViewController.m
//  Examination
//
//  Created by gurd on 13-6-23.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"
#import "iLoadAnimationView.h"
#import "Common.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


-(id)init
{
    return [self initWithNibName:nil bundle:nil];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        mpOperationQueue = [[NSOperationQueue alloc] init];
        // Custom initialization
        screenHeight = [UIScreen mainScreen].bounds.size.height;
        screenWidth = [UIScreen mainScreen].bounds.size.width;
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [iLoadAnimationView stopLoadAnimation];
}

-(void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addLeftButton
{
    UIButton * lpLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [lpLeftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [lpLeftBtn setBackgroundImage:[UIImage imageNamed:@"navigateBack.png"] forState:UIControlStateNormal];
    [mpNavitateView addSubview:lpLeftBtn];
}

-(void)addBaseSubviews
{
    mpNavitateView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    mpNavitateView.image = [UIImage imageNamed:@"navigatebar2.png"];
    [self.view addSubview:mpNavitateView];
    mpNavitateView.userInteractionEnabled = YES;
    
    mpTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 0, 320-44*2, 44)];
//    mpTitleLabel.numberOfLines = 0;
//    mpTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    mpTitleLabel.backgroundColor = [UIColor clearColor];
    mpTitleLabel.textColor = [UIColor whiteColor];
    mpTitleLabel.textAlignment = NSTextAlignmentCenter;
    mpTitleLabel.font = [UIFont boldSystemFontOfSize:20];
    [mpNavitateView addSubview:mpTitleLabel];
    
    mpBaseView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, appFrameHeigh-44)];
    mpBaseView.userInteractionEnabled = YES;
    [self.view addSubview:mpBaseView];
    
    int version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        mpNavitateView.frame = CGRectMake(0, 20, 1024, 44);
        mpBaseView.frame = CGRectMake(0, mpNavitateView.buttom, 320, appFrameHeigh-44);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self addBaseSubviews];
	self.view.backgroundColor = cellBackColor;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    for (commonDataOperation * opertation in [mpOperationQueue operations]) {
        opertation.downInfoDelegate = nil;
    }
    [mpOperationQueue cancelAllOperations];
}

@end
