//
//  SecondTwoViewController.h
//  Examination
//
//  Created by Zhang Bo on 13-7-13.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "ThirdOneViewController.h"
#import "ThirdTwoViewController.h"
#import "ThirdViewController.h"
#import "FirstViewCommentCtr.h"

#define kNum 2
#define kCell_Items_Width 310/2
#define kCell_Items_Height 278/2


@implementation ThirdOneViewController
@synthesize helper;

-(void)dealloc
{
    [tbView release];
    [data release];
    [helper release];
    [super dealloc];
}


- (void) initData
{
    data = [[NSArray alloc] initWithObjects:
            @"学习计划",
            @"书签笔记",
            @"名家讲堂",
            @"学习交流",nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    if(!tbView){
        tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height-88) style:UITableViewStylePlain];
        
        
        tbView.delegate = self;
        tbView.dataSource = self;
        tbView.separatorColor = [UIColor clearColor];
        tbView.backgroundColor = [UIColor clearColor];
        tbView.scrollEnabled = YES;
        tbView.showsVerticalScrollIndicator = NO;
    }
    [self.view addSubview:tbView];
    [self initData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = ([data count]+kNum-1)/kNum;
    if (bLandScape) {
        count = ([data count]+kNum)/(kNum+1);
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"etuancell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (!cell) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = mySetColor;

    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }

    CGFloat x = 2;
    CGFloat y = 2;
    
    NSInteger nowNum = kNum;
    if (bLandScape) {
        nowNum += 1;
    }
    
    NSInteger row = indexPath.row * nowNum;
    
    for (int i = 0; i<nowNum; ++i) {

        if (row >= [data count]) {
            break;
        }

        
        UIImageView *bookView = [[UIImageView alloc] initWithFrame:CGRectMake(x+2, y, kCell_Items_Width, kCell_Items_Height)];
        
        bookView.image = [UIImage imageNamed:[NSString stringWithFormat:@"yingyong0%d",row+1]];
        [cell.contentView addSubview:bookView];
        [bookView release];
        


        UIButton *bookButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [bookButton setBackgroundColor:[UIColor clearColor]];

        bookButton.frame = CGRectMake(x+2, y, kCell_Items_Width, kCell_Items_Height);
        bookButton.tag = row;
        [bookButton addTarget:self action:@selector(testButton:) forControlEvents:UIControlEventTouchUpInside];

        [cell.contentView addSubview:bookButton];
        
        x += (5+kCell_Items_Width);
        ++row;
    }
    
            
	return cell;
}

- (void) testButton:(id)sender{
    
    UIButton * btn =(UIButton *)sender;
    int index = btn.tag;
    
    
    
    if (index==3)
    {
        
        FirstViewCommentCtr * lpViewCtr = [[FirstViewCommentCtr alloc] init];
        lpViewCtr.hidesBottomBarWhenPushed = YES;
        lpViewCtr.theTitle = @"学习交流";
        lpViewCtr.ctrStyle = jiaoliu;
        ThirdViewController * v = (ThirdViewController *)helper;
        [v.navigationController pushViewController:lpViewCtr animated:YES];
        [lpViewCtr release];
        
        
        return;
    }
    
    
    
    
    
    ThirdTwoViewController  * vc =[[ThirdTwoViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    
    
    if (index==0)
    {
        vc.theTitle =@"计划列表";
        vc.LS = xuexijihua;
    }
    
    
    else if (index==1)
    {
        vc.theTitle = @"书签笔记";
        vc.LS = shuqianbiji;
        
    }
    
    else if (index==2)
    {
        
        vc.theTitle =@"名家讲堂";
        vc.LS = mingjiajiangtang;
    }
    
    

    
    else  {
        vc.theTitle = @"学校信息";
        vc.LS = xuexiaoxinxi;

    }
    
    ThirdViewController * v = (ThirdViewController *)helper;
    [v.navigationController pushViewController:vc animated:YES];
    [vc release];
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 160;
	return height;
}

#pragma mark -  rotate

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	bLandScape = NO;
	if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
		bLandScape = YES;
	}
	
	return YES;
}


-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
	if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft || 
	   interfaceOrientation == UIInterfaceOrientationLandscapeRight)
	{
		bLandScape = YES;
	}else {
		bLandScape = NO;
	}
	tbView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [tbView reloadData];
}

@end
