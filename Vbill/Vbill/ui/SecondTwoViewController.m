//
//  SecondTwoViewController.m
//  Examination
//
//  Created by Zhang Bo on 13-7-3.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "SecondTwoViewController.h"
#import "CuoTiCell.h"
#import "FirstViewController.h"
#import "FirstViewController.h"
#import "PredictTestViewCtr.h"
#import "FirstTableViewCell.h"


#define cellHight 48


@interface SecondTwoViewController ()


@end

@implementation SecondTwoViewController
@synthesize theTitle = _theTitle;
@synthesize textField = _textField;
@synthesize LS;
@synthesize infoDict;
- (void)dealloc
{
    [infoDict release];
    [_theTitle release];
	[_textField release];
    [cellSourceArr release];
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
        
        cellSourceArr = [[NSMutableArray alloc] init];

        
    }
    return self;
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    mpTitleLabel.text = _theTitle;
    [self addLeftButton];
    [self addSubViews];
    [self addFreshView];
    [self getDataFromService];
}



-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	if (LS==cuotizhongxin) {
		[self getDataFromService];
	}
}



- (void)addSubViews
{
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,44,screenWidth,screenHeight-64) style:UITableViewStylePlain];
    myTableView.separatorColor = [UIColor clearColor];
    myTableView.backgroundColor = cellBackColor;
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [self.view addSubview:myTableView];
	
	
	UILabel * mpLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, screenWidth-20, 30)];
    mpLabel1.backgroundColor = [UIColor clearColor];
    mpLabel1.font = [UIFont boldSystemFontOfSize:16];
	[mpLabel1 setTextAlignment:NSTextAlignmentCenter];
    mpLabel1.textColor = [UIColor grayColor];
	self.textField = mpLabel1;
    [self.view addSubview:mpLabel1];
    [mpLabel1 release];
	
	[self.view sendSubviewToBack:self.textField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (LS == zhentiyanlian
        || LS ==monikaoshi)
    {
        NSArray * topArr =[FirstViewController getOriginalDataAry];
        return [topArr count];
    }
    
    else
        return [cellSourceArr count];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHight;
}



- (UITableViewCell *)tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    static NSString *CellIdentifier = @"Cell";
       
    if (LS ==cuotizhongxin)
    {
        
        CuoTiCell * cell = [tableViews dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil)
        {
            
            cell=[[[CuoTiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleGray;
            
        }
        
        
        
        NSDictionary * dic =cellSourceArr[indexPath.row];
        
        
        cell.timulabel.text =dic[@"Name"];
        
        NSArray * textArr =[dic[@"PostDate"]componentsSeparatedByString:@" "];
        
        cell.timelabel.text =textArr[0];
        
        NSString * fenshuStr =[NSString stringWithFormat:@"%@/%@",dic[@"Count"],dic[@"Total"]];
        cell.zhishilabel.text =fenshuStr;
        
        
                
        return cell;
        
    }
    
    
    else if(LS ==zhentiyanlian
            || LS == monikaoshi)
    {
        NSString * identify = @"cell";
        FirstTableViewCell * cell = [tableViews dequeueReusableCellWithIdentifier:identify];
        if (cell == nil) {
            cell = [[[FirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify] autorelease];
        }
        
        NSArray * topArr =[FirstViewController getOriginalDataAry];
        NSDictionary * lpDic =[topArr objectAtIndex:indexPath.row];

        
        [cell->mpImageView setImageWithURL:[NSURL URLWithString:[lpDic objectForKey:@"Logo"]] placeholderImage:[UIImage imageNamed:@"picGreen.png"]];
        cell->mpLabel.text = [lpDic objectForKey:@"Name"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;

    }
    
    else
    {
        UITableViewCell *cell = [tableViews dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil)
        {
            cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleGray;
            cell.contentView.backgroundColor =[UIColor clearColor];
            cell.textLabel.backgroundColor =[UIColor clearColor];
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            cell.backgroundColor =[UIColor clearColor];
            cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font =[UIFont boldSystemFontOfSize:20];
            cell.textLabel.textColor = [UIColor darkGrayColor];
            UIImageView* lpImageView=[[UIImageView alloc] init];
            lpImageView.backgroundColor = cellSeparateColor;
            lpImageView.frame=CGRectMake(0, 47, 320, 1);
            [cell.contentView addSubview:lpImageView];
            [lpImageView release];
        }
        
        
      
        
        
        
        if (LS==yanlanshijuan
            || LS ==tiku)
        {
            
            NSDictionary * dic =[cellSourceArr objectAtIndex:indexPath.row];
            NSString * namestr = [dic objectForKey:@"Name"];
            cell.textLabel.text = namestr;
            
        }
        
        
        return cell;

    }
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (LS == zhentiyanlian
        || LS ==monikaoshi)
    {
        
        NSArray * topArr =[FirstViewController getOriginalDataAry];
        NSDictionary * dic =[topArr objectAtIndex:indexPath.row];

        SecondTwoViewController  * vc =[[SecondTwoViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.theTitle = [dic objectForKey:@"Name"];
        vc.infoDict = dic;


        if (LS==zhentiyanlian)
        {
            vc.LS = yanlanshijuan;
        }
        
        
        if (LS ==monikaoshi)
        {
            vc.LS = tiku;
        }
        

              
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
        
    }
    
    
    else if (LS == yanlanshijuan
             || LS ==tiku
             || LS ==cuotizhongxin)
    
    {
        NSDictionary * dic =[cellSourceArr objectAtIndex:indexPath.row];
        PredictTestViewCtr * lpViewCtr = [[PredictTestViewCtr alloc] init];
        lpViewCtr.infoDic = dic;
		lpViewCtr.theTitle = [dic objectForKey:@"Name"];

        if (LS==yanlanshijuan)
            lpViewCtr.testType=Zhenti;
        if (LS==tiku)
            lpViewCtr.testType=Moni;
        if (LS==cuotizhongxin)
            lpViewCtr.testType=Cuoti;
        
        
        [self.navigationController pushViewController:lpViewCtr animated:YES];
        [lpViewCtr release];
    }
 }




#pragma mark - WebService



-(void)getDataFromService
{
    
    /*改来改去，屎一样的代码*/
    
    NSString * urlString = nil;
    commonDataOperation * operation = [[commonDataOperation alloc] init] ;

    if (LS==zhentiyanlian)
        LS = yanlanshijuan;
    
    if (LS ==monikaoshi)
        LS = tiku;
    
    if (LS == yanlanshijuan)
    {
        urlString = @"/Exam/PoolList.action";
        operation.tag =20001;
    }
    
    if (LS ==tiku)
    {
        urlString = @"/Exam/QuizList.action";
        operation.tag =20002;
    }
    
    if (LS==cuotizhongxin)
    {
        urlString = @"/Exam/QuizUserList.action";
        operation.tag =20003;
    }
    
    operation.urlStr = [serverIp stringByAppendingString:urlString];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
    [operation release];

}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    NSLog(@"%s",__func__);
    NSLog(@"%@",info);
}
-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    
    [self stopRefreshView];
	[cellSourceArr removeAllObjects];

    NSString * result =[[info JSONValue] objectForKey:@"result"];
    
    if (![result  isEqualToString:@"1"]) {
        return;
    }
    
    NSArray * tmpArr =[[info JSONValue] objectForKey:@"list"];
    
    if ([tmpArr count]!=0)
		[cellSourceArr setArray:tmpArr];
	
	
	if ([cellSourceArr count]==0) {
		NSString * msg = nil;
		if (LS ==Zhenti || LS ==tiku)
			msg =@"此知识点暂无试题！";
		
		if (LS == cuotizhongxin) 
			msg = @"你还没有错题，多多练习吧!";
		
		[myTableView setScrollEnabled:NO];
		[self.textField setText:msg];
		[self.view bringSubviewToFront:self.textField];
		[self.view sendSubviewToBack:myTableView];

	}else{
		
		[myTableView setScrollEnabled:YES];
		[self.textField setText:@""];
		[self.view bringSubviewToFront:myTableView];
		[self.view insertSubview:self.textField
					belowSubview:myTableView];
		[self.view sendSubviewToBack:self.textField];
	}
    
    [myTableView reloadData];
    
}







-(void)addFreshView
{
 
    mpHeaderView = [[EGORefreshTableHeaderView alloc] initHeadFreshView];
    mpHeaderView.delegate = self;
    [myTableView addSubview:mpHeaderView];
    [mpHeaderView release];
    
//    mpFooterView = [[EGORefreshTableHeaderView alloc] initFootFreshView];
//    mpFooterView.delegate = self;
//    [myTableView addSubview:mpFooterView];
//    [mpFooterView release];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    if (scrollView.contentOffset.y<0) {
        [mpHeaderView egoRefreshScrollViewDidScroll:myTableView];
    }else {
        [mpFooterView egoRefreshScrollViewDidScroll:myTableView];
    }
    
    

}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y<0) {
        [mpHeaderView egoRefreshScrollViewDidEndDragging:myTableView];
    }else {
        [mpFooterView egoRefreshScrollViewDidEndDragging:myTableView];
    }

}

-(void)stopRefreshView
{
    [mpHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
    
    [mpFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:myTableView];

}



-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view loadType:(freshViewType)type
{
    
    if (type == HEAD) {
        
        
        if (LS == zhentiyanlian
            || LS == monikaoshi) {
            [self stopRefreshView];
            return;
        }
        
        
        
        [cellSourceArr removeAllObjects];
        [self getDataFromService];

    } else {
        [self getDataFromService];

    }
}


@end
