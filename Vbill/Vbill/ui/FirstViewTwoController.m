//
//  FirstViewTwoController.m
//  Examination
//
//  Created by gurdjieff on 13-7-6.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "FirstViewTwoController.h"
#import "FirstTableViewTwoCell.h"
#import "NSString+CustomCategory.h"
#import "FirstViewThreeController.h"
#import "UIImageView+WebCache.h"
#import "PaymentAssistant.h"
#import "CustomAlertView.h"
#import <objc/runtime.h>
#import "ApiAccount.h"
#import "PredictTestViewCtr.h"


@interface FirstViewTwoController ()

@end

@implementation FirstViewTwoController
@synthesize theTitle = _theTitle;
@synthesize ParentIDStr = _ParentIDStr;
@synthesize infodict = _infodict;
@synthesize isSearch;
@synthesize searchBar;
@synthesize searchDC;
@synthesize isCheck;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!isSearch) {
        [self getDataFromService];
    }
}

-(void)addTableView
{
    mpTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, appFrameHeigh-44) style:UITableViewStylePlain];
    mpTableView.delegate = self;
    mpTableView.dataSource = self;
    mpTableView.backgroundColor = cellBackColor;
    mpTableView.separatorColor = [UIColor clearColor];
    [mpBaseView addSubview:mpTableView];
    [mpTableView release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            NSDictionary* lpDic = objc_getAssociatedObject(alertView, @"payInfo");
            [PaymentAssistant paymentWithInfo:lpDic];
        }
    }
}

-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    
 
    
    
    
    if (tag == 300) {
        if ([info ifInvolveStr:@"\"result\":\"1\""]) {
            NSMutableDictionary * lpDic = [NSMutableDictionary dictionaryWithDictionary:[info JSONValue]];
            
            NSDictionary * dic = [mpDataAry objectAtIndex:miSelectIndex];
            [lpDic setValue:dic[@"Name"] forKey:@"productName"];
            [lpDic setValue:dic[@"Name"] forKey:@"productDescription"];
            
            NSString * total = [lpDic objectForKey:@"Total"];
            NSString * alterInfo = [NSString stringWithFormat:@"当前课程需付费，价格%@元", total];
            CustomAlertView * alertView = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:alterInfo delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"确定", nil];
            alertView.tag = 100;
           objc_setAssociatedObject(alertView, @"payInfo",lpDic, OBJC_ASSOCIATION_RETAIN);
            [alertView show];
            [alertView release];
        }
    }
    
    if (tag == 100) {
        if (![info ifInvolveStr:@"list"]) {
            return;
        }
        
        [mpDataAry setArray: [[info JSONValue] objectForKey:@"list"]];
        [mpTableView reloadData];
		NSLog(@"%@",mpDataAry);
    }
    
    if (tag == 400) {
        if (![info ifInvolveStr:@"list"]) {
            return;
        }
        
        [mpDataAry removeAllObjects];
        
        [mpDataAry setArray: [[info JSONValue] objectForKey:@"list"]];
        
        [mpTableView reloadData];
        [self.searchBar setText:@""];
        
    }
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    
}

-(void)getDataFromService
{
    
    
    
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.useCache = YES;
    //    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/KnowledgeList.action"];
	operation.urlStr =[serverIp stringByAppendingFormat:@"/Course/CourseList.action"];
    [operation.argumentDic setValue:_ParentIDStr forKey:@"ParentID"];
    operation.downInfoDelegate = self;
    operation.tag = 100;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
    [operation release];
}

-(void)initData
{
    mpDataAry = [[NSMutableArray alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    mpTitleLabel.text = _theTitle;
    [self addLeftButton];
    [self addTableView];
    if (!isSearch) {
        [self addRightButton];
    }else{
        [self addSearch];
    }
    
    if (isCheck) {
        [self addTableFootView];
    }
    
    
//    [self addFreshView];
    //    [self getDataFromService];
	// Do any additional setup after loading the view.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
        return [mpDataAry count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identify = @"cell";
    
    FirstTableViewTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[FirstTableViewTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    NSDictionary * tempDic = [mpDataAry objectAtIndex:indexPath.row];
    
    if (!isSearch) {
        NSString * isRead = tempDic[@"IsRead"];
        NSString * name = tempDic[@"Name"];
        NSString * logo =tempDic[@"Logo"];
        NSInteger knowledgeCount = [tempDic[@"KnowledgeCount"] integerValue];
        
        
        [cell->mpImageViewOne setImageWithURL:[NSURL URLWithString:logo]
                             placeholderImage:[UIImage imageNamed:@"picGreen.png"]];
        
        
        cell->mpLabel.text = name;
        
        
        if (knowledgeCount==0)
        {
            [cell->countLabel setFrame:CGRectZero];
            [cell->mpImageView setFrame:CGRectMake(257, 15, 35, 20)];
            
            if ([isRead isEqualToString:@"False"]) {
                cell->mpImageView.image = [UIImage imageNamed:@"notRead.png"];
            } else {
                
                cell->mpImageView.image = [UIImage imageNamed:@"hadRead.png"];
            }
            
        }

    }else{
        NSString * name = tempDic[@"Name"];
        cell->mpLabel.text = name;
    }
    
    
    return cell;
}

-(void)getPaymentWithInfo:(NSDictionary *)apDic
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/Pay.action"];
    [operation.argumentDic setValue:[apDic objectForKey:@"GUID"] forKey:@"GUID"];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    operation.tag = 300;
    [mpOperationQueue addOperation:operation];
    [operation release];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
 
    if (!isSearch) {
        
        NSDictionary * dic = [mpDataAry objectAtIndex:indexPath.row];
        NSInteger KnowledgeCount = [dic[@"KnowledgeCount"] integerValue];
        NSString * Payed = dic[@"Payed"];
        
        if ([Payed isEqualToString:@"False"]) {
            miSelectIndex = indexPath.row;
            [self getPaymentWithInfo:dic];
            return;
        }
        
        
        if (KnowledgeCount != 0) {
            FirstViewTwoController * lpView = [[FirstViewTwoController alloc] init];
            lpView.hidesBottomBarWhenPushed = YES;
            lpView.theTitle =[dic objectForKey:@"Name"];
            lpView.ParentIDStr = [dic objectForKey:@"GUID"];
            lpView.infodict = dic;
            
            [self.navigationController pushViewController:lpView animated:YES];
            [lpView release];
            
            return;
            
        }
    }
    
    FirstViewThreeController * lpView = [[FirstViewThreeController alloc] init];
    lpView.infoDic = [mpDataAry objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:lpView animated:YES];
    [lpView release];

}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48.0f;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [_theTitle release],_theTitle = nil;
    [_ParentIDStr release],_ParentIDStr = nil;
    [mpDataAry release], mpDataAry = nil;
    [super dealloc];
}


#pragma mark - Fresh

-(void)addFreshView
{
    
    mpHeaderView = [[EGORefreshTableHeaderView alloc] initHeadFreshView];
    mpHeaderView.delegate = self;
    [mpTableView addSubview:mpHeaderView];
    [mpHeaderView release];
    
    mpFooterView = [[EGORefreshTableHeaderView alloc] initFootFreshView];
    mpFooterView.delegate = self;
    [mpTableView addSubview:mpFooterView];
    [mpFooterView release];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.y<0) {
        [mpHeaderView egoRefreshScrollViewDidScroll:mpTableView];
    }else {
        [mpFooterView egoRefreshScrollViewDidScroll:mpTableView];
    }
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y<0) {
        [mpHeaderView egoRefreshScrollViewDidEndDragging:mpTableView];
    }else {
        [mpFooterView egoRefreshScrollViewDidEndDragging:mpTableView];
    }
    
}

-(void)stopRefreshView
{
    [mpHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:mpTableView];
    
    [mpFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:mpTableView];
    
}



-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view loadType:(freshViewType)type
{
    
    if (type == HEAD) {
        
    } else {
        
    }
}





#pragma mark - 简介


-(void)addRightButton
{
    
    
    UIImageView * imageview =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jianjiebtn.png"]];
    [imageview setFrame:CGRectMake(320-35, 12, 19, 19)];
    [mpNavitateView addSubview:imageview];
    [imageview  release];
    
    UIButton * lpRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lpRightBtn.frame = CGRectMake(screenWidth-80,3, 70, 38);
    [lpRightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:lpRightBtn];
}


-(void)rightBtnClick:(id)sender
{
    [self showBigImage:_infodict[@"CourseBrief"]];
}

-(void)showBigImage:(NSString *)string{
    
	UIView *bgViews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
	[bgViews setBackgroundColor:[UIColor colorWithRed:0.3
                                                green:0.3
                                                 blue:0.3
                                                alpha:0.7]];
	[self.view addSubview:bgViews];
	[bgViews release];
	
	UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BIG_IMG_WIDTH+16, BIG_IMG_HEIGHT+16)];
    borderView.layer.cornerRadius = 8;
	borderView.layer.masksToBounds = YES;
	borderView.layer.borderWidth = 8;
	borderView.layer.borderColor = [[UIColor colorWithRed:0.9
													green:0.9
													 blue:0.9
													alpha:0.7] CGColor];
	[borderView setCenter:bgViews.center];
	[bgViews addSubview:borderView];
	[borderView release];
	
	UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[closeBtn setImage:[UIImage imageNamed:@"X.png"] forState:UIControlStateNormal];
	[closeBtn addTarget:self action:@selector(removeBigImage:) forControlEvents:UIControlEventTouchUpInside];
	[closeBtn setFrame:CGRectMake(borderView.frame.origin.x+borderView.frame.size.width-56, borderView.frame.origin.y-36+BIG_IMG_HEIGHT, 30, 30)];
	[bgViews addSubview:closeBtn];
	
    
	UITextView * theTextView = [[UITextView alloc] initWithFrame:CGRectMake(8, 8, BIG_IMG_WIDTH, BIG_IMG_HEIGHT)];
    theTextView.scrollEnabled = YES;
    theTextView.editable = NO;
    theTextView.text = string;
    theTextView.font = [UIFont systemFontOfSize:18.0];
    theTextView.textColor=[UIColor grayColor];
    theTextView.backgroundColor =[UIColor whiteColor];
	[borderView addSubview:theTextView];
	[theTextView release];
    
}
-(void)removeBigImage:(UIButton *)btn{
	[[btn superview] removeFromSuperview];
}

#pragma mark - footView


-(void)addTableFootView
{
    UIView * view =[[UIView alloc] init];
    [view setFrame:CGRectMake(0, 0, 300, 44)];
    [view setBackgroundColor:[UIColor clearColor]];
    
    mpTableView.tableFooterView = view;
    
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(40, 2, 220, 40)];
    [btn setTitle:@"本章测试" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(check:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:btn];
    
    
    UIImageView* lpImageView=[[UIImageView alloc]
                              initWithFrame:CGRectMake(0, 43, 320, 1)];
    lpImageView.backgroundColor = cellSeparateColor;
    [view addSubview:lpImageView];
    [lpImageView release];
    
    [view release];
}


-(void)check:(id)sender
{
    

    PredictTestViewCtr * lpViewCtr = [[PredictTestViewCtr alloc] init];
    lpViewCtr.infoDic = _infodict;
    lpViewCtr.theTitle = @"本章测试";
    lpViewCtr.testType = benzhangceshi;
    [self.navigationController pushViewController:lpViewCtr animated:YES];
    [lpViewCtr release];
}

#pragma mark - search

-(void)addSearch
{
    self.searchBar = [[[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 44.0f, 320.0f, 44.0f)] autorelease];
	self.searchBar.tintColor = [UIColor grayColor];
    self.searchBar.delegate = self;
	mpTableView.tableHeaderView = self.searchBar;
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(320-55, 7, 50, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
	[btn.titleLabel setFont:myFont];
    [btn addTarget:self action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:btn];
    
}

-(void)cancelSearch
{
    [self.searchBar setText:@""];
    [self.searchBar resignFirstResponder];
}


#pragma mark - searBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar1
{
    [searchBar1 setText:@""];
    [searchBar1 resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar1
{
    
    if ([[searchBar1 text] length]!= 0) {
        [self search:[searchBar1 text]];
    }
    
    [searchBar1 resignFirstResponder];
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    //一旦SearchBar輸入內容有變化，則執行這個方法，詢問要不要重裝searchResultTableView的數據
//    [self filterContentForSearchText:searchString scope:
//     [[self.searchDisplayController.searchBar scopeButtonTitles]
//      objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    //一旦Scope Button有變化，則執行這個方法，詢問要不要重裝searchResultTableView的數據
//    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
//     [[self.searchDisplayController.searchBar scopeButtonTitles]
//      objectAtIndex:searchOption]];
//    // Return YES to cause the search result table view to be reloaded.
    return YES;
}
-(void)search:(NSString *)str
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/KnowledgeSearch.action"];
    operation.tag = 400;
    [operation.argumentDic setValue:str forKey:@"keyword"];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
    [operation release];
}


@end
