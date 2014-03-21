//
//  FirstViewCommentCtr.h
//  Examination
//
//  Created by gurdjieff on 13-7-6.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"
#import "ApiAccount.h"
#import "EGORefreshTableHeaderView.h"
#import "JiaoLiuRefreshDelegate.h"

@interface FirstViewCommentCtr : BaseViewController
<UITableViewDataSource, UITableViewDelegate, downLoadDelegate,EGORefreshTableHeaderDelegate,JiaoLiuRefreshDelegate>
{
    UITableView * mpTableView;
    UIImageView * mpFootView;
    UIImageView * mpFootView2;
    UITextView * mpTextView;
    UILabel * mpLabel;
    NSDictionary * mpInfoDic;
    NSMutableArray * mpDataAry;
    
    
    
    BOOL isRefresh;
    EGORefreshTableHeaderView * mpHeaderView;
    EGORefreshTableHeaderView * mpFooterView;
	
	NSIndexPath * myIndexPath;
	

}
@property(nonatomic, retain) NSDictionary * infoDic;
@property(nonatomic, retain) NSString * theTitle;
@property(nonatomic,assign) theStyle  ctrStyle;
@end
