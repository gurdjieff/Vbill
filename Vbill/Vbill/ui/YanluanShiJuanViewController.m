//
//  YanluanShiJuanViewController.m
//  Examination
//
//  Created by Zhang Bo on 13-7-7.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "YanluanShiJuanViewController.h"

@interface YanluanShiJuanViewController ()

@end

@implementation YanluanShiJuanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        cellSourceArr = [[NSMutableArray alloc] init];
        screenHeight = [UIScreen mainScreen].bounds.size.height;
        screenWidth = [UIScreen mainScreen].bounds.size.width;
        
        
        for (int i =0; i<20; i++) {
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"2013研究生物理学位考试真题", @"a",
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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)tableView:(UITableView *)tableViews didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
 
}

@end
