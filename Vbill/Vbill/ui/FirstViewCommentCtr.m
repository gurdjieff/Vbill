//
//  FirstViewCommentCtr.m
//  Examination
//
//  Created by gurdjieff on 13-7-6.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "FirstViewCommentCtr.h"
#import "CommentCell.h"
#import "StudyCommunityViewCtr.h"
#import "AddCommentViewCtr.h"
#import "RemarkViewController.h"

@interface FirstViewCommentCtr ()

@end

@implementation FirstViewCommentCtr
@synthesize infoDic = mpInfoDic;
@synthesize theTitle = _theTitle;
@synthesize ctrStyle = _ctrStyle;



-(id)init
{
    return [self initWithNibName:nil bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{
	if (myIndexPath != nil) {
		[myIndexPath release];
		myIndexPath = nil;
	}
    [_theTitle release],_theTitle = nil;
    [mpInfoDic release], mpInfoDic = nil;
    [mpDataAry release], mpDataAry = nil;
    [super dealloc];
}

-(void)initNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboarWilldHidden)
												 name:UIKeyboardWillHideNotification
											   object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

-(void)keyboarWilldHidden
{
    [UIView animateWithDuration:0.25 animations:^{
        mpFootView.frame = CGRectMake(0, appFrameHeigh-44-50, 320, 50);
//        mpFootView2.frame = CGRectMake(0, appFrameHeigh-44-50, 320, 50);
    }];
}

-(void)keyboardWillShow:(NSNotification *)aNotification
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    
    NSDictionary* lpinfo=[aNotification userInfo];
    NSValue* lpValue=[lpinfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize=[lpValue CGRectValue].size;
    mpFootView.frame = CGRectMake(0, appFrameHeigh-44-50-keyboardSize.height, 320, 50);
//    mpFootView2.frame = CGRectMake(0, mpFootView.frame.origin.y-30, 320, 30);
    [UIView commitAnimations];
}

-(void)addTableView
{
    float height = 0;
    if (_theTitle==nil) {
        height = appFrameHeigh-44-50;
    } else{
        height = appFrameHeigh-44;
    }

    
    mpTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, height) style:UITableViewStylePlain];
    mpTableView.delegate = self;
    mpTableView.dataSource = self;
//    mpTableView.separatorColor = [UIColor clearColor];
    [mpBaseView addSubview:mpTableView];
    mpTableView.backgroundColor  =mySetColor;
    [mpTableView release];
}

-(void)resetTitle
{
    return;
    int number = 0;
    for (int i = 0; i < 5; i++) {
        UIButton * btn = (UIButton *)[mpFootView2 viewWithTag:101 + i];
        if (btn.selected) {
            number += 1;
        }
    }
    mpLabel.text = [NSString stringWithFormat:@"%d星",number];
}

-(void)btnClick:(UIButton *)apBtn
{
    if (apBtn.tag >= 101) {
        apBtn.selected = !apBtn.selected;
        if (apBtn.selected) {
            [apBtn setBackgroundImage:[UIImage imageNamed:@"yellowStar.png"] forState:UIControlStateNormal];
        } else {
            [apBtn setBackgroundImage:[UIImage imageNamed:@"whiteStar.png"] forState:UIControlStateNormal];
        }
        [self resetTitle];
    }
}



-(void)addFootView
{


    
    mpFootView = [[UIImageView alloc] initWithFrame:CGRectMake(0, appFrameHeigh-44-50, 320, 50)];
    [mpBaseView addSubview:mpFootView];
    mpFootView.userInteractionEnabled = YES;
    mpFootView.image = [UIImage imageNamed:@"purpleback.png"];
    [mpFootView release];
    
    mpTextView = [[UITextView alloc] initWithFrame:CGRectMake(40, 7, 220, 36)];
//    mpTextView.placeholder = @"我要评论";
    mpTextView.backgroundColor = [UIColor whiteColor];
    mpTextView.font = [UIFont systemFontOfSize:16];
    [mpFootView addSubview:mpTextView];
    [mpTextView release];
    
    UIImageView * lpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 30)];
    lpImageView.image = [UIImage imageNamed:@"pen.png"];
    [mpFootView addSubview:lpImageView];
    [lpImageView release];
    
    UIButton * lpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lpBtn.frame = CGRectMake(268, 7, 46, 36);
    lpBtn.backgroundColor = [UIColor brownColor];
    [lpBtn setTitle:@"确定" forState:UIControlStateNormal];
    lpBtn.tag = 100;
    [lpBtn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [lpBtn addTarget:self action:@selector(subMitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mpFootView addSubview:lpBtn];
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (isRefresh)
        [self getDataFromService:@""];
}

-(void)initData
{
    isRefresh = YES;
    mpDataAry = [[NSMutableArray alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self addLeftButton];
    [self addTableView];
    [self addFreshView];

    if (_ctrStyle==pinglun)
    {
        mpTitleLabel.text = @"评论";
        [self addFootView];
    }
    if (_ctrStyle==jiaoliu) {
		mpTitleLabel.text = _theTitle;
        [self addRightBtn];
	}
    
    [self initNotification];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [mpTextView resignFirstResponder];
}


#pragma mark - InterFace


-(void)rightBtnClick
{
//    AddCommentViewCtr * lpViewCtr = [[AddCommentViewCtr alloc] init];
//    lpViewCtr.infoDic = mpInfoDic;
//    lpViewCtr.ctrStyle = _ctrStyle;
//    [self.navigationController pushViewController:lpViewCtr animated:YES];
//    [lpViewCtr release];
    
    
    
    RemarkViewController * lpViewCtr = [[RemarkViewController alloc] init];
    lpViewCtr.hidesBottomBarWhenPushed = YES;
    lpViewCtr.infoDict = mpInfoDic;
    lpViewCtr.myStyle = _ctrStyle;
    lpViewCtr.delegate = self;
    [self.navigationController pushViewController:lpViewCtr animated:YES];
    [lpViewCtr release];

}


-(void)subMitBtnClick:(UIButton *)btn
{
    [self saveDataToService];
}

#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mpDataAry count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * tempDic = mpDataAry[indexPath.row];
    NSString *content=tempDic[@"Brief"];
	
	NSString * text = nil;
	
	if ([content length]>eachCharactersinCell)
		text = [content substringToIndex:eachCharactersinCell];
	else
		text = content;
    CGSize detailSize = [text sizeWithFont:communicationFont 							constrainedToSize:CGSizeMake(230, 2000)
								lineBreakMode:NSLineBreakByWordWrapping];
    return detailSize.height + 30+25;

    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identify = @"cell";
    CommentCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        
        cell = [[[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault
								   reuseIdentifier:identify] autorelease];
        

        
        if (_ctrStyle==pinglun)
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else
        {
			cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        

    }

    NSDictionary * tempDic = mpDataAry[indexPath.row];
    NSString * headpotoUrl = tempDic[@"User"][@"HeadPhotoUrl"];
    
    [cell->mpImageView setImageWithURL:[NSURL URLWithString:headpotoUrl]
					  placeholderImage:nil];
    cell->mpLabel1.text = tempDic[@"User"][@"NickName"];;
    cell->mpLabel2.text = tempDic[@"PostDate"];
	
	NSString * brief = tempDic[@"Brief"];
	NSString * text = nil;
	
	if ([brief length]>eachCharactersinCell)
		text = [brief substringToIndex:eachCharactersinCell];
	else
		text = brief;
	
	cell->mpLabel3.text = text;
    cell->mpLabel4.text = tempDic[@"ReplyCount"];
    cell->mpLabel5.text = tempDic[@"ReadCount"];
	
	CGSize detailSize = [text sizeWithFont:communicationFont
						 constrainedToSize:CGSizeMake(230, 2000)
							 lineBreakMode:NSLineBreakByWordWrapping];
    
    cell->mpLabel1.frame = CGRectMake(60, 2.5, 120, 25);
	cell->mpLabel2.frame = CGRectMake(75, detailSize.height+30, 80, 20);
    cell->mpLabel3.frame = CGRectMake(60, 25, 230 ,detailSize.height);
	
	if (_ctrStyle==pinglun) {
		cell->mpLabel4.frame =CGRectZero;
	}else{
	
		cell->mpLabel4.frame = CGRectMake(265, detailSize.height+30, 45 ,20 );
        
        cell->imagview2.frame = CGRectMake(60, detailSize.height+36, 10, 10);
        cell->imagview4.frame = CGRectMake(250, detailSize.height+36, 10, 10);
        
        cell->imagview5.frame = CGRectMake(190, detailSize.height+36, 10, 10);
         cell->mpLabel5.frame = CGRectMake(205, detailSize.height+30, 40, 20);
        
	}
    
    
    cell.backgroundColor = [UIColor greenColor];


    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [mpTextView resignFirstResponder];

    if (_ctrStyle == pinglun) {
        return;
    }
    NSDictionary * dic = mpDataAry[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	
    StudyCommunityViewCtr * lpViewCtr = [[StudyCommunityViewCtr alloc] init];
    lpViewCtr.infoDic = dic;
    lpViewCtr.delegate =self;
	lpViewCtr.ctrStyle = _ctrStyle;
	lpViewCtr.infoDic = dic;
    [self.navigationController pushViewController:lpViewCtr animated:YES];
    [lpViewCtr release];
    
}




-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_ctrStyle ==pinglun
		|| _ctrStyle == jiaoliu)
		
	{
		
		NSDictionary * dic =mpDataAry[indexPath.row];
		NSDictionary * user =[dic objectForKey:@"User"];
		NSString * UserID =[user objectForKey:@"UserID"];
		
		
		NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
		NSString * uid =[userDefaults objectForKey:@"UserID"];
		
		if ([uid isEqualToString:UserID]) {
			return YES;
		}
		
        return NO;
    }
		
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
    
    
	if (editingStyle==UITableViewCellEditingStyleDelete)
	{
		if (myIndexPath != indexPath) {
			[myIndexPath release];
			myIndexPath = [indexPath retain];
		}

		NSDictionary * tag =mpDataAry[indexPath.row] ;
		
		if (_ctrStyle==pinglun) {
			_ctrStyle = pinglunbianji;
		}
		if (_ctrStyle==jiaoliu) {
			_ctrStyle = jiaoliubianqi;
		}
		
		
		[self getDataFromService:tag];
		
		
	}
	
    
}










#pragma mark - Refresh

-(void)refreshJiaoLiu:(BOOL)flag
{
    isRefresh = flag;
}


-(void)addFreshView
{
    
    mpHeaderView = [[EGORefreshTableHeaderView alloc] initHeadFreshView];
    mpHeaderView.delegate = self;
    [mpTableView addSubview:mpHeaderView];
    [mpHeaderView release];
    
//    mpFooterView = [[EGORefreshTableHeaderView alloc] initFootFreshView];
//    mpFooterView.delegate = self;
//    [mpTableView addSubview:mpFooterView];
//    [mpFooterView release];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
//    [mpTextView resignFirstResponder];

    
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
        isRefresh = YES;
        [self getDataFromService:@""];
        
    } else {
        isRefresh = NO;
        //        [self getDataFromService];
        
    }
}

#pragma mark - WebService

-(void)resetString:(NSMutableString* )info
{
    while (1) {
        NSRange range = [info rangeOfString:@"<br />" options:NSCaseInsensitiveSearch];
        if (range.length > 0) {
             [info replaceCharactersInRange:range withString:@"\\n"];
        } else {
            return;
        }
    }
}

-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    
    [self stopRefreshView];
    //提交评论
	
	NSMutableString * tempInfo = [[[NSMutableString alloc] init] autorelease];
    [tempInfo setString:info];
    [self resetString:tempInfo];
	NSString * result =[[tempInfo JSONValue] objectForKey:@"result"];

    if (tag==30002)
    {
        
        if ([result isEqualToString:@"1"]) {
			[mpTextView setText:@""];
            [mpTextView resignFirstResponder];
            [self getDataFromService:@""];
        }
        return;
    }
	
	
	
	if (tag==30003 ||tag==30004) {
		
		if ([result isEqualToString:@"1"]) {
			
			[mpDataAry removeObjectAtIndex:myIndexPath.row];
			[mpTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:myIndexPath] withRowAnimation:UITableViewRowAnimationRight];
			[NewItoast showItoastWithMessage:@"删除成功"];
			
		}else{
			[NewItoast showItoastWithMessage:@"操作失败"];
		}
		
		if (tag==30003) {
			_ctrStyle = pinglun;
		}
		if (tag==30004) {
			_ctrStyle = jiaoliu;
		}
		return;
		
	}
	
    
    if (![tempInfo ifInvolveStr:@"list"]) {
        return;
    }
	
	
    
    
    if (isRefresh) {
		
        [mpDataAry removeAllObjects];
        
        [mpDataAry addObjectsFromArray:[tempInfo JSONValue][@"list"]];
        [mpTextView setText:@""];

    }
    
    
    
    [mpTableView reloadData];
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
	if (_ctrStyle == pinglunbianji) {
		_ctrStyle =pinglun;
	}
	
	if (_ctrStyle==jiaoliubianqi) {
		_ctrStyle = jiaoliu;
	}
}

-(void)saveDataToService
{
	
	
	
	
	
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/Remark.action"];
    [operation.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"CourseID"];
    operation.tag = 30002;
    NSString * info = [NSString stringWithString:mpTextView.text];
    [operation.argumentDic setValue:info forKey:@"Brief"];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
    [operation release];
}

-(void)getDataFromService:(id)tag
{
    
    commonDataOperation * operation = [[commonDataOperation alloc] init];
   
    
	if (_ctrStyle == pinglun)
    {
		operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/RemarkList.action"];
        [operation.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"CourseID"];
        operation.tag = 30000;
    }
    if (_ctrStyle == jiaoliu)
	{
		operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/RemarkList.action"];
        [operation.argumentDic setValue:@""
                                 forKey:@"CourseID"];
		operation.tag = 30001;

    }
	
	if (_ctrStyle==pinglunbianji) {
		operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/DeleteRemark.action"];
		NSDictionary * dic = (NSDictionary *)tag;
		[operation.argumentDic setValue:[dic objectForKey:@"GUID"]
                                 forKey:@"GUID"];
		operation.tag = 30003;
	}
	
	
	if (_ctrStyle==jiaoliubianqi) {
		
		operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/DeleteRemark.action"];
		NSDictionary * dic = (NSDictionary *)tag;
		[operation.argumentDic setValue:[dic objectForKey:@"GUID"]
                                 forKey:@"GUID"];
		operation.tag = 30004;
	}
    
  
    
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
    [operation release];
}


@end
