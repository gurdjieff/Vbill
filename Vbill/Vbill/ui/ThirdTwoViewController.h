//
//  SecondTwoViewController.h
//  Examination
//
//  Created by Zhang Bo on 13-7-3.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"
#import "ApiAccount.h"

#import "EGORefreshTableHeaderView.h"



@protocol JiHuaRefreshDelegate <NSObject>
@optional
-(void)refreshJiHua:(BOOL)flag;
@end


@interface ThirdTwoViewController : BaseViewController
    <UITableViewDataSource,UITableViewDelegate,
    downLoadDelegate,EGORefreshTableHeaderDelegate,JiHuaRefreshDelegate>
{
@protected
    NSString * theTitle;
    NSMutableArray * cellSourceArr;
    UITableView * myTableView;

    EGORefreshTableHeaderView * mpHeaderView;
    EGORefreshTableHeaderView * mpFooterView;

	NSIndexPath * myIndexPath;

    BOOL isJiHua;
}
@property(nonatomic,assign) ListStyle LS;
@property(nonatomic,retain) NSString * theTitle;
@property(nonatomic,retain) NSDictionary * infoDict;
@property(nonatomic,retain) UILabel * textLabel;

//-(void)addDataSource;
@end
