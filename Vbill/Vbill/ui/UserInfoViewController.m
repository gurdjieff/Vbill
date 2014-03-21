//
//  UserInfoViewController.m
//  Examination
//
//  Created by Zhang Bo on 13-8-21.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "UserInfoViewController.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "ApiAccount.h"
#import "NickNameViewController.h"




@interface UserInfoViewController ()
@end

@implementation UserInfoViewController
@synthesize myPhotoImageView;

@synthesize infoDict;
-(void)dealloc
{
	[infoDict release];
	[myPhotoImageView release];
	[labelNameArr release];
	[super dealloc];
}

- (id)init
{
    return [self initWithNibName:nil bundle:nil];
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        isRefresh = NO;
        isUploading = NO;
        isChange = NO;
        labelNameArr =@[@"学习计划完成度(知识点)",@"昵称",@"手机",@"出生日期"];
		[labelNameArr retain];
    }
    
    return self;
}

- (void)viewDidLoad
{
    mpTitleLabel.text = @"用户中心";
    [super viewDidLoad];
    [self addLeftButton];
    [self addSubviews];
    [self addHeadView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)callbackNickName:(BOOL)tag
{
	isRefresh = tag;
}


-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	if (!isRefresh) {
		[self getDataFromService];
	}
 
}

#pragma mark - WebService


-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    
	isUploading = NO;
	isChange = NO;
    if ([info ifInvolveStr:@"\"result\":\"1\""])
	{
       
        if (tag==101) {
            NSDictionary * infoDics =[info JSONValue];
			self.infoDict = infoDics;
            
            UIView * headView =myTableView.tableHeaderView;
            
            
            
            
            
            int  n =[infoDics[@"ExamDate"] intValue];
            
            int examDate = n;
            NSDate * date = [NSDate dateWithTimeIntervalSinceNow:examDate*24*60*60];
            int year = [self getCurrentYear:date];
            
            
            UILabel * label =(UILabel *)[headView viewWithTag:2013111401];
            
            [label setText:[NSString stringWithFormat:@"距离%d年考研还有:",year]];

            NSString * str1 =[NSString stringWithFormat:@"%d.png",n/100%10];
            
            NSString * str2 =[NSString stringWithFormat:@"%d.png",n/10%10];
            
            NSString * str3 =[NSString stringWithFormat:@"%d.png",n%10];

            
            
            UIImageView * imageView1 =(UIImageView *)[headView viewWithTag:20131111+0];
            imageView1.image =[UIImage imageNamed:str1];
            
            UIImageView * imageView2 =(UIImageView *)[headView viewWithTag:20131111+1];
            imageView2.image =[UIImage imageNamed:str2];

            
            UIImageView * imageView3 =(UIImageView *)[headView viewWithTag:20131111+2];
            
            imageView3.image =[UIImage imageNamed:str3];

            
            
            
        }
		
		
    }
    
	[myTableView reloadData];
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
     isUploading = NO;
    isChange = NO;
}

-(void)saveDataToService
{
	if (!isChange) {
		
		[NewItoast showItoastWithMessage:@"你确定已经更换头像？"];
		return;
		
	}
	
	if (isUploading) {
		
		[NewItoast showItoastWithMessage:@"正在上传中......"];
		
		return;
	}
	
	isUploading = YES;
	
	
	commonDataOperation * operation = [[commonDataOperation alloc] init];
	operation.urlStr = [serverIp stringByAppendingFormat:@"/User/UploadHeadPhoto.action"];
	operation.tag = 102;
	operation.isPOST = YES;
	operation.isImage = YES;
	UIImage * newimage =[self imageWithImageSimple:self.myPhotoImageView.image		scaledToSize:CGSizeMake(200, 200)];
	operation.newimage = newimage;
	operation.downInfoDelegate = self;
	[mpOperationQueue addOperation:operation];
	[operation release];

	  
}

-(void)getDataFromService
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/User/UserInfo.action"];
    operation.tag = 101;
    [operation.argumentDic setValue:[userDefaults objectForKey:@"UserName"] forKey:@"UserName"];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
    [operation release];
}

#pragma mark - InterFace

- (void)takePicture:(id)sender
{
    UIImagePickerController *imagePickerController =
    [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentModalViewController:imagePickerController animated:YES];
    [imagePickerController release];

}



- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    isChange = YES;
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.myPhotoImageView setImage:image];
    [self dismissModalViewControllerAnimated:YES];
	[self saveDataToService];
	isRefresh = NO;

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}





-(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);

    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];

    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return newImage;
}






#pragma mark - Table view data source

-(void)addSubviews
{
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(10,44,screenWidth-20,screenHeight-44) style:UITableViewStyleGrouped];
    myTableView.backgroundView=nil;
    myTableView.backgroundColor=[UIColor clearColor];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    myTableView.scrollEnabled = YES;
    [self.view addSubview:myTableView];
	[myTableView release];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section==0) {
		return 1;
	}
	else
		return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section==0) {
		return 233/2;
	}else
		return 84/2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableViews dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell==nil) {
        
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
		UIColor * color =[UIColor colorWithRed:244.0/255
										 green:244.0/255
										  blue:244.0/255
										 alpha:1];
		cell.backgroundColor = color;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		if (indexPath.section ==0 )
		{
			
			UILabel * leftlabel =[[UILabel alloc] init];
			[leftlabel setFont:[UIFont systemFontOfSize:14]];
			[leftlabel setBackgroundColor:[UIColor clearColor]];
			[leftlabel setTextAlignment:NSTextAlignmentLeft];
			[leftlabel setTextColor:[UIColor colorWithRed:69.0/255
													green:53.0/255
													 blue:61.0/255
													alpha:1]];
			[leftlabel setTag:200+indexPath.row];
			[cell.contentView addSubview:leftlabel];
			[leftlabel release];
			
			UIImageView * ImageView = [[UIImageView alloc] init];
			ImageView.frame = CGRectMake(168, 15,84, 84);
			UIImage * image =[UIImage imageNamed:@"photo.png"];
			[ImageView	 setImage:image];
			[[cell contentView] addSubview:ImageView];
			[ImageView release];
			
			UIImageView * photoImageView = [[UIImageView alloc] init];
			photoImageView.frame = CGRectMake(171, 18,78, 78);
			self.myPhotoImageView = photoImageView;
			[photoImageView setUserInteractionEnabled:NO];
			[[cell contentView] addSubview:photoImageView];
			[photoImageView release];
			
		}
		
		else{
			
            if (indexPath.row==0) {
                cell.accessoryType = UITableViewCellAccessoryNone;

            }
            
            
			UILabel * leftlabel =[[UILabel alloc] init];
			[leftlabel setFont:[UIFont systemFontOfSize:14]];
			[leftlabel setBackgroundColor:[UIColor clearColor]];
			[leftlabel setTextAlignment:NSTextAlignmentLeft];
			[leftlabel setTextColor:[UIColor colorWithRed:69.0/255
													green:53.0/255
													 blue:61.0/255
													alpha:1]];
			[leftlabel setTag:300+indexPath.row];

			[cell.contentView addSubview:leftlabel];
			[leftlabel release];
			
			
			UILabel * rightlabel =[[UILabel alloc] init];
			[rightlabel setFont:[UIFont systemFontOfSize:14]];
			[rightlabel setFrame:CGRectMake(70,5, 180, 30)];
			[rightlabel setBackgroundColor:[UIColor clearColor]];
			[rightlabel setTextAlignment:NSTextAlignmentRight];
			[rightlabel setTextColor:[UIColor colorWithRed:69.0/255
													 green:53.0/255
													  blue:61.0/255
													 alpha:1]];
			
			[rightlabel setTag:400+indexPath.row];
			[cell.contentView addSubview:rightlabel];
			[rightlabel release];
			
		}
		
 
		
    }
	
	
	[self configureCell:cell atIndexPath:indexPath];
	
    return cell;
}
- (void)configureCell:( UITableViewCell *)cell
		  atIndexPath:(NSIndexPath *)indexPath
{
	
	
	if (indexPath.section==0)
	{
		UILabel * leftlabel =(UILabel *)[[cell contentView] viewWithTag:200+indexPath.row];
		
		[leftlabel setText:@"头像"];
		[leftlabel setFrame:CGRectMake(10,40, 80, 30)];
		
		NSString * url = [infoDict objectForKey:@"HeadPhotoUrl"];
		[self.myPhotoImageView setImageWithURL:[NSURL URLWithString:url]
							  placeholderImage:nil];
		
	}
	else
	{
		UILabel * leftlabel =(UILabel *)[[cell contentView] viewWithTag:300+indexPath.row];
		[leftlabel setText:[labelNameArr objectAtIndex:indexPath.row]];
		[leftlabel setFrame:CGRectMake(10,5, 210, 30)];
		
		
		UILabel * rightlabel =(UILabel *)[[cell contentView] viewWithTag:400+indexPath.row];
		
		int tag =[indexPath row];
		
        
        if (tag==0) {
            [rightlabel setText:infoDict[@"StudyRate"]];
        }
        
        
		if (tag==1)
			[rightlabel setText:infoDict [@"NickName"]];
		
		if (tag==2)
			[rightlabel setText:infoDict [@"Mobile"]];

		if (tag==3)
			[rightlabel setText:infoDict [@"BirthDate"]];
		
		
	}
	
	
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
		[self photoclick:@""];
	}
	
	if (indexPath.section==1) {
        
        if (indexPath.row==0) {
            return;
        }
        
		
		NickNameViewController * nvc =[[NickNameViewController alloc] init];
		nvc.delegate =self;
		if (self.infoDict != nil) {
			nvc.infoDic = self.infoDict;
		}
		
		if (indexPath.row==1) {
			nvc._style = nickname;
			nvc.mpLabel=@"好名字会让更多的朋友记住你";
			nvc.mpTitleString =	@"修改昵称";
			nvc.mpContentString =infoDict[@"NickName"];
		}
		
		if (indexPath.row==2) {
			nvc._style= nicktel;
			nvc.mpLabel=@"填写你的手机号码吧";
			nvc.mpTitleString =	@"修改手机号码";
			nvc.mpContentString =infoDict[@"Mobile"];
		}

		if (indexPath.row==3) {
			nvc._style = nickdate;
			nvc.mpLabel=@"填写你的生日吧";
			nvc.mpTitleString =	@"修改出生日期";
			nvc.mpContentString= infoDict[@"BirthDate"];
		}
		
		[self.navigationController pushViewController:nvc animated:YES];
        
		[nvc release];
		
	}

}

#pragma mark -photoclick


-(void)photoclick:(id)sender
{
    
    isRefresh = YES;
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照",
								  @"从相册选择照片",nil];
    actionSheet.tag = 501;
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
    [actionSheet release];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
   if (actionSheet.tag ==501){
        switch (buttonIndex) {
            case 0:
                [self selectImage:0];
                break;
            case 1:
                [self selectImage:1];
                break;
            default:
                break;
        }
    }
    
}



- (void) selectImage:(int)sender
{
    UIImagePickerController *imagePickerController =
    [[[UIImagePickerController alloc] init] autorelease];
    
    
    if (sender==0) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.delegate = self;
            [self presentModalViewController:imagePickerController animated:YES];
        }else{
            
			
			 [NewItoast showItoastWithMessage:@"相机不可用!"];
        }
        
    }else{
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.delegate = self;
        [self presentModalViewController:imagePickerController animated:YES];
    }
    
    
    
    
	
}



-(void)ShowPicture:(id)sender
{
	[self photoclick:sender];
}


#pragma mark - newView



-(void)addHeadView
{
    
    int year = [self getCurrentYear:[NSDate date]];

    UIView * view =[[UIView alloc] init];
    [view setFrame:CGRectMake(0, 0, 320, 80)];
    [view setBackgroundColor:[UIColor clearColor]];

    
    
    UILabel * label =[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 280, 24)];
    [label setText:[NSString stringWithFormat:@"距离%d年考研还有:",year]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setFont:[UIFont boldSystemFontOfSize:24]];
    [label setTextColor:[UIColor colorWithRed:89.0/255 green:75.0/255 blue:68.0/255 alpha:1]];
    [label setTag:2013111401];
    [label setBackgroundColor:[UIColor clearColor]];
    [view addSubview:label];
    [label release];
    
    UILabel * label2 =[[UILabel alloc] initWithFrame:CGRectMake(210,65, 40, 24)];
    [label2 setText:@"天"];
    [label2 setTextAlignment:NSTextAlignmentRight];
    [label2 setFont:[UIFont boldSystemFontOfSize:24]];
    [label2 setTextColor:[UIColor colorWithRed:89.0/255 green:75.0/255 blue:68.0/255 alpha:1]];
    [label2 setBackgroundColor:[UIColor clearColor]];
    [view addSubview:label2];
    [label2 release];
    
    
    for (int i =0; i<3; i++) {
        UIImageView * imageview =[[UIImageView alloc ] init];
        [imageview setFrame:CGRectMake(130+32*i , 50, 27, 37)];
        [imageview setBackgroundColor:[UIColor clearColor]];
        [imageview setTag:20131111+i];
        [view addSubview:imageview];
        [imageview release];
    }
    
    
    myTableView.tableHeaderView = view;

    [view release];
    
  
    
}


#pragma mark - 

-(NSInteger)getCurrentYear:(NSDate *)apDate
{
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSDateComponents * components = [cal components:NSYearCalendarUnit
                                     | NSMonthCalendarUnit
                                     | NSDayCalendarUnit
                                     | NSHourCalendarUnit
                                     | NSMinuteCalendarUnit
                                     | NSWeekdayCalendarUnit fromDate:apDate];
    NSInteger year = [components year];
    return year;
}




@end
