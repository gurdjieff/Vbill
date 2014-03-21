//
//  MultiLineTextViewController.m
//  MultiLineText
//
//  Created by Henry Yu on 3/29/09.
//  Copyright 2009 Sevenuc.com. All rights reserved.
//

#import "RemarkViewController.h"
#import "CustomAlertView.h"
#import "FirstViewThreeController.h"

@implementation RemarkViewController
@synthesize string;
@synthesize textView;
@synthesize delegate = _delegate;
@synthesize infoDict = _infoDict;
@synthesize theTitle = _theTitle;
@synthesize myStyle = _myStyle;

#pragma mark -

- (void)dealloc
{
    _delegate =nil;
    [mpRemarkDic release], mpRemarkDic = nil;
    [mpInfoDic release], mpInfoDic = nil;
    [_theTitle  release];
    [_infoDict release];
    [string release];
    [textView release];
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

        mpRemarkDic = [[NSMutableDictionary alloc] init];

    }
    return self;
}


- (void)viewDidLoad 
{
    [super viewDidLoad];
 
    [self addSubViews];
    [self addLeftButton];
    
    if (_myStyle==fabiao) {
        mpTitleLabel.text = @"写笔记";
        [self addRightBtn];
        [self getDataFromService];
    }
    
    if (_myStyle==duqu) {
        mpTitleLabel.text = _theTitle;
		[self addRightBtn];
        [self getDataFromService];
    }
    
    if (_myStyle==fankui) {
        mpTitleLabel.text = @"意见反馈";
        [self addRightBtn];
    }
    
    if (_myStyle==jiaoliu) {
        mpTitleLabel.text = @"发表交流";
        [self addRightBtn];
    }
    
}

- (void)addSubViews
{
    self.view.backgroundColor = [UIColor colorWithRed:190.0f/255 green:190.0f/255 blue:190.0f/255 alpha:0.6];
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,44,screenWidth,screenHeight) style:UITableViewStyleGrouped];
    myTableView.backgroundView=nil;
    myTableView.backgroundColor=mySetColor;
    myTableView.delegate=self;
    myTableView.dataSource=self;
    myTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:myTableView];
    
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

-(void)rightBtnClick
{
    [self saveDataToService];
}

-(void)addRightBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(320-55, 7, 50, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [btn setTitle:@"发表" forState:UIControlStateNormal];
	[btn.titleLabel setFont:myFont];
    [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:btn];
}



#pragma mark Tableview 



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_myStyle==fabiao
        || _myStyle ==fankui
        || _myStyle ==jiaoliu)
        return screenHeight-320;
    
    else
        return screenHeight-88;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        if (_myStyle==fabiao || _myStyle ==duqu)
        {
            UILabel * lpLabel1 = [[UILabel alloc] init];
            [lpLabel1 setFrame:CGRectMake(10, 5, 280, 30)];
            lpLabel1.backgroundColor = [UIColor clearColor];
			[lpLabel1 setTag:201];
            [[cell contentView] addSubview:lpLabel1];
            [lpLabel1 release];
            
            UILabel * lpLabel2 = [[UILabel alloc] init];
            [lpLabel2 setFrame:CGRectMake(10, 29, 38, 1)];
            lpLabel2.backgroundColor = [UIColor blackColor];
			[lpLabel2 setTag:202];
            [[cell contentView] addSubview:lpLabel2];
            [lpLabel2 release];
			
			UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
			[btn addTarget:self
					action:@selector(btnClick:)
		  forControlEvents:UIControlEventTouchUpInside];
			[btn setFrame:CGRectZero];
			[btn setTag:203];
			[[cell contentView] addSubview:btn];
            
        }
      
		UITextView *theTextView = [[UITextView alloc] init];
        theTextView.scrollEnabled = YES;
        theTextView.text = string;
		theTextView.font = [UIFont systemFontOfSize:14.0];
		[theTextView becomeFirstResponder];		
		self.textView = theTextView;
		[[cell contentView] addSubview:theTextView];
		[theTextView release];
    }
    
	
	[self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:( UITableViewCell *)cell
		  atIndexPath:(NSIndexPath *)indexPath
{
	
	if (_myStyle == duqu) {
		
		UILabel * label =(UILabel *)[[cell contentView] viewWithTag:201];
		[label setText:@"笔记"];
		
		UILabel * label2 =(UILabel *)[[cell contentView]
									  viewWithTag:202];
		[label2 setFrame:CGRectMake(10, 29, 38, 1)];

		
		self.textView.editable = YES;
		[self.textView setFrame:CGRectMake(10.0, 33.0, 280.0, screenHeight-133-232)];
		
	}
	
	
	else if (_myStyle==fabiao) {
		UILabel * label1 =(UILabel *)[[cell contentView]
									 viewWithTag:201];
		[label1 setText:_infoDict[@"Name"]];
		
		UILabel * label2 =(UILabel *)[[cell contentView]
									  viewWithTag:202];
		[label2 setFrame:CGRectMake(10, 29, 280, 1)];

		UIButton * btn =(UIButton *)[[cell contentView]
									 viewWithTag:203];
		
		[btn setFrame:CGRectMake(10, 5, 280, 30)];
		
		self.textView.editable = YES;
		[self.textView setFrame:CGRectMake(10.0, 33.0, 280.0, screenHeight-133-232)];
		
	}
	else if (_myStyle==fankui){
		self.textView.editable = YES;
		[self.textView setFrame:CGRectMake(10.0, 5.0, 280.0, screenHeight-133-232+27)];
		
	}else if (_myStyle==jiaoliu){
		
		self.textView.editable = YES;
		[self.textView setFrame:CGRectMake(10.0, 5.0, 280.0, screenHeight-133-232+27)];
		
	}else{
		
		self.textView.editable = NO;
		[self.textView setFrame:CGRectMake(10.0, 33.0, 280.0, screenHeight-133)];
	}
	
}


#pragma mark - WebService

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    
}
-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
  
    if (![info ifInvolveStr:@"result"]) {
        return;
    }
    
    if (tag == 100) {
        NSDictionary * dic = [NSDictionary dictionaryWithDictionary:[info JSONValue]];
        [mpRemarkDic setDictionary:dic];
        
        if ([dic[@"result"] intValue] == 1) {
            textView.text =[dic objectForKey:@"Brief"];
        }
        textView.selectedRange = NSMakeRange([textView.text length], 0);

        [textView becomeFirstResponder];
    }
    
    if (tag == 101) {
//        if ([info ifInvolveStr:@"\"result\":\"1\""]) {
//            CustomAlertView * alertView = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:@"发表成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [alertView show];
//            [alertView release];
//            
//            [self.navigationController popViewControllerAnimated:YES];
//        }
        
        if ([info ifInvolveStr:@"\"result\":\"1\""]) {
            [NewItoast showItoastWithMessage:@"提交成功"];
            [textView setText:@""];
            
            [self.navigationController popViewControllerAnimated:YES];
        }else
            [NewItoast showItoastWithMessage:@"提交失败!"];
        
    }
    
    if (tag== 102) {
        if ([info ifInvolveStr:@"\"result\":\"1\""]) {
            [NewItoast showItoastWithMessage:@"提交成功"];
            [textView setText:@""];
            [self.navigationController popViewControllerAnimated:YES];

        }
    }

    if (tag== 103) {
        if ([info ifInvolveStr:@"\"result\":\"1\""]) {
            [NewItoast showItoastWithMessage:@"提交成功"];
            [textView setText:@""];
            
            if (_delegate !=nil
                && [_delegate respondsToSelector:@selector(refreshJiaoLiu:)]) {
                
                [_delegate refreshJiaoLiu:YES];
                
                
            }
            
            
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(void)saveDataToService
{
    if (self.textView.text.length == 0) {
        [NewItoast showItoastWithMessage:@"内容不能为容"];
        return;
    }
    
    if (_myStyle==jiaoliu) {
        commonDataOperation * operation = [[commonDataOperation alloc] init];
        operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/Remark.action"];
        operation.tag = 103;
        operation.showAnimation = NO;
        
        NSString * info = [NSString stringWithString:self.textView.text];
        [operation.argumentDic setValue:info forKey:@"Brief"];
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        [mpOperationQueue addOperation:operation];
        [operation release];
    }
    
    
    if (_myStyle==fabiao || _myStyle ==duqu) {
        commonDataOperation * operation = [[commonDataOperation alloc] init];
        operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/Note.action"];
        [operation.argumentDic setValue:[_infoDict objectForKey:@"GUID"] forKey:@"CourseID"];
        operation.tag = 101;
        operation.showAnimation = NO;

        NSString * info = [NSString stringWithString:self.textView.text];
        
        if (info.length == 0 && mpRemarkDic[@"GUID"]) {
            [operation.argumentDic setValue:mpRemarkDic[@"GUID"] forKey:@"GUID"];
        }
        [operation.argumentDic setValue:info forKey:@"Brief"];
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        [mpOperationQueue addOperation:operation];
        [operation release];
    }
    
    if (_myStyle==fankui) {
        
        commonDataOperation * operation = [[commonDataOperation alloc] init];
        operation.urlStr = [serverIp stringByAppendingFormat:@"/System/Feedback.action"];
        operation.tag = 102;
        operation.showAnimation = NO;
        NSString * info = [NSString stringWithString:self.textView.text];
        
        //    if (info.length == 0) {
        //        [operation.argumentDic setValue:mpRemarkDic[@"GUID"] forKey:@"GUID"];
        //    }
        [operation.argumentDic setValue:info forKey:@"Brief"];
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        [mpOperationQueue addOperation:operation];
        [operation release];
    }
    
  
}

-(void)getDataFromService
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/Note.action"];
    [operation.argumentDic setValue:[_infoDict objectForKey:@"GUID"] forKey:@"CourseID"];
    operation.tag = 100;
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
    [operation release];
}




-(void)btnClick:(id)sender
{
	FirstViewThreeController * lpView = [[FirstViewThreeController alloc] init];
	
	lpView.infoDic = _infoDict;
	[self.navigationController pushViewController:lpView animated:YES];
	[lpView release];

}




@end

