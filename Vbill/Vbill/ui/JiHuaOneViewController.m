//
//  JiHuaOneViewController.m
//  Examination
//
//  Created by Zhang Bo on 13-7-13.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "JiHuaOneViewController.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"

@interface JiHuaOneViewController ()

@end

@implementation JiHuaOneViewController
@synthesize theTitle = _theTitle;
@synthesize infoDic = _infoDic;
@synthesize delegete;
@synthesize guidString = _guidString;
@synthesize mpDataAry = _mpDataAry;
@synthesize tableView = _tableView;


-(void)dealloc
{
    [imageArray release];
    [_tableView release],_tableView = nil;
    [_mpDataAry release];
    [titileArray release];
	[_guidString release];
    [_infoDic release];
    [_theTitle release];
    [super dealloc];
}



- (id)init
{
    return [self initWithNibName:nil bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
        titileArray =@[@"计划描述:",@"选择科目:",@"开始时间:",@"结束时间:",@"每天学习了多少个知识点:",@"完成现状:"];
        [titileArray retain];
        
        
        imageArray = @[@"jihuamiaoshu.png",@"xuanzekemu.png",@"kaishishijian.png",@"jieshushijian.png",@"zhishidian.png",@"wanchengxianzhuang.png"];
        [imageArray retain];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mpTitleLabel.text = _theTitle;

    self.view.backgroundColor =[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    [self addLeftButton];
	[self addSubviews];
    [self addTableFootView];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)leftBtnClick
{
    [delegete refreshJiHua:NO];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)addSubviews
{
    
    UITableView * mpTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, appFrameHeigh-44) style:UITableViewStylePlain];
    mpTableView.backgroundView = nil;
    mpTableView.tag = 101;
    mpTableView.showsVerticalScrollIndicator = NO;
    mpTableView.delegate = self;
    mpTableView.dataSource = self;
    mpTableView.separatorColor = [UIColor clearColor];
    mpTableView.backgroundColor = cellBackColor;
    mpTableView.rowHeight = 55;
    [self.view addSubview:mpTableView];
    self.tableView = mpTableView;
    [mpTableView release];

}

-(void)addTableFootView
{
    UIView * view =[[UIView alloc] init];
    [view setFrame:CGRectMake(0, 0, 300, 120)];
    [view setBackgroundColor:[UIColor clearColor]];
    self.tableView.tableFooterView = view;
    
    
    int count =[_infoDic[@"Count"] intValue];
    
    int studycount =[_infoDic[@"StudyCount"] intValue];
    
    
    NSString * aStr =[NSString stringWithFormat:@"%d",studycount];
    NSString * bStr =[NSString stringWithFormat:@"%d",count-studycount];
    
    NSString * str =[NSString stringWithFormat:@"你已经学习了%d个知识点,还剩下%d个,加油!",studycount,count-studycount];
    
	NSMutableAttributedString* attrStr = [NSMutableAttributedString attributedStringWithString:str];
	[attrStr setFont:[UIFont systemFontOfSize:15]];
	[attrStr setTextColor:[UIColor grayColor]];
    
	[attrStr setTextColor:[UIColor greenColor] range:[str rangeOfString:aStr]];
	[attrStr setTextColor:[UIColor redColor] range:[str rangeOfString:bStr]];
    OHAttributedLabel * label =[[OHAttributedLabel alloc] init];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFrame:CGRectMake(5, 5, 310, 60)];
	label.attributedText = attrStr;
	label.lineBreakMode = UILineBreakModeCharacterWrap;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:label];
    [label release];
    
    [view release];

    
}

#pragma mark - WebService


-(void)getDataFromService
{
	commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/User/StudyPlanView.action"];
	[operation.argumentDic setObject:_guidString forKey:@"GUID"];
    operation.downInfoDelegate = self;
    operation.tag = 101;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
    [operation release];
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
}

-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    
    NSString * result = [[info JSONValue] objectForKey:@"result"];
    
    if ([result isEqualToString:@"1"])
	{
		self.infoDic =[info JSONValue];
		[self.tableView reloadData];
    }
    
}
-(void)FreshDataWithInfo:(NSString *)info with:(NSInteger)tag
{
	
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titileArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * identify = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
		cell.accessoryType = UITableViewCellAccessoryNone;
        
        UIImageView * imagevew =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellcontent.png"]];
        [imagevew setFrame:CGRectMake(5, 5, 310, 51)];
        [cell.contentView addSubview:imagevew];
        [imagevew release];
        
        UIImageView* imageview=[[UIImageView alloc]
                                  initWithImage:[UIImage imageNamed:imageArray[indexPath.row]]];
        imageview.frame=CGRectMake(10, 15, 19, 19);
        [[cell contentView] addSubview:imageview];
        [imageview release];
        
        
        UILabel * leftlabel =[[UILabel alloc] init];
        [leftlabel setFont:[UIFont systemFontOfSize:14]];
        [leftlabel setTextColor:[UIColor blackColor]];
        [leftlabel setBackgroundColor:[UIColor clearColor]];
        [leftlabel setTextAlignment:NSTextAlignmentLeft];
        [leftlabel setText:titileArray[indexPath.row]];
       
        [[cell contentView]  addSubview:leftlabel];
        
        
        
        UILabel * rightlabel =[[UILabel alloc] init];
        [rightlabel setFont:[UIFont systemFontOfSize:14]];
        [rightlabel setTextColor:[UIColor orangeColor]];
        [rightlabel setBackgroundColor:[UIColor clearColor]];
        [rightlabel setTextAlignment:NSTextAlignmentRight];
        [[cell contentView]  addSubview:rightlabel];
        [rightlabel setTag:20131111+indexPath.row];
        
        
        
        if (indexPath.row!=4) {
            [leftlabel setFrame:CGRectMake(35, 10, 100, 30)];
            [rightlabel setFrame:CGRectMake(140, 10, 160, 30)];

        }else
        {
            [leftlabel setFrame:CGRectMake(35, 10, 160, 30)];
            [rightlabel setFrame:CGRectMake(200, 10, 100, 30)];

        }
        
        [leftlabel release];

        [rightlabel release];


    }

    
    
    [self configureCell:cell atIndexPath:indexPath];
    
    
    
    
    return cell;
}


- (void)configureCell:( UITableViewCell *)cell
		  atIndexPath:(NSIndexPath *)indexPath
{
    
    
    UILabel * label =(UILabel *)[[cell contentView] viewWithTag:20131111+indexPath.row];
    
    
    switch (indexPath.row) {
        case 0:
        {
            [label setText:_infoDic[@"Brief"]];

        }
            break;
        case 1:
        {
            [label setText:_infoDic[@"Name"]];

        }
            break;
        case 2:
        {
            NSArray * tmpArr =[[_infoDic objectForKey:@"StartDate"] componentsSeparatedByString:@" "];
            label.text =tmpArr[0];
        }
            break;
        case 3:
        {
            NSArray * tmpArr =[[_infoDic objectForKey:@"CompleteDate"] componentsSeparatedByString:@" "];
            label.text =tmpArr[0];
        }
            break;
        case 4:
        {
            label.text = _infoDic[@"StudyCount"];

        }
            break;
        case 5:
        {
            label.text = _infoDic[@"Status"];
        }
            break;
        
            
            
        default:
            break;
    }
    
 
    
}


@end
