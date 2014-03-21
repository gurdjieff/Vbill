//
//  FirstViewTwoController.h
//  Examination
//
//  Created by gurdjieff on 13-7-6.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "EGORefreshTableHeaderView.h"


@interface FirstViewTwoController : BaseViewController
<UITableViewDataSource, UITableViewDelegate,
    downLoadDelegate,EGORefreshTableHeaderDelegate,
    UIAlertViewDelegate,UISearchBarDelegate>
{
    UITableView * mpTableView;
    NSMutableArray * mpDataAry;
    
    EGORefreshTableHeaderView * mpHeaderView;
    EGORefreshTableHeaderView * mpFooterView;
    
    int miSelectIndex;
    
}
@property(nonatomic, retain) NSString * ParentIDStr;
@property(nonatomic, retain) NSString * theTitle;
@property(nonatomic, retain) NSDictionary * infodict;
@property(nonatomic, assign)     BOOL isSearch;
@property(nonatomic, assign)     BOOL isCheck;

@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UISearchDisplayController *searchDC;
@end
