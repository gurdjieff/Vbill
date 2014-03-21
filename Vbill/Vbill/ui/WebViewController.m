//
//  WebViewController.m
//  Examination
//
//  Created by Zhang Bo on 13-7-13.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "WebViewController.h"
#import "AppDelegate.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize LS;
@synthesize theTitle;
@synthesize theGuid = _theGuid;
@synthesize theUrl  = _theUrl;
-(void)dealloc
{
    [_theGuid release];
    [_theUrl release];
    [theTitle release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = mySetColor;
    
    mpTitleLabel.text = theTitle;
    [self addLeftButton];
    [self addWebView];
    
    
    if (LS == mingjiajiangtang){
        [self addRightBtn];
    }
    [self getDataFromService];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)rightBtnClick
{
    
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if ([appDelegate.dicData allValues] == 0) {
        [appDelegate sendInitialInfo];
        
    }else
        {
        
        NSString * phone =[appDelegate.dicData objectForKey:@"HotLine"];
			
			
			if (phone!=nil) {
				
				NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phone]];
				
				[[UIApplication sharedApplication] openURL:url];
			}
			
      
        
        
        }
}


-(void)addRightBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(320-85, 7, 80, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [btn setTitle:@"我要报名" forState:UIControlStateNormal];
	[btn.titleLabel setFont:myFont];

    [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:btn];
}



-(void)addWebView
{
    contentWebView=[[UIWebView alloc]initWithFrame:CGRectMake(5, 44, screenWidth-10,screenHeight-44)];
    contentWebView.delegate = self;
	contentWebView.dataDetectorTypes = UIDataDetectorTypeNone;
    contentWebView.opaque = NO;
	contentWebView.scrollView.bounces =YES;
    contentWebView.backgroundColor =[UIColor clearColor];
	[self.view addSubview:contentWebView];
	[contentWebView release];
}



#pragma mark - WebService



-(void)getDataFromService
{
    
    if (LS ==tuijianurl) {
        NSURL * url = [NSURL URLWithString:_theUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [contentWebView loadRequest:request];
        return;
    }
    
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    if (LS == mingjiajiangtang)
    {
        operation.urlStr = [serverIp stringByAppendingString:@"/Application/TeacherView.action"];
        operation.tag = 30002;

    }
    if (LS == xuexiaoxinxi)
    {
        operation.urlStr = [serverIp stringByAppendingString:@"/Application/SchoolView.action"];
        operation.tag = 30004;

    }
    [operation.argumentDic setValue:_theGuid forKey:@"GUID"];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [[Common getOperationQueue] addOperation:operation];
    [operation release];
    
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
   
}
-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{    
    NSString * content =[[info JSONValue] objectForKey:@"Detail"];
    [contentWebView loadHTMLString:content baseURL:nil];
     
}
-(void)FreshDataWithInfo:(NSString *)info with:(NSInteger)tag
{

    
}



@end
