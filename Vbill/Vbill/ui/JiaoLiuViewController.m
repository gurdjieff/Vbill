//
//  JiaoLiuViewController.m
//  Examination
//
//  Created by Zhang Bo on 13-8-4.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "JiaoLiuViewController.h"
#import "JiaoLiuCell.h"

#define cellHight 44


@interface JiaoLiuViewController ()

@end

@implementation JiaoLiuViewController

@synthesize LS;
@synthesize theTitle;
@synthesize requestDic;

-(void)dealloc
{
    [cellSourceArr release];
    [requestDic release];
    [theTitle release];
    [super dealloc];
}



-(id)init
{
    return [self initWithNibName:nil bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        cellSourceArr = [[NSMutableArray alloc] init];

        screenHeight = [UIScreen mainScreen].bounds.size.height;
        screenWidth = [UIScreen mainScreen].bounds.size.width;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mpTitleLabel.text = theTitle;
    [self addLeftButton];
    
    
    [self addRightButton];
    [self addSubviews];
    [self sendHttpRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)addRightButton
{
    NSString * title = nil;
    if (LS == xuexijiaoliu) {
        title = @"发表";
    }
    
    UIButton * lpRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth-80,3, 70, 38)];
    [lpRightBtn setTitle:title forState:UIControlStateNormal];
    [lpRightBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [lpRightBtn setBackgroundColor:[UIColor orangeColor]];
    [lpRightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:lpRightBtn];
    [lpRightBtn release];
}


-(void)addSubviews
{
    self.view.backgroundColor = [UIColor colorWithRed:190.0f/255 green:190.0f/255 blue:190.0f/255 alpha:0.6];
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,244,screenWidth,screenHeight-244) style:UITableViewStylePlain];
    myTableView.backgroundView=nil;
    myTableView.backgroundColor=[UIColor grayColor];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    myTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:myTableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        
//    return [cellSourceArr count];
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 2 * cellHight;
}



- (UITableViewCell *)tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    static NSString *CellIdentifier = @"Cell";
    
    
    JiaoLiuCell *cell = [tableViews dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        
        cell=[[[JiaoLiuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    
    
//    NSDictionary * dic =[cellSourceArr objectAtIndex:indexPath.row];
//    
//    cell.timulabel.text =[dic objectForKey:@"Brief"];
//    cell.namelabel.text=[[dic objectForKey:@"User"]objectForKey:@"UserName"];
//    
//    cell.timelabel.text =[dic objectForKey:@"PostDate"];
    
    
    cell.timulabel.text =@"xxxxxxxxxx";
    cell.namelabel.text=@"yyyyyyyyyyy";
    cell.timelabel.text =@"zzzzzzzzzz";

    
    return cell;
}
-(void)sendHttpRequest
{
    
    /*
     
     6.8学习交流回复列表（分页）
     说明：
     请求地址：/Course/ReplyList.action
     
     */
    if (LS == xuexijiaoliu)
    {
        NSString * urlString = nil;
        
        commonDataOperation * operation = [[commonDataOperation alloc] init];
        urlString = @"/Course/ReplyList.action";
        operation.tag = 30010;
        
        operation.urlStr = [serverIp stringByAppendingString:urlString];
        [operation.argumentDic setValue:[requestDic objectForKey:@"GUID"] forKey:@"ReplyID"];
        
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        [mpOperationQueue addOperation:operation];
        [operation release];
    }
    
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    NSLog(@"%s",__func__);
    NSLog(@"%@",info);
}
-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    NSLog(@"%s",__func__);
    NSLog(@"%@",info);
    
    @try {
        
        
        
        //交流回复列表
        
        
        if (tag==30010) {
            NSLog(@"%@",info);
        }
        
        
        
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception reason]);
    }
    @finally {
        ;
    }
    
    
    
}
-(void)FreshDataWithInfo:(NSString *)info with:(NSInteger)tag
{
    NSLog(@"%s",__func__);
    NSLog(@"%@",info);
    
}


@end
