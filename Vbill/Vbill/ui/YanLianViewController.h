//
//  YanLianViewController.h
//  Examination
//
//  Created by Zhang Bo on 13-7-3.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"

@interface YanLianViewController : BaseViewController
<UITableViewDataSource,UITableViewDelegate>
{
@protected
    NSString * theTitle;
    NSMutableArray * cellSourceArr;
    UITableView * myTableView;

    
}
@property(nonatomic,retain) NSString * theTitle;
@end
