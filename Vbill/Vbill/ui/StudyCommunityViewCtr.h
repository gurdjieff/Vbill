//
//  StudyCommunityViewCtr.h
//  Examination
//
//  Created by gurd on 13-7-30.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"
#import "ApiAccount.h"
#import "EGORefreshTableHeaderView.h"
#import "JiaoLiuRefreshDelegate.h"
#import "ApiAccount.h"

@interface StudyCommunityViewCtr : BaseViewController
<UITableViewDataSource, UITableViewDelegate, downLoadDelegate,EGORefreshTableHeaderDelegate,JiaoLiuRefreshDelegate>
{
    UITableView * mpTableView;
    UITextView * mpTextView;
    UILabel * mpLabel;
    NSDictionary * mpInfoDic;
    NSMutableArray * mpDataAry;
    UIImageView * mpFootView;
    CGPoint center;
    
    
    BOOL isRefresh;
    EGORefreshTableHeaderView * mpHeaderView;
    EGORefreshTableHeaderView * mpFooterView;
	
	NSIndexPath * myIndexPath;
}
@property(nonatomic, retain) NSDictionary * infoDic;
@property(nonatomic,assign) theStyle  ctrStyle;
@property (nonatomic,assign) id<JiaoLiuRefreshDelegate> delegate;
@property (nonatomic,retain) NSString * guidString;

@end
