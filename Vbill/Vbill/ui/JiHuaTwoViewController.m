//
//  JiHuaTwoViewController.m
//  Examination
//
//  Created by Zhang Bo on 13-7-22.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "JiHuaTwoViewController.h"
#import "DrawUpPlanCell.h"
#import "FirstViewController.h"
#import "XuanZeCell.h"
#define cellheight 60


#define pickertop 907.00


@interface JiHuaTwoViewController ()

@end

@implementation JiHuaTwoViewController

@synthesize theTitle = _theTitle;
@synthesize textField = _textField;
@synthesize delegate;
@synthesize textlLabel = _textlLabel;
-(void)dealloc
{
    [imageArray release];
	[_textlLabel release];
	[_textField release];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [CourseIDStr release];
    [myTableView  release],myTableView = nil;
    [leftDisArr release];
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
        screenHeight = [UIScreen mainScreen].bounds.size.height;
        screenWidth = [UIScreen mainScreen].bounds.size.width;
        leftDisArr =[NSArray arrayWithObjects:@"计划描述",@"选择科目",@"开始时间",@"结束时间",@"每天学习多少个知识点", nil];
        [leftDisArr retain];
        CourseIDStr =[[NSMutableString alloc] init];
        
        
        
        imageArray = @[@"jihuamiaoshu.png",@"xuanzekemu.png",@"kaishishijian.png",@"jieshushijian.png",@"zhishidian.png"];
        [imageArray retain];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = mySetColor;

    mpTitleLabel.text = _theTitle;
    [self addLeftButton];
    [self addRightBtn];
    [self addSubviews];
    [self addDatePicker];
	[self initNotification];
   
	
	CGPoint newP = CGPointMake(self.view.center.x,
							   self.view.center.y+screenHeight+45);
	myDateView.center = newP;
	
	
	NSLog(@"%lf",myDateView.center.y);
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
		NSLog(@"%@",NSStringFromCGRect(myDateView.frame));
		
    }];
}

-(void)keyboardWillShow:(NSNotification *)aNotification
{
	
	TSLocateView * ts = nil;
	
	for (UIView * view in [self.view subviews])
	{
		if ([view isKindOfClass:[TSLocateView class]])
		{
			 ts =(TSLocateView *)view;
			[ts cancel:@""];
		}
	}
	
	
	
	
	

	[UIView animateWithDuration:0.65 animations:^{
		
		if (ts.frame.origin.y==screenHeight-260)
			[ts cancel:nil];
		
		if(myDateView.center.y==screenHeight-130)
		{
			CGPoint newP = CGPointMake(self.view.center.x,
									   self.view.center.y+screenHeight+45);
			myDateView.center = newP;
		}

	}];
	

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)addSubviews
{
    
    CGRect rect = CGRectMake(0,44,screenWidth,screenHeight-44);

    myTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    myTableView.backgroundView=nil;
    
       
    myTableView.backgroundColor=[UIColor clearColor];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
    
    myTableView.rowHeight = 55;

}


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
                   action:@selector(reSetView)
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
	[toolbar addSubview:label];
	self.textlLabel = label;
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



-(void)addRightBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(320-55, 7, 50, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
	[btn.titleLabel setFont:myFont];

    [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:btn];
}



-(void)rightBtnClick
{
    [self reSetView];
    [self saveDataToService];
}

-(void)leftBtnClick
{
    [delegate refreshJiHua:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [leftDisArr count] ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!isGetSource)
        return cellheight;
    
    else
    {
        
        if (indexPath.row==1)
            return 1.5 * cellheight;
        else
            return cellheight;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    static NSString *CellIdentifier = @"Cell";
    
      
    if (indexPath.row!=4){
        
        DrawUpPlanCell *cell = [tableViews dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell==nil) {
            
            cell=[[[DrawUpPlanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.selectedBackgroundView.backgroundColor =[UIColor clearColor];
            cell.delegate = self;
            
            UIImage * image =[UIImage imageNamed:imageArray[indexPath.row]];
            cell.leftImageView.image = image;
        
            [cell.leftImageView setFrame:CGRectMake(7, 10, 19, 19)];
            [cell.leftLabel setFrame:CGRectMake(30, 5, 60, 30)];
            [cell.rightLabel setFrame:CGRectMake(100, 5, 210, 32)];
            [cell.rightTextField setFrame:CGRectMake(100, 5, 210, 32)];
            [cell->comboboxBtn setFrame:CGRectMake(100, 5, 210, 32)];
        }
        
        [self configureCell:cell atIndexPath:indexPath];
        
        return cell;
        
    }else{
     

        XuanZeCell *cell = [tableViews dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell==nil) {
            
            cell=[[[XuanZeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.selectedBackgroundView.backgroundColor =[UIColor clearColor];

            UIImage * image =[UIImage imageNamed:imageArray[indexPath.row]];
            cell.leftImageView.image = image;
            
            [cell.leftImageView setFrame:CGRectMake(7, 10, 19, 19)];
            [cell.leftLabel setFrame:CGRectMake(30, 5, 50, 30)];
            [cell.midLabel setFrame:CGRectMake(75, 5, 40, 30)];
            [cell.rightLabel setFrame:CGRectMake(120, 5,90, 30)];
        }
        
        return cell;
    }
    
}

- (void)configureCell:( DrawUpPlanCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
		self.textField = cell.rightTextField;
	}
    cell.cellStyle = indexPath.row;
    [cell.leftLabel setText:[leftDisArr objectAtIndex:indexPath.row]];
    cell.isGetSource = isGetSource;
    [cell setNeedsDisplay];
}



#pragma mark - WebService

-(void)saveDataToService
{
    
    
    for (int i =0; i<[leftDisArr count]-1; ++i  )
    {
        NSIndexPath * indexPath =[NSIndexPath indexPathForRow:i inSection:0];
        DrawUpPlanCell * cell =(DrawUpPlanCell *)[myTableView cellForRowAtIndexPath:indexPath];
        
        NSString * text = cell.rightTextField.text;
        
        if ([text length]==0)
        {
             [NewItoast showItoastWithMessage:@"请认真填写各项"];
            return;
        }
    }
    

    commonDataOperation * operation = [[commonDataOperation alloc] init];
    NSString * urlString  = @"/User/CreateStudyPlan.action";
    operation.tag = 30006;
    operation.urlStr = [serverIp stringByAppendingString:urlString];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    

    [operation.argumentDic setValue:CourseIDStr forKey:@"CourseID"];
    
    
    
    NSIndexPath * indexPath =[NSIndexPath indexPathForRow:0 inSection:0];
    DrawUpPlanCell * cell =(DrawUpPlanCell *)[myTableView cellForRowAtIndexPath:indexPath];
    NSString * s =cell.rightTextField.text;
    [operation.argumentDic setValue:s  forKey:@"Brief"];
    [operation.argumentDic setValue:sDate  forKey:@"StartDate"];
    [operation.argumentDic setValue:eDate forKey:@"CompleteDate"];
    [mpOperationQueue addOperation:operation];
    [operation release];
    
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
}
-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    
    NSString * result = [[info JSONValue] objectForKey:@"result"];
    
    if ([result isEqualToString:@"1"]) {
        [NewItoast showItoastWithMessage:@"提交成功"];
        [delegate refreshJiHua:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
-(void)FreshDataWithInfo:(NSString *)info with:(NSInteger)tag
{
 
}

-(void)WillAppeare:(NSInteger)tag
{
	

	
    uptag = tag;
	[_textField resignFirstResponder];
	
	TSLocateView * ts = nil;
	
	for (UIView * view in [self.view subviews])
	{
		if ([view isKindOfClass:[TSLocateView class]])
		{
			ts =(TSLocateView *)view;
		}
	}
	
	
    if (tag==1)
    {
        [self showLocateView];
    }
    else if (tag==2 || tag==3)
    {
        if (uptag==2) {
            
            if (sDate==nil) {
                sDate =[[NSDate date] retain];
                eDate =[[NSDate date] retain];
            }
            [datePicker setDate:sDate];
			[_textlLabel setText:@"开始时间"];
        }
        
        
        if (uptag==3) {

            if (eDate==nil) 
                eDate =[[NSDate date] retain];
                
            [datePicker setDate:eDate];
			
			[_textlLabel setText:@"结束时间"];



        }
        
        
		if (ts.frame.origin.y==screenHeight-280)
			[ts cancel:nil];
		
		
		myTableView.userInteractionEnabled = NO;
		
		[UIView animateWithDuration:0.65 animations:^{
			
			[self.view bringSubviewToFront:mpNavitateView];
			[self.view sendSubviewToBack:myDateView];
			[self.view bringSubviewToFront:myDateView];
			[myTableView setFrame:CGRectMake(0,0,screenWidth,screenHeight-44)];
			CGPoint newP = CGPointMake(self.view.center.x,
									   screenHeight-130);
			myDateView.center = newP;
		
		}];

    }
    
    
}




#pragma mark - UIActionSheetDelegate

- (void)showLocateView
{
    knowledgeCount = 0;
	myTableView.userInteractionEnabled = NO;

    NSArray * topArr =[FirstViewController getOriginalDataAry];
    NSString * title =@"选择科目";
    TSLocateView *locateView = [[TSLocateView alloc] initWithTitle:title
                                                             Array:topArr
                                                          delegate:self];
    [locateView showInView:self.view];
    [locateView setFrame:CGRectMake(0,screenHeight-260, screenWidth, 166)];
    [locateView release];
}

#pragma mark knowl


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	myTableView.userInteractionEnabled = YES;
    [myTableView setFrame:CGRectMake(0,44,screenWidth,screenHeight-44)];
    
    if (buttonIndex!=0)
    {
        
		isGetSource = YES;
		
        TSLocateView * locateView = (TSLocateView *)actionSheet;
        
		NSIndexPath * indexPath =[NSIndexPath indexPathForRow:1 inSection:0];
		DrawUpPlanCell * cell1 =(DrawUpPlanCell *)[myTableView cellForRowAtIndexPath:indexPath];
		
		NSString * nameStr =[NSString stringWithFormat:@"  %@",locateView.location.name];
		cell1.rightTextField.text = nameStr;
        
		
		[CourseIDStr setString:locateView.location.value];
		
		NSString * countStr =[NSString stringWithFormat:@"         %@ 个知识点",locateView.location.KnowledgeCount];
		
		knowledgeCount = [locateView.location.KnowledgeCount integerValue];
		[cell1.rightLabel setText:countStr];
		
        
        float number = 0;
        
        if (sDate==nil)
            number = knowledgeCount;
        else
            number = knowledgeCount/([eDate timeIntervalSinceDate:sDate]/24/3600+1);
		
        
        
		indexPath =[NSIndexPath indexPathForRow:4 inSection:0];
		XuanZeCell * cell2 =(XuanZeCell *)[myTableView cellForRowAtIndexPath:indexPath];
        cell2.midLabel.text = [NSString stringWithFormat:@"%.1f",number];
        
        
        
    }else{
        
        
        
            NSIndexPath * indexPath =[NSIndexPath indexPathForRow:1 inSection:0];
            DrawUpPlanCell * cell =(DrawUpPlanCell *)[myTableView cellForRowAtIndexPath:indexPath];
            cell.rightTextField.text = @"";
            [CourseIDStr setString:@""];
            [cell.rightLabel setText:@""];
            
        
        
    }
    
    [myTableView reloadData];
    
}

#pragma mark - datepicker



-(void)ensureDate:(id)sender
{
	myTableView.userInteractionEnabled = YES;
    [UIView animateWithDuration:0.65 animations:^{
		CGPoint newP = CGPointMake(self.view.center.x,
								   self.view.center.y+screenHeight+45);
		myDateView.center = newP;
	
		[myTableView setFrame:CGRectMake(0,44,screenWidth,screenHeight-44)];

	}];
	
	
	
    if (sDate==nil || eDate==nil) {
        return;
    }
    
    if ([sDate timeIntervalSinceNow]<0)
    {
        [sDate release];
        sDate = [[NSDate date] retain];
    }
    
    if ([eDate timeIntervalSinceDate:sDate]<0) {
        [eDate release];
        eDate = [sDate retain];
    }
    
    
    for (int i = 2; i<4; i++) {
        
        NSIndexPath * indexPath =[NSIndexPath indexPathForRow:i inSection:0];
        DrawUpPlanCell * cell =(DrawUpPlanCell *)[myTableView cellForRowAtIndexPath:indexPath];
        
        if (i==2) {
            cell.rightTextField.text = [[NSString stringWithFormat:@"  %@",sDate] substringToIndex:13];
        }
        
        if (i==3) {
            cell.rightTextField.text = [[NSString stringWithFormat:@"  %@",eDate] substringToIndex:13];
        }
    }
 
    float num = knowledgeCount/([eDate timeIntervalSinceDate:sDate]/24/3600+1);
    NSIndexPath * indexPath =[NSIndexPath indexPathForRow:4 inSection:0];
    XuanZeCell * cell =(XuanZeCell *)[myTableView cellForRowAtIndexPath:indexPath];
    cell.midLabel.text = [NSString stringWithFormat:@"%.1f",num];
}


-(void)selectDate:(id)sender
{
    if (uptag==2) {
        [sDate release];
        sDate =[[datePicker date] retain];
    }
    if (uptag==3) {
        [eDate release];
        eDate =[[datePicker date] retain];
    }
    
    [self ensureDate:nil];
}


-(void)reSetView
{
    
	myTableView.userInteractionEnabled = YES;
	
	[UIView animateWithDuration:0.65 animations:^{
	    [myTableView setFrame:CGRectMake(0,44,screenWidth,screenHeight-44)];

		CGPoint p = CGPointMake(self.view.center.x, self.view.center.y+screenHeight+45);
		myDateView.center = p;
	
	}];
    
    for (UIView * view in [self.view subviews])
    {
        if ([view isKindOfClass:[TSLocateView class]])
        {
            TSLocateView * ts =(TSLocateView *)view;
            [ts cancel:nil];
        }
    }
    
    for (int i =0; i<[leftDisArr count]-1; ++i  )
    {
        NSIndexPath * indexPath =[NSIndexPath indexPathForRow:i inSection:0];
        DrawUpPlanCell * cell =(DrawUpPlanCell *)[myTableView cellForRowAtIndexPath:indexPath];
        [ cell.rightTextField  resignFirstResponder];
        
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [self reSetView];
}


@end
