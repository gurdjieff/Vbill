//
//  JiHuaOneViewController.h
//  Examination
//
//  Created by Zhang Bo on 13-7-13.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"
#import "ThirdTwoViewController.h"

@interface JiHuaOneViewController : BaseViewController
	<downLoadDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSString * theTitle;
    NSArray * titileArray;
    NSArray * imageArray;
}
@property(nonatomic,retain) NSString * theTitle;
@property (nonatomic,retain)NSDictionary * infoDic;
@property(nonatomic,assign)id<JiHuaRefreshDelegate>delegete;
@property(nonatomic,retain) NSString * guidString;
@property(nonatomic,retain) NSMutableArray * mpDataAry;
@property(nonatomic,retain) UITableView *tableView;


-(void)getDataFromService;
@end
