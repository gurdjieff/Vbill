//
//  YanLianViewController.m
//  Examination
//
//  Created by Zhang Bo on 13-7-3.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "YanLianViewController.h"
#import "YanluanShiJuanViewController.h"
#define cellHight 44

@interface YanLianViewController ()


@end

@implementation YanLianViewController
@synthesize theTitle = _theTitle;


- (void)dealloc
{
    [theTitle release];
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
        // Custom initialization
        
        cellSourceArr = [[NSMutableArray alloc] init];


        
        for (int i =0; i<20; i++) {
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"研究生物理学位考试真题", @"a",
                                  [NSNumber numberWithInt:72], @"b",
                                  [NSNumber numberWithInt:55], @"c",
                                  [NSNumber numberWithInt:49], @"d", nil];
            
            [cellSourceArr addObject:dict];
        }
        
        
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mpTitleLabel.text = _theTitle;
    [self addLeftButton];
    [self addSubViews];
	// Do any additional setup after loading the view.
}



- (void)addSubViews
{
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,44,screenWidth,screenHeight) style:UITableViewStylePlain];
    myTableView.backgroundView=nil;
    myTableView.backgroundColor=[UIColor grayColor];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    myTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:myTableView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [cellSourceArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHight;
}



- (UITableViewCell *)tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableViews dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor =[UIColor clearColor];
        cell.textLabel.backgroundColor =[UIColor clearColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.backgroundColor =[UIColor groupTableViewBackgroundColor];
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        
           
        
    }
    
    
    cell.textLabel.text =[[cellSourceArr objectAtIndex:indexPath.row] objectForKey:@"a"];
    cell.textLabel.font =[UIFont systemFontOfSize:16];
	
    return cell;
}




-(void)tableView:(UITableView *)tableViews didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YanluanShiJuanViewController  * vc =[[YanluanShiJuanViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.theTitle = @"研究生物理学位考试";
    [self.navigationController pushViewController:vc animated:YES];
        
    [vc release];
}





@end
