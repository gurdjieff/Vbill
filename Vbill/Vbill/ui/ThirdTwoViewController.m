//
//  SecondTwoViewController.m
//  Examination
//
//  Created by Zhang Bo on 13-7-3.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "ThirdTwoViewController.h"
#import "BaiKuangCell.h"
#import "JiaoLiuCell.h"
#import "JiHuaOneViewController.h"
#import "WebViewController.h"
#import "JiHuaTwoViewController.h"
#import "FirstViewController.h"
#import "RemarkViewController.h"
#import "JiaoLiuViewController.h"

#define cellHight 44

@interface ThirdTwoViewController ()


@end

@implementation ThirdTwoViewController
@synthesize theTitle = _theTitle;
@synthesize LS;
@synthesize infoDict = _infoDict;
@synthesize textLabel = _textLabel;

- (void)dealloc
{
	if (myIndexPath!= nil) {
		[myIndexPath release],myIndexPath = nil;
	}
	[_textLabel release];
    [_infoDict release];
    [theTitle release];
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
        // Custom initialization
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
    
    if (LS==xuexijihua)
        [self addRightBtn];
    
    
    
	[self getDataFromService:@""];

}




- (void)addSubViews
{
    self.view.backgroundColor = mySetColor;
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,44,screenWidth,screenHeight) style:UITableViewStylePlain];
    myTableView.backgroundView=nil;
    myTableView.backgroundColor=[UIColor clearColor];
    myTableView.delegate=self;
    myTableView.dataSource=self;    
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
	
	UILabel * mpLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, screenWidth-20, 60)];
    mpLabel1.backgroundColor = [UIColor clearColor];
    mpLabel1.font = [UIFont boldSystemFontOfSize:16];
	[mpLabel1 setTextAlignment:NSTextAlignmentCenter];
    mpLabel1.textColor = [UIColor grayColor];
	mpLabel1.numberOfLines =0;
	mpLabel1.lineBreakMode = UILineBreakModeWordWrap;
	self.textLabel = mpLabel1;
    [self.view addSubview:mpLabel1];
    [mpLabel1 release];
	
	[self.view sendSubviewToBack:self.textLabel];
}


-(void)addRightBtn
{
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(320-85, 7, 80, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [btn setTitle:@"制定计划" forState:UIControlStateNormal];
	[btn.titleLabel setFont:myFont];

    [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:btn];
}




-(void)rightBtnClick
{
    if (LS ==xuexijihua) {
		
        JiHuaTwoViewController  * vc =[[JiHuaTwoViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.theTitle = @"制定计划";
        vc.delegate =self;

        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
        
    }
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    if (LS==xuexijihua && isJiHua) {
                
        [self getDataFromService:@""];
    }
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
 
    return [cellSourceArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (LS==mingjiajiangtang
        ||LS==xuexiaoxinxi)
    {
        return 20+cellHight;
    }
    
    else if (LS ==xuexijiaoliu)
    {
        return 2 * cellHight;
    }
    else
        return cellHight;
}



- (UITableViewCell *)tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    static NSString *CellIdentifier = @"Cell";
    
    
    if (LS ==mingjiajiangtang
        || LS == xuexiaoxinxi) {
        
        BaiKuangCell *cell = [tableViews dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            
            cell=[[[BaiKuangCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor = mySetColor;

        }
        
        NSDictionary * dic =[cellSourceArr objectAtIndex:indexPath.row];
        
        cell.timulabel.text =[dic objectForKey:@"Name"];
        return cell;
        
    }
 

 	
    else
		{
            
            

        UITableViewCell *cell = [tableViews dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {

            cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor =[UIColor clearColor];
            cell.backgroundColor = mySetColor;
            cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
            
            UILabel * label =[[UILabel alloc] init];
            [label setTextColor:[UIColor grayColor]];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setFont:[UIFont systemFontOfSize:16]];
            [label setFrame:CGRectMake(5, 2, 220, 44)];
            [label setTextAlignment:NSTextAlignmentLeft];
            [label setTag:10131111+indexPath.row];
            [[cell contentView] addSubview:label];
            [label release];
            
            if (LS == xuexijihua) {
                
                UIImageView* imageView=[[UIImageView alloc] init];
                
                imageView.frame=CGRectMake(235, 7, 60, 27);
                [cell.contentView addSubview:imageView];
                [imageView setTag:20131111+indexPath.row];
                [imageView release];
                
            
            }
            

            

            UIImageView* lpImageView=[[UIImageView alloc] init];
            lpImageView.backgroundColor = cellSeparateColor;
            lpImageView.frame=CGRectMake(0, 43, 320, 1);
            [cell.contentView addSubview:lpImageView];
            [lpImageView release];
            
            

        }
            NSDictionary * dic =[cellSourceArr objectAtIndex:indexPath.row];
            
            
      
            
            if (LS == xuexijihua)
            {
                UILabel * label1 = (UILabel *)[[cell contentView] viewWithTag:10131111+indexPath.row];
                [label1 setText:dic[@"Brief"]];
                
                
                
                
                NSString * str =dic[@"Status"];
                
                
                UIImageView * imageview =(UIImageView *)[[cell contentView] viewWithTag:20131111+indexPath.row];
                
                UIImage * image = nil;
                
                
                if ([str isEqualToString:@"未完成"])
                    image =[UIImage imageNamed:@"weiwancheng.png"];
                
                
                else if ([str isEqualToString:@"已完成"])
                    image =[UIImage imageNamed:@"yiwancheng.png"];
                
                else
                    image =[UIImage imageNamed:@"yiguoqi.png"];
                
                [imageview setImage:image];
                
                
                
            }
            else
            {
                UILabel * label = (UILabel *)[[cell contentView] viewWithTag:10131111+indexPath.row];
                [label setText:dic[@"Name"]];
            }
            
            
            
            return cell;
		}




    
}




-(void)tableView:(UITableView *)tableViews didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (LS==mingjiajiangtang)
    {
        
        NSDictionary * dic =[cellSourceArr objectAtIndex:indexPath.row];
        WebViewController  * vc =[[WebViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.theTitle =[dic objectForKey:@"Name"];
        vc.theGuid = [dic objectForKey:@"GUID"];
        vc.LS = mingjiajiangtang;
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
        
    }

    else if (LS ==xuexiaoxinxi)
    {
        
        NSDictionary * dic =[cellSourceArr objectAtIndex:indexPath.row];
        WebViewController  * vc =[[WebViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.theTitle =[dic objectForKey:@"Name"];
        vc.theGuid = [dic objectForKey:@"GUID"];
        vc.LS = xuexiaoxinxi;
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
        
     }
    
    
    
    if (LS==xuexijihua) {
        
        NSDictionary * dic =[cellSourceArr objectAtIndex:indexPath.row];

        JiHuaOneViewController  * vc =[[JiHuaOneViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.delegete =self;
        vc.theTitle =[dic objectForKey:@"Name"];
        vc.infoDic = dic;
        
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
    
       
    if (LS== shuqianbiji) {
        NSDictionary * dic =[cellSourceArr objectAtIndex:indexPath.row];
    	RemarkViewController *controller =
        [[RemarkViewController alloc] init];
        controller.theTitle = [dic objectForKey:@"Name"];
        controller.infoDict = dic;
        controller.myStyle = fabiao;
        
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }

	
}




-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (LS ==xuexijihua
		|| LS == shuqianbiji)
        return YES;
    else
        return NO;
}


-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath {
    return @"删除";
}

//编辑tableview
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath{
 
        
        //如果编辑style==删除style
	if (editingStyle==UITableViewCellEditingStyleDelete)
	{
		if (myIndexPath != indexPath) {
			[myIndexPath release];
			myIndexPath = [indexPath retain];
		}
		
		if (LS == xuexijihua)
			LS = xuexijihuabianji;
			
		if (LS ==shuqianbiji)
			LS =shuqianliebiaobianji;
				
		
		NSDictionary * tag =[cellSourceArr objectAtIndex:indexPath.row] ;
		[self getDataFromService:tag];
	}


    
    
}




#pragma mark - WebService



-(void)getDataFromService:(id)tag
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
	
   if (LS == mingjiajiangtang)
    {
        operation.tag = 30001;
        operation.urlStr = [serverIp stringByAppendingString: @"/Application/TeacherList.action"];
    }
    
    else if (LS ==xuexiaoxinxi)
    {
        operation.tag = 30003;
        operation.urlStr = [serverIp stringByAppendingString:@"/Application/SchoolList.action"];
    }
    
    
    else if (LS ==xuexijihua)
    {
        operation.tag = 30005;
        operation.urlStr = [serverIp stringByAppendingString:@"/User/StudyPlanList.action"];
    }

    else if (LS == xuexijihuabianji)
    {
        operation.tag = 30006;
        operation.urlStr = [serverIp stringByAppendingString:@"/User/DeleteStudyPlan.action"];
				NSDictionary * dic =(NSDictionary *)tag;
        [operation.argumentDic setValue:[dic objectForKey:@"GUID"] forKey:@"GUID"];
    }
    
    
    else if(LS ==shuqianbiji)
    {
		operation.tag = 30011;
		operation.urlStr = [serverIp stringByAppendingString:@"/Course/NoteList.action"];
    }


	else if(LS ==shuqianliebiaobianji)
	{
		
		operation.tag = 30012;
		operation.urlStr = [serverIp stringByAppendingString:@"/Course/Note.action"];
		NSDictionary * dic =(NSDictionary *)tag;
		[operation.argumentDic setValue:[dic objectForKey:@"NoteID"] forKey:@"GUID"];
		[operation.argumentDic setValue:@"" forKey:@"Brief"];
		[operation.argumentDic setValue:[dic objectForKey:@"GUID"] forKey:@"CourseID"];
	}

    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
    [operation release];
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{

	if (tag==30006) {
		LS = xuexijihua;
	}
	if (tag==30012){
		LS = shuqianbiji;
	}
}
-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
   
	
    [self stopRefreshView];
	
	
	
    if (info !=nil ){
		
		NSString * result = [[info JSONValue] objectForKey:@"result"];
		
		
		if ([result isEqualToString:@"1"]) {
			
			if (tag==30006 || tag ==30012)
			{
				
				[cellSourceArr removeObjectAtIndex:myIndexPath.row];
				[myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:myIndexPath] withRowAnimation:UITableViewRowAnimationRight];
				[NewItoast showItoastWithMessage:@"删除成功"];
				
			}
			
			else
			{
				
				NSArray * list =[[info JSONValue] objectForKey:@"list"];
				if (list != nil && [list count]!=0)
				{
					[cellSourceArr setArray:list];
				}
				
			}
			
			
		}else{
			[NewItoast showItoastWithMessage:@"操作失败"];
		}
		
		if (tag==30006) {
			LS = xuexijihua;
		}
		if (tag==30012){
			LS = shuqianbiji;
		}
		
	}
	
	
	if ([cellSourceArr count]==0) {
		
		NSString * msg = nil;
		if (LS==xuexijihua)
			msg = @"你还没有制定学习计划，快来制定督促学习进度吧！";
		if (LS ==shuqianbiji)
			msg =@"在课程中的添加的书签笔记，在这里查看!";
		
		[myTableView setScrollEnabled:NO];
		[self.textLabel setText:msg];
		[self.view bringSubviewToFront:self.textLabel];
		[self.view sendSubviewToBack:myTableView];
	}else{
		
		[myTableView setScrollEnabled:YES];
		[self.textLabel setText:@""];
		[self.view bringSubviewToFront:myTableView];
		[self.view insertSubview:self.textLabel belowSubview:myTableView];
		[self.view sendSubviewToBack:self.textLabel];
	}
	
	
	[myTableView reloadData];

}




#pragma mark - Refresh


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
		if (myIndexPath!=nil) {
			[myIndexPath release];
			myIndexPath = nil;

		}
        [self getDataFromService:@""];
        
    } else {
//        [self getDataFromService];
        
    }
}




-(void)refreshJiHua:(BOOL)flag
{
    isJiHua = flag;
}


@end
