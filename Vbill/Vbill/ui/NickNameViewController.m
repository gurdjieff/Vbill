//
//  NickNameViewController.m
//  Examination
//
//  Created by Zhang Bo on 13-9-2.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "NickNameViewController.h"
#import "HtmlString.h"
@implementation NickNameViewController
@synthesize textField;
@synthesize delegate;
@synthesize mpLabel;
@synthesize _style;
@synthesize infoDic;
@synthesize mpTitleString;
@synthesize mpContentString;

-(void)dealloc
{
	delegate = nil;
	[mpContentString release];
	[mpTitleString release];
	[infoDic release];
	[textField release];
	[super dealloc];
}

-(id)init
{
	return [self initWithNibName:nil bundle:nil];
}




-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		
	}
	
	return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addRightBtn];
	[self addLeftButton];
	[self addsubView];
	mpTitleLabel.text =mpTitleString;

}


-(void)leftBtnClick
{
	[delegate callbackNickName:YES];
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
    [btn setTitle:@"修改" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:btn];
}

-(void)saveDataToService
{
	
	NSString * txt = self.textField.text;
	
	
	if (_style==nickname ) {
		if ([txt length]==0)
		{
			[NewItoast showItoastWithMessage:@"昵称不得为空!"];
			return;
		}
		if ([txt isEqualToString:infoDic[@"NickName"]])
		{
			[NewItoast showItoastWithMessage:@"请认真修改信息!"];
			return;
		}
		
		
	}
	
	
	if (_style==nicktel) {
		
		if(![self validateUserPhone:txt])
		{
			[NewItoast showItoastWithMessage:@"请输入正确的手机号码!"];
			return;
		}

		if ([txt isEqualToString:infoDic[@"Mobile"]])
		{
			[NewItoast showItoastWithMessage:@"请认真修改信息!"];
			return;
		}
		
	}
	
	if (_style==nickdate){
		
		
		if([txt isEqualToString:infoDic[@"BirthDate"]])
		{
			[NewItoast showItoastWithMessage:@"请认真修改信息!"];
			return;
		}
		else
		{
			NSDate * date =[NSDate date];
			NSInteger  now =[[[NSString stringWithFormat:@"%@",date] substringToIndex:4] integerValue];
			NSInteger time =[[[NSString stringWithFormat:@"%@",[datePicker date]] substringToIndex:4] integerValue];
			
			if (time-now>=0
				|| time-now<-100
				|| [self.textField.text length]==0) {
				
				[NewItoast showItoastWithMessage:@"请输入正确的日期!"];
				return;
			}
		}
		
		

		
		
	}
	
	
	commonDataOperation * operation = [[commonDataOperation alloc] init];
	operation.urlStr = [serverIp stringByAppendingFormat:@"/User/UpdateUserInfo.action"];
	
	[operation.argumentDic setObject:infoDic[@"NickName"] forKey:@"NickName"];
	[operation.argumentDic setObject:infoDic[@"Mobile"] forKey:@"Mobile"];
		
	[operation.argumentDic setObject:infoDic[@"BirthDate"] forKey:@"BirthDate"];
	
	if (_style==nickname) {
			[operation.argumentDic setObject:self.textField.text forKey:@"NickName"];
	}

	if (_style==nicktel) {
			[operation.argumentDic setObject:self.textField.text forKey:@"Mobile"];
	}
	
	if (_style==nickdate) {
		[operation.argumentDic setObject:self.textField.text forKey:@"BirthDate"];
	}

	
	
	
	operation.downInfoDelegate = self;
	[mpOperationQueue addOperation:operation];
	[operation release];

}


-(void)addsubView
{
	UITextField *mpOldPassword = [[UITextField alloc] initWithFrame:CGRectMake(10, 56, screenWidth-20, 32)];
    mpOldPassword.backgroundColor = [UIColor whiteColor];
	[mpOldPassword setFont:[UIFont systemFontOfSize:16]];
    mpOldPassword.borderStyle = UITextBorderStyleRoundedRect;
    mpOldPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:mpOldPassword];
	if (_style==nickname) {
		mpOldPassword.textAlignment =NSTextAlignmentLeft;

		[mpOldPassword becomeFirstResponder];
		mpOldPassword.keyboardType =UIKeyboardTypeDefault;
	}
	
	if (_style==nicktel) {
		mpOldPassword.textAlignment =NSTextAlignmentLeft;

		[mpOldPassword becomeFirstResponder];
		mpOldPassword.keyboardType =UIKeyboardTypeNumbersAndPunctuation;
	}
	
	if (_style==nickdate) {
		mpOldPassword.textAlignment =NSTextAlignmentCenter;
		[mpOldPassword resignFirstResponder];
		[mpOldPassword setUserInteractionEnabled:YES];
	}
	mpOldPassword.delegate =self;
	[mpOldPassword setText:self.mpContentString];
	self.textField = mpOldPassword;
    [mpOldPassword release];
	
	UILabel* pLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, screenWidth-20, 30)];
    pLabel.backgroundColor = [UIColor clearColor];
    pLabel.font = [UIFont boldSystemFontOfSize:16];
	[pLabel setTextAlignment:NSTextAlignmentCenter];
	[pLabel setText:self.mpLabel];
    pLabel.textColor = [UIColor grayColor];
    [self.view addSubview:pLabel];
    [pLabel release];

	if (_style==nickdate) {
		[self addDatePicker];
		

		[UIView animateWithDuration:0.65f
							  delay:0.5f
							options:UIViewAnimationOptionCurveEaseOut
						 animations:^
		 {
			 CGPoint newP = CGPointMake(self.view.center.x,
										screenHeight-130);
			 myDateView.center = newP;
		 }
						 completion:nil];

		
	}
	

}


-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
	
    if ([info ifInvolveStr:@"\"result\":\"1\""])
	{
		[delegate callbackNickName:NO];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
	
}



#pragma mark - datepicker


-(void)addDatePicker
{
	
    
    myDateView =[[UIView alloc] init];
    
    [myDateView setFrame:CGRectMake(0, screenHeight+45, screenWidth, 216+45)];
    [myDateView setUserInteractionEnabled:YES];
    [myDateView setBackgroundColor:[UIColor clearColor]];
    
    
    [self.view addSubview:myDateView];
    [myDateView release];
    
    
	UIToolbar * toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    [toolbar sizeToFit];
    toolbar.frame = CGRectMake(0, 0,screenWidth, 45);
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIButton *leftTopBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftTopBtn.frame= CGRectMake(0, 2, 42, 42);
    [leftTopBtn addTarget:self
                   action:@selector(reSetDatePicker:)
         forControlEvents:UIControlEventTouchUpInside];
    [leftTopBtn setBackgroundImage:[UIImage imageNamed:@"btn_021.png"] forState:UIControlStateNormal];
	
    UIBarButtonItem * leftItem =[[[UIBarButtonItem alloc]initWithCustomView:leftTopBtn] autorelease];
    
    [barItems addObject:leftItem];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                  target:self action:nil];
    [barItems addObject:flexSpace];
    
	
    UIButton *rightTopBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightTopBtn.frame= CGRectMake(0, 2, 42, 42);
    [rightTopBtn addTarget:self
                    action:@selector(ensureDate:)
          forControlEvents:UIControlEventTouchUpInside];
    [rightTopBtn setBackgroundImage:[UIImage imageNamed:@"btn_020.png"] forState:UIControlStateNormal];
    UIBarButtonItem * btn =[[UIBarButtonItem alloc]initWithCustomView:rightTopBtn];
    [barItems addObject:btn];
    
    
    [toolbar setItems:barItems animated:YES];
    [myDateView addSubview:toolbar];
    
	UILabel * label = [[UILabel alloc] init];
	[label setFrame:CGRectMake(42, 0, screenWidth-84, 45)];
	[label setTextColor:[UIColor whiteColor]];
	[label setFont:[UIFont systemFontOfSize:18]];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextAlignment:NSTextAlignmentCenter];
	[label setText:@"选择日期"];
	[toolbar addSubview:label];
	[label release];
    
    [flexSpace release];
    [btn release];
    [toolbar release];
    [barItems release];
    
    
    CGRect rect = CGRectMake(0, 45, screenWidth, 216);
    datePicker=[[UIDatePicker alloc]initWithFrame:rect];
    datePicker.datePickerMode=UIDatePickerModeDate;
    [datePicker addTarget:self
                   action:@selector(selectDate:)
         forControlEvents:UIControlEventValueChanged];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter release];
    [myDateView addSubview:datePicker];
    [datePicker release];
	
}


-(void)reSetDatePicker:(id)sender
{
	
	[NewItoast showItoastWithMessage:@"请选择你的生日"];
	
	self.textField.text =@"";

	
	return;
	
	[UIView animateWithDuration:0.65 animations:^{
		
		CGPoint newP = CGPointMake(self.view.center.x,
								   self.view.center.y+screenHeight+45);
		myDateView.center = newP;
			 
		self.textField.text =@"";
	}];
}


-(void)selectDate:(id)sender
{
	self.textField.text = [[NSString stringWithFormat:@"%@",[datePicker date]] substringToIndex:10];
}

-(void)ensureDate:(id)sender
{
    [UIView animateWithDuration:0.65 animations:^{
		CGPoint newP = CGPointMake(self.view.center.x,
								   self.view.center.y+screenHeight+45);
		myDateView.center = newP;
		
		self.textField.text = [[NSString stringWithFormat:@"%@",[datePicker date]] substringToIndex:10];
		
		
	}];
	
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)txtField
{
	[self.textField resignFirstResponder];

	[UIView animateWithDuration:0.65 animations:^{
		
		CGPoint newP = CGPointMake(self.view.center.x,
								   screenHeight-130);
		myDateView.center = newP;

	}];

	return NO;
}

- (BOOL) validateUserPhone:(NSString *)str
{
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^1[3|4|5|8][0-9][0-9]{8}$"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
	
	
	
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
	
    [regularexpression release];
	
    if(numberofMatch > 0)
	{
        return YES;
	}
	
    return NO;
	
	
}


@end
