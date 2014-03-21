//
//  SecondTwoViewController.h
//  Examination
//
//  Created by Zhang Bo on 13-7-3.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"
#import "ApiAccount.h"
#import "NSString+CustomCategory.h"
#import "EGORefreshTableHeaderView.h"
#import <QuartzCore/QuartzCore.h>

@interface SecondTwoViewController : BaseViewController
<UITableViewDataSource,UITableViewDelegate,downLoadDelegate, EGORefreshTableHeaderDelegate>
{
@protected
    NSString * theTitle;
    NSMutableArray * cellSourceArr;
    UITableView * myTableView;
    
    EGORefreshTableHeaderView * mpHeaderView;
    EGORefreshTableHeaderView * mpFooterView;
    
}
@property(nonatomic,assign) ListStyle LS;
@property(nonatomic,retain) NSString * theTitle;
@property(nonatomic,retain) NSDictionary * infoDict;
@property(nonatomic,retain) UILabel * textField;
@end
