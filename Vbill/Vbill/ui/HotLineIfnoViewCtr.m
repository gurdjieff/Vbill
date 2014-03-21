//
//  HotLineIfnoViewCtr.m
//  Examination
//
//  Created by gurd on 13-7-30.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "HotLineIfnoViewCtr.h"

@interface HotLineIfnoViewCtr ()

@end

@implementation HotLineIfnoViewCtr
@synthesize infoDic = mpInfoDic;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)addWebView
{
    mpWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, appFrameHeigh-44)];
    if (mpInfoDic && mpInfoDic[@"LinkUrl"]) {
        NSString * html = mpInfoDic[@"LinkUrl"];
        NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:html]];
        [mpWebView loadRequest:request];
//        [mpWebView loadHTMLString:html baseURL:nil];
    }
    [mpBaseView addSubview:mpWebView];
    [mpWebView release];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mpTitleLabel.text = @"热点";
    [self addLeftButton];
    [self addWebView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [mpInfoDic release], mpInfoDic = nil;
    [super dealloc];
}

@end
