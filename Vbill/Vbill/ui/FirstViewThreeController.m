//
//  FirstViewThreeController.m
//  Examination
//
//  Created by gurdjieff on 13-7-19.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "FirstViewThreeController.h"
#import "NSString+CustomCategory.h"
#import "RemarkViewCtr.h"
#import "FirstViewCommentCtr.h"
#import "PredictTestViewCtr.h"
#import "AlixPayOrder.h"
#import "DataSigner.h"
#import "AlixPay.h"
#import "RemarkViewController.h"
#import "PaymentAssistant.h"
#import "DownloadManager.h"

#define menuHeigh 80
@interface FirstViewThreeController ()

@end

@implementation FirstViewThreeController
@synthesize infoDic = mpInfoDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)rightBtnClick
{
//    [self payTest];
//    return;
    if (mpImageBackView.frame.origin.y == 0.0) {
        [UIView animateWithDuration:0.5 animations:^{
            mpImageBackView.frame = CGRectMake(320-105, 0-200, 100, menuHeigh);
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            mpImageBackView.frame = CGRectMake(320-105, 0, 100, menuHeigh);
        }];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}


-(void)addRightBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(320-45, 5, 40, 35);
    [btn setBackgroundImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:btn];
}

-(void)addMenuViews
{
    mpImageBackView = [[UIImageView alloc] initWithFrame:CGRectMake(320-105, 0-200, 100, menuHeigh)];
    mpImageBackView.userInteractionEnabled = YES;
    mpImageBackView.image = [UIImage imageNamed:@"bumpRect201.png"];
    [mpBaseView addSubview:mpImageBackView];
    [mpImageBackView release];
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(4, 11, 92, 30);
    [btn1 setTitle:@"测评" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    [btn1 setBackgroundImage:[UIImage imageNamed:@"btnWhite.png"] forState:UIControlStateNormal];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"btnYellow.png"] forState:UIControlStateHighlighted];
    
    btn1.tag = 101;
    [btn1 addTarget:self action:@selector(memuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mpImageBackView addSubview:btn1];
    
    UIImageView * lpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, btn1.buttom, 94, 2)];
    lpImageView.image = [UIImage imageNamed:@"purpleback.png"];
    [mpImageBackView addSubview:lpImageView];
    [lpImageView release];
    
    
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(4, 47, 92, 30);
    [btn2 setTitle:@"写笔记" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    [btn2 setBackgroundImage:[UIImage imageNamed:@"btnWhite.png"] forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"btnYellow.png"] forState:UIControlStateHighlighted];
    
    btn2.tag = 102;
    [btn2 addTarget:self action:@selector(memuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mpImageBackView addSubview:btn2];
    
    
//    UIButton * btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn3.frame = CGRectMake(5, 82, 91, 29);
//    [btn3 setTitle:@"评论" forState:UIControlStateNormal];
//    [btn3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    btn3.titleLabel.font = [UIFont boldSystemFontOfSize:20];
//    [btn3 setBackgroundImage:[UIImage imageNamed:@"btnWhite.png"] forState:UIControlStateNormal];
//    [btn3 setBackgroundImage:[UIImage imageNamed:@"btnYellow.png"] forState:UIControlStateHighlighted];
//    
//    btn3.tag = 103;
//    [btn3 addTarget:self action:@selector(memuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [mpImageBackView addSubview:btn3];
    
//    UIButton * btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn4.frame = CGRectMake(5, 117, 91, 30);
//    [btn4 setTitle:@"打分" forState:UIControlStateNormal];
//    [btn4 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    btn4.titleLabel.font = [UIFont boldSystemFontOfSize:20];
//    [btn4 setBackgroundImage:[UIImage imageNamed:@"btnWhite.png"] forState:UIControlStateNormal];
//    [btn4 setBackgroundImage:[UIImage imageNamed:@"btnYellow.png"] forState:UIControlStateHighlighted];
//    
//    btn4.tag = 104;
//    [btn4 addTarget:self action:@selector(memuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [mpImageBackView addSubview:btn4];
    
    [self.view bringSubviewToFront:mpNavitateView];
}

-(void)memuBtnClick:(UIButton *)btn
{
    [UIView animateWithDuration:0.5 animations:^{
        mpImageBackView.frame = CGRectMake(320-105, 0-200, 100, menuHeigh);
    }];

    if (btn.tag == 101) {
        PredictTestViewCtr * lpViewCtr = [[PredictTestViewCtr alloc] init];
        lpViewCtr.infoDic = mpInfoDic;
		lpViewCtr.theTitle = [mpInfoDic objectForKey:@"Name"];
        lpViewCtr.testType = 0;
        [self.navigationController pushViewController:lpViewCtr animated:YES];
        [lpViewCtr release];
    } else if (btn.tag == 102) {
        
        
//        RemarkViewCtr * lpViewCtr = [[RemarkViewCtr alloc] init];
//        lpViewCtr.hidesBottomBarWhenPushed = YES;
//        lpViewCtr.infoDic = mpInfoDic;
//        [self.navigationController pushViewController:lpViewCtr animated:YES];
//        [lpViewCtr release];
        
        RemarkViewController * lpViewCtr = [[RemarkViewController alloc] init];
        lpViewCtr.hidesBottomBarWhenPushed = YES;
        lpViewCtr.infoDict = mpInfoDic;
        lpViewCtr.myStyle = duqu;
        [self.navigationController pushViewController:lpViewCtr animated:YES];
        [lpViewCtr release];
        
        
    } else if (btn.tag == 103) {
		
        FirstViewCommentCtr * lpViewCtr = [[FirstViewCommentCtr alloc] init];
        lpViewCtr.hidesBottomBarWhenPushed = YES;
        lpViewCtr.infoDic = mpInfoDic;
		lpViewCtr.ctrStyle = pinglun;
        [self.navigationController pushViewController:lpViewCtr animated:YES];
        [lpViewCtr release];
    } else if (btn.tag == 104) {
        [UIView animateWithDuration:0.5 animations:^{
            mpScoredView.alpha = 1.0;
        } completion:^(BOOL f){
            mpScoredView.userInteractionEnabled = YES;
        }];
    }
}

-(void)playMovie:(NSString *)apUrl
{
    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"girl" ofType:@"mp4"];
    //    AVQueuePlayer *
    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"rmvb"];
    //    NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePath];
    //    AVAsset *movieAsset	= [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    //    NSString *file = [[NSString alloc] initWithFormat:@"http://devimages.apple.com/samplecode/adDemo/ad.m3u8"];
    //    NSString *file = [[NSString alloc] initWithFormat:@"http://116.90.86.104/Course/Media.action?GUID=64df1be2-9463-4bc0-bd12-7e90793f4106"];
    
    //    NSString *file = [[NSString alloc] initWithFormat:@"http://www.bj5800.com/upload/video/17.mp4"];
    
    //    http://www.bj5800.com/upload/video/17.mp4
    NSURL *url = [[NSURL alloc] initWithString:apUrl];
    AVURLAsset *movieAsset = [AVURLAsset assetWithURL:url];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = CGRectMake(0, 0, 480, 320);
    playerLayer.backgroundColor = [UIColor blackColor].CGColor;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:playerLayer];
    [player play];
    [url release];
}

-(void)paymentWithInfo:(NSString *)Info
{
//   {"result":"1","OrderID":"BD492F94AEA3361199E39C4F793F130E","PayUrl":"http://116.90.86.104:80/Trade/PayOrder.action?OrderID=BD492F94AEA3361199E39C4F793F130E","Total":"0.10"}
    NSDictionary * dic = [NSDictionary dictionaryWithDictionary:[Info JSONValue]];
    NSString * OrderID = dic[@"OrderID"];
    NSString * Total = dic[@"Total"];
    
    NSString *partner = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Partner"];
    NSString *seller = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Seller"];
    
//    NSString *partner = @"2088701267214415";
//    NSString *seller = @"2088701267214415";
    
	AlixPayOrder *order = [[AlixPayOrder alloc] init];
	order.partner = partner;
	order.seller = seller;

	order.tradeNO = OrderID;  //订单ID（由商家自行制定）
    order.productName = @"course";         //@"买的一大堆商品";        //商品标题
//	order.productDescription =  productDesc; //@"好东西呀,便宜！杠杠的";   //商品描述
    order.productDescription =  @"888"; //@"好东西呀,便宜！杠杠的";   //商品描述
    order.amount = [NSString stringWithFormat:@"0.01"];    //商品价格，测试数据，改成了一分
    order.amount = Total;  
	order.notifyURL = [serverIp stringByAppendingString:@"/Trade/PayCallback.action"];
//
//	//将商品信息拼接成字符串
	NSString *orderSpec = [order description];
	NSLog(@"orderSpec = %@",orderSpec);
//
//	//获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    
	id<DataSigner> signer = CreateRSADataSigner([[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA private key"]);
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);

	NSString *signedString = [signer signString:orderSpec];
	[order release];
	//将签名成功字符串格式化为订单字符串,请严格按照该格式
	NSString *orderString = nil;
	if (signedString != nil) {
		orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderSpec, signedString, @"RSA"];
	}

	//获取安全支付单例并调用安全支付接口
    AlixPay * alixPay = [AlixPay shared];
	int ret = [alixPay pay:orderString applicationScheme:@"Examination"];
	if (ret == kSPErrorAlipayClientNotInstalled) {
        //没有安装支付宝客户端
	} else if (ret == kSPErrorSignError) {
		NSLog(@"签名错误！");
	}
}



-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    
//    return;
    
    if (tag==100) {
        
        
        if ([info ifInvolveStr:@"result"]) {
            
            NSDictionary * tempDic = [[NSDictionary alloc] initWithDictionary:[info JSONValue]];
            if ([tempDic[@"result"] intValue] == 1) {
                //                NSString * lpName = tempDic[@"Name"];
                NSString * lpBrief = tempDic[@"Brief"];
                NSString * lpDetail = tempDic[@"Detail"];
                NSString * lpMediaUrl = tempDic[@"MediaUrl"];
                //                NSString * Payed = tempDic[@"Payed"];
                //                if ([Payed isEqualToString:@"False"]) {
                //                    [self getPaymentInfo];
                //                }
                
				NSString * htmlTwo = nil;
                
				
				if (lpMediaUrl!=nil) {
                    
                    
                    NSArray * strArray =[lpMediaUrl componentsSeparatedByString:@"="];
                    
                    NSString * movieName =[strArray lastObject];
                    
                    BOOL isDownload =[DownloadHelper readDataFromSqlite:movieName];
                    
                    if (!isDownload)
                    {
                        
                        [DownloadHelper writeDataToSqlite:movieName with:@"no"];
                        
                        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@.mp4",lpMediaUrl]];
                        DownloadManager *dm = [[DownloadManager alloc] initWithURL:url];
                        dm.imageName = [NSString stringWithFormat:@"%@.mp4",movieName];
                        [dm start];
                        [dm release];
                        
                    }
                    else
                    {
                        
                        NSString * path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                        movieName = [NSString stringWithFormat:@"%@.mp4",movieName];
                        path =[path stringByAppendingPathComponent:movieName];
                        lpMediaUrl =[NSString stringWithFormat:@"file://%@",path];
                        
                    }
                    
                    
					htmlTwo = [NSString stringWithFormat:@"<body><section class=\"introduction\"><h3>简介</h3><div>%@</div></section><section class=\"video\"><video width=\"312\" height=\"234\" controls=\"controls\"><source type=\"video/ogg\" src=\"%@\"><source type=\"video/mp4\" src=\"%@\">您的浏览器不支持该标签.</video></section><section class=\"detail\"><h3>详情</h3><div>%@</div></section></body>", lpBrief, lpMediaUrl, lpMediaUrl, lpDetail];
				}
				
				else
				{
					htmlTwo = [NSString stringWithFormat:@"<body><section class=\"introduction\"><h3>简介</h3><div>%@</div></section><section class=\"detail\"><h3>详情</h3><div>%@</div></section></body>", lpBrief, lpDetail];
				}
                
				NSString * path =[[NSBundle mainBundle] pathForResource:@"thirdViewo1" ofType:@"html"];
                NSMutableString * htmlStr =[[NSMutableString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
                [htmlStr appendFormat:@"%@%@</html>", htmlStr, htmlTwo];
                [mpWebView loadHTMLString:htmlStr baseURL:nil];
                [htmlStr release];
            }
            [tempDic release];
        }
    }
    
    
    else if (tag == 101) {
        if ([info ifInvolveStr:@"\"result\":\"1\""]) {
            [NewItoast showItoastWithMessage:@"打分成功"];
        } else {
            [NewItoast showItoastWithMessage:@"操作失败"];
        }
        
    }
    
    
    else if (tag == 103) {
        if ([info ifInvolveStr:@"\"result\":\"1\""]) {
            NSString * pointStr = [info JSONValue][@"Point"];
            int point = [pointStr intValue];
            for (int i = 0; i < point; i++) {
                UIButton * btn = (UIButton *)[mpScoredView viewWithTag:101 + i];
                [btn setBackgroundImage:[UIImage imageNamed:@"yellowStar.png"] forState:UIControlStateNormal];
                btn.selected = YES;
            }

        }
    }
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    
}

-(void)getPaymentInfo
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/Pay.action"];
    [operation.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"GUID"];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    operation.tag = 300;
    [mpOperationQueue addOperation:operation];
    [operation release];
}

-(void)getDataFromService
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.useCache = YES;
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/KnowledgeView.action"];
    [operation.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"GUID"];
    operation.downInfoDelegate = self;
    operation.tag =100;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
    [operation release];
    
    
    return;
    
    commonDataOperation * operation2 = [[commonDataOperation alloc] init];
    operation2.useCache = YES;
    operation2.urlStr = [serverIp stringByAppendingFormat:@"/Course/GetPoint.action"];
    [operation2.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"GUID"];
    operation2.downInfoDelegate = self;
    operation2.tag = 103;
    operation2.isPOST = YES;
    [mpOperationQueue addOperation:operation2];
    [operation2 release];

}

-(void)getVideoData
{
    NSString * mediastr = [contentDict objectForKey:@"GUID"];
    NSString * guidstr =[contentDict objectForKey:@"MediaUrl"];
    NSLog(@"%@ %@",mediastr,guidstr);
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/Media.action"];
    [operation.argumentDic setValue:guidstr forKey:@"GUID"];
    operation.downInfoDelegate = self;
    operation.tag =101;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
    [operation release];
    
}

-(void)initData
{
    mpDictionary = [[NSMutableDictionary alloc] init];
    contentDict = [[NSMutableDictionary alloc] init];
}

-(void)addWebView
{
    mpWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, appFrameHeigh-44)];
    mpWebView.delegate = self;
    [mpBaseView addSubview:mpWebView];
    [mpWebView release];
    

}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //    [mpWebView stringByEvaluatingJavaScriptFromString:@""];
}


-(void)scoredBtnClick
{
    int number = 0;
    for (int i = 0; i < 5; i++) {
        UIButton * btn = (UIButton *)[mpScoredView viewWithTag:101 + i];
        if (btn.selected) {
            number += 1;
        }
    }
    
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/Point.action"];
    [operation.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"CourseID"];
    [operation.argumentDic setValue:[NSString stringWithFormat:@"%d", number] forKey:@"Point"];
    
    
    operation.downInfoDelegate = self;
    operation.tag = 101;
    operation.isPOST = YES;
    operation.showAnimation = NO;
    [mpOperationQueue addOperation:operation];
    [operation release];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        mpScoredView.alpha = 0.0;
    } completion:^(BOOL f){
        mpScoredView.userInteractionEnabled = NO;
    }];
    
}

-(void)resetTitle
{
    //    return;
    //    int number = 0;
    //    for (int i = 0; i < 5; i++) {
    //        UIButton * btn = (UIButton *)[mpFootView2 viewWithTag:101 + i];
    //        if (btn.selected) {
    //            number += 1;
    //        }
    //    }
    //    mpLabel.text = [NSString stringWithFormat:@"%d星",number];
}


-(void)starBtnClick:(UIButton *)apBtn
{
    for (int i = 0; i < 5; i++) {
        UIButton * btn = (UIButton *)[mpScoredView viewWithTag:101 + i];
        [btn setBackgroundImage:[UIImage imageNamed:@"whiteStar.png"] forState:UIControlStateNormal];
        btn.selected = NO;
    }
    
    for (int i = 0; i <= apBtn.tag - 101; i++) {
        UIButton * btn = (UIButton *)[mpScoredView viewWithTag:101 + i];
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowStar.png"] forState:UIControlStateNormal];
        btn.selected = YES;
    }
}


-(void)addScoredView
{
    mpScoredView = [[UIView alloc] initWithFrame:CGRectMake(20, 80, 280, 160)];
    UIView * lpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 70)];
    lpView.backgroundColor = [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:0.98];
    [mpScoredView addSubview:lpView];
    [lpView release];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
    label.textColor = [UIColor colorWithRed:0x58/255.0f green:0x42/255.0f blue:0x2e/255.0f alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.text = @"打分";
    [lpView addSubview:label];
    [label release];
    
    for (int i = 0; i < 5; i++) {
        UIButton * lpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        lpBtn.frame = CGRectMake(38 + i * 45, 30, 26, 26);
        [lpBtn setBackgroundImage:[UIImage imageNamed:@"whiteStar.png"] forState:UIControlStateNormal];
        lpBtn.tag = 101 + i;
        lpBtn.selected = NO;
        [lpBtn addTarget:self action:@selector(starBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [mpScoredView addSubview:lpBtn];
    }
    
    
    
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(100, 100, 80, 40);
    submitBtn.tag = 200;
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [submitBtn addTarget:self action:@selector(scoredBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpScoredView addSubview:submitBtn];
    
    [mpBaseView addSubview:mpScoredView];
    [mpScoredView release];
    
    mpScoredView.userInteractionEnabled = NO;
    mpScoredView.alpha = 0.0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mpTitleLabel.text = [mpInfoDic objectForKey:@"Name"];
    [self addLeftButton];
    [self addRightBtn];
    [self addWebView];
    [self addMenuViews];
    [self addScoredView];
    [self getDataFromService];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [contentDict release], contentDict = nil;
    [mpInfoDic release], mpInfoDic = nil;
    [super dealloc];
}




-(void)loadVideo
{
    
    //    NSString * path =[[NSBundle mainBundle] pathForResource:@"video.html" ofType:nil];
    NSString * path =[[NSBundle mainBundle] pathForResource:@"zhangdaiyu" ofType:@"html"];
    NSString * htmlStr =[[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //    NSString * str =[serverIp stringByAppendingFormat:@"%@",[contentDict objectForKey:@"MediaUrl"]];
    // http://114.113.155.86:80/Course/Media.action?GUID=64df1be2-9463-4bc0-bd12-7e90793f4106
    //    NSString * mediastr =[NSString stringWithString:str];
    //    mediastr = @"http://www.bj5800.com/upload/video/17.mp4";
    //    NSString * contentStr =[NSString stringWithFormat:htmlStr,mediastr];
    
    
    //    [mpWebView loadHTMLString:htmlStr baseURL:nil];
    
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://114.113.155.86:80/Course/Media.action?GUID=64df1be2-9463-4bc0-bd12-7e90793f4106"];
    NSURLRequest* urlResquest = [NSURLRequest requestWithURL:url];
    [mpWebView loadRequest:urlResquest];
    [htmlStr release];
}

- (BOOL) shouldAutorotate {
    return YES;
}



@end
