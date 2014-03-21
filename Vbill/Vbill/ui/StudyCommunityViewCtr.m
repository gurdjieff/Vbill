//
//  StudyCommunityViewCtr.m
//  Examination
//
//  Created by gurd on 13-7-30.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "StudyCommunityViewCtr.h"
#import "CommentCell.h"
#import "ApiAccount.h"
#import "UIColor+hex.h"

#define backColor [UIColor clearColor]

@interface StudyCommunityViewCtr ()

@end

@implementation StudyCommunityViewCtr

@synthesize infoDic = mpInfoDic;
@synthesize ctrStyle = _ctrStyle;
@synthesize delegate = _delegate;
@synthesize guidString = _guidString;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
        mpBaseView.center = center;

//        mpFootView.frame = CGRectMake(0, appFrameHeigh-44-50, 320, 50);
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
//    mpFootView.frame = CGRectMake(0, appFrameHeigh-44-50-keyboardSize.height, 320, 50);
    mpBaseView.center = CGPointMake(center.x, center.y - keyboardSize.height);
    [UIView commitAnimations];
}



-(void)dealloc
{
    _delegate = nil;
	if (myIndexPath!=nil) {
		[myIndexPath release];
		myIndexPath = nil;
	}
	[_guidString release];
    [mpInfoDic release], mpInfoDic = nil;
    [mpDataAry release], mpDataAry = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}



-(void)addTableView
{
    mpTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, appFrameHeigh-44-50) style:UITableViewStylePlain];
    mpTableView.delegate = self;
    mpTableView.dataSource = self;
    mpTableView.separatorColor = [UIColor clearColor];
    [mpBaseView addSubview:mpTableView];
    [mpTableView release];
}

-(void)addTableViewHeadView
{



    NSDictionary * userInfo = mpInfoDic[@"User"];
	
    UIView * lpHeaderView = [[UIView alloc] init];
//    lpHeaderView.backgroundColor = [UIColor greenColor];
    UIImageView * lpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 70, 70)];
    lpImageView.backgroundColor = backColor;
	lpImageView.tag =2013090300;
    [lpImageView setImageWithURL:[NSURL URLWithString:userInfo[@"HeadPhotoUrl"]]];
    
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(90, 15, 200, 30)];
    label1.text = userInfo[@"NickName"];
//    label1.textColor =[UIColor blueColor];
    label1.textColor =[UIColor colorWithHexString:@"#36a8de"];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.backgroundColor = backColor;
	label1.font = [UIFont systemFontOfSize:14];
	label1.tag = 2013090301;
    
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 180, 30)];
    label2.text = mpInfoDic[@"PostDate"];
    label2.textColor =[UIColor lightGrayColor];
    label2.backgroundColor = backColor;
    label2.textAlignment = NSTextAlignmentRight;
	label2.font = [UIFont systemFontOfSize:12];

	label2.tag = 2013090302;

    
    UILabel * label3 = [[UILabel alloc] init];
    label3.text = mpInfoDic[@"Brief"];
    label3.numberOfLines = 0;
    label3.backgroundColor = backColor;
	label3.font = [UIFont systemFontOfSize:14];
	label3.tag = 2013090303;

    UILabel * label4 = [[UILabel alloc] init];
    label4.text = @"回复";
    label4.font = [UIFont systemFontOfSize:14];
	label4.textAlignment =NSTextAlignmentLeft;
    label4.backgroundColor = [UIColor clearColor];
	label4.tag = 2013090304;

    
    [lpHeaderView addSubview:lpImageView];
    [lpImageView release];
    [lpHeaderView addSubview:label1];
    [label1 release];
    [lpHeaderView addSubview:label2];
    [label2 release];
    [lpHeaderView addSubview:label3];
    [label3 release];
    [lpHeaderView addSubview:label4];
    [label4 release];
    
    CGSize size = [mpInfoDic[@"Brief"] sizeWithFont:[UIFont systemFontOfSize:14]
								  constrainedToSize:CGSizeMake(307, 2000)
									  lineBreakMode:NSLineBreakByWordWrapping];
    label3.frame = CGRectMake(8, 130,size.width, size.height);
    label2.frame = CGRectMake(210, label3.buttom+5, 100, 30);
    label4.frame = CGRectMake(8, label3.buttom+35, 300, 30);
    
    lpHeaderView.frame = CGRectMake(0, 0, 320, label3.buttom+60);
    
    mpTableView.tableHeaderView = lpHeaderView;
    [lpHeaderView release];
	
	[label3 setBackgroundColor:[UIColor clearColor]];
	[label4 setBackgroundColor:[UIColor clearColor]];
}


-(void)setDataOfView
{

    NSDictionary * userInfo = mpInfoDic[@"User"];
	
		UIView * lpHeaderView = mpTableView.tableHeaderView ;

	UIImageView * lpImageView =(UIImageView *)[lpHeaderView viewWithTag: 2013090300];
		  
	[lpImageView setImageWithURL:[NSURL URLWithString:userInfo[@"HeadPhotoUrl"]]];
	
	UILabel * label1 =(UILabel  *)[lpHeaderView viewWithTag: 2013090301];
	label1.text = userInfo[@"UserName"];
	UILabel * label2 =(UILabel  *)[lpHeaderView viewWithTag: 2013090302];

	label2.text = mpInfoDic[@"PostDate"];
	
	UILabel * label3 =(UILabel  *)[lpHeaderView viewWithTag: 2013090303];

	label3.text = mpInfoDic[@"Brief"];
	CGSize size = [mpInfoDic[@"Brief"] sizeWithFont:label3.font
								  constrainedToSize:CGSizeMake(302, 1000)
									  lineBreakMode:NSLineBreakByWordWrapping];
    label3.frame = CGRectMake(12, 140, size.width, size.height);
	UILabel * label4 =(UILabel  *)[lpHeaderView viewWithTag: 2013090304];
    label4.frame = CGRectMake(12, label3.buttom+10, 310, 30);
    lpHeaderView.frame = CGRectMake(0, 0, 320, label3.buttom+10+30);

	label3.frame = CGRectMake(8, 130,size.width, size.height);
    label4.frame = CGRectMake(8, label3.buttom+5, 300, 30);
    
    lpHeaderView.frame = CGRectMake(0, 0, 320, label3.buttom+30);
}



-(void)subMitBtnClick:(UIButton *)btn
{
    [self saveDataToService];
}

-(void)rightBtnClick
{
    [self saveDataToService];
}

-(void)addRightBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(320-55, 0, 55, 44);
    //    [btn setBackgroundImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
    [btn setTitle:@"发表" forState:UIControlStateNormal];
	[btn.titleLabel setFont:myFont];

    [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:btn];
}

-(void)addFootView
{
    mpFootView = [[UIImageView alloc] initWithFrame:CGRectMake(0, appFrameHeigh-44-50, 320, 50)];
    [mpBaseView addSubview:mpFootView];
    mpFootView.userInteractionEnabled = YES;
    mpFootView.image = [UIImage imageNamed:@"purpleback.png"];
    [mpFootView release];
    
    mpTextView = [[UITextView alloc] initWithFrame:CGRectMake(40, 7, 220, 36)];
    mpTextView.font = [UIFont systemFontOfSize:16];
    //    mpTextView.placeholder = @"我要评论";
    mpTextView.backgroundColor = [UIColor whiteColor];
    //    mpTextField.textAlignment = YES;
    [mpFootView addSubview:mpTextView];
    [mpTextView release];
    
    UIImageView * lpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 30)];
    lpImageView.image = [UIImage imageNamed:@"pen.png"];
    [mpFootView addSubview:lpImageView];
    [lpImageView release];
    UIButton * lpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lpBtn.frame = CGRectMake(268, 7, 46, 36);
    [lpBtn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [lpBtn setTitle:@"确定" forState:UIControlStateNormal];
    lpBtn.tag = 100;
    [lpBtn addTarget:self action:@selector(subMitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mpFootView addSubview:lpBtn];
}

-(void)initData
{
    mpDataAry = [[NSMutableArray alloc] init];
    center = mpBaseView.center;
    [self initNotification];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self addLeftButton];
     mpTitleLabel.text = @"学习交流";
    [self addTableView];
    [self addTableViewHeadView];
    [self addFootView];
    [self addFreshView];
    [self getDataFromService:@""];
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

-(void)leftBtnClick
{
    if (_delegate !=nil
        && [_delegate respondsToSelector:@selector(refreshJiaoLiu:)]) {
        
        [_delegate refreshJiaoLiu:NO];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - UITableView

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 40;
//}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 320, 30)];
//    label.text = @"    回复列表";
//    label.font = [UIFont systemFontOfSize:20];
//    label.backgroundColor = [UIColor clearColor];
//    return [label autorelease];
//}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mpDataAry count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * tempDic = mpDataAry[indexPath.row];
    
    NSString *content=tempDic[@"Brief"];
    
	CGSize detailSize = [content sizeWithFont:communicationFont constrainedToSize:CGSizeMake(230, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    return detailSize.height + 60;
    

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identify = @"cell";
    CommentCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
   
	if (cell == nil) {
        cell = [[[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault
								   reuseIdentifier:identify] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
       
    NSDictionary * tempDic = mpDataAry[indexPath.row];
    NSString * headpotoUrl = tempDic[@"User"][@"HeadPhotoUrl"];
	
    [cell->mpImageView setImageWithURL:[NSURL URLWithString:headpotoUrl]
					  placeholderImage:nil];
    cell->mpLabel1.text = tempDic[@"User"][@"NickName"];;
    cell->mpLabel2.text = tempDic[@"PostDate"];

    NSString * brief = tempDic[@"Brief"];
    cell->mpLabel3.text = brief;
    CGSize detailSize = [brief sizeWithFont:communicationFont
						  constrainedToSize:CGSizeMake(230, 2000)
							  lineBreakMode:NSLineBreakByWordWrapping];
    cell->mpLabel3.frame = CGRectMake(60, 25, 230 , detailSize.height);
	cell->mpLabel4.frame =CGRectZero;
    
    
    cell->mpLabel1.frame = CGRectMake(60, 0, 100, 30);
    [cell->mpLabel1 setTextAlignment:NSTextAlignmentLeft];
    [cell->mpLabel1 setBackgroundColor:[UIColor clearColor]];
    cell->mpLabel2.frame = CGRectMake(210,  detailSize.height+35, 100, 30);
    [cell->mpLabel2 setTextAlignment:NSTextAlignmentRight];

    
	return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [mpTextView resignFirstResponder];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( _ctrStyle == jiaoliu)
	{
		NSDictionary * dic =mpDataAry[indexPath.row];
		NSDictionary * user =[dic objectForKey:@"User"];
		NSString * UserID =[user objectForKey:@"UserID"];
		
		
		NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
		NSString * uid =[userDefaults objectForKey:@"UserID"];
		
		if ([uid isEqualToString:UserID])
		{
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
		
		
		if (_ctrStyle==jiaoliu) {
			_ctrStyle = jiaoliubianqi;
		}
		
		
		[self getDataFromService:tag];
		
		
	}
	
    
    
    
    
}





#pragma mark - Refresh




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
    
    [mpTextView resignFirstResponder];
    
    
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
	
	
	NSMutableString * tempInfo = [[[NSMutableString alloc] init] autorelease];
    [tempInfo setString:info];
    [self resetString:tempInfo];
    
	
	NSString * result =[[tempInfo JSONValue] objectForKey:@"result"];

    if (tag == 100)
	{
        if (![tempInfo ifInvolveStr:@"list"]) {
            return;
        }
		
        [mpDataAry setArray:[tempInfo JSONValue][@"list"]];
        [mpTableView reloadData];
    }
	else if (tag == 101) {
		
		if ([result isEqualToString:@"1"]) {
			[mpTextView setText:@""];
			[mpTextView resignFirstResponder];
			[self getDataFromService:@""];
		}else{
			[NewItoast showItoastWithMessage:@"操作失败"];
		}
		
	
    }
	else if(tag==103)
	{
		
		if ([result isEqualToString:@"1"]) {
			
			[mpDataAry removeObjectAtIndex:myIndexPath.row];
			[mpTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:myIndexPath] withRowAnimation:UITableViewRowAnimationRight];
			[NewItoast showItoastWithMessage:@"删除成功"];
			
		}else{
			[NewItoast showItoastWithMessage:@"操作失败"];
		}
		
		_ctrStyle = jiaoliu;

	}
	
	else if (tag==104)
	{
		self.infoDic = [tempInfo JSONValue];
		[self setDataOfView];
		_ctrStyle = jiaoliu;

	}
	
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    if (_ctrStyle==jiaoliubianqi) {
		_ctrStyle = jiaoliu;
	}
}

-(void)saveDataToService
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/Reply.action"];
    [operation.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"ReplyID"];
    operation.tag = 101;
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
	
	if (_ctrStyle==jiaoliu) {
		operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/ReplyList.action"];
		[operation.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"ReplyID"];
		operation.tag = 100;
	}
	
	if (_ctrStyle==jiaoliubianqi) {
		
		operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/DeleteRemark.action"];
		NSDictionary * dic = (NSDictionary *)tag;
		[operation.argumentDic setValue:[dic objectForKey:@"GUID"]
                                 forKey:@"GUID"];
		operation.tag = 103;
	}
	
	if (_ctrStyle==tuisong) {
		
		operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/RemarkView.action"];
		[operation.argumentDic setValue:_guidString forKey:@"GUID"];
		operation.tag = 104;
	}
	
  
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
    [operation release];
}


@end
