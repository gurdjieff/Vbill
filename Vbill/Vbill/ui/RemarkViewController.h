//
//  MultiLineTextViewController.h
//  MultiLineText
//
//  Created by Henry Yu on 3/29/09.
//  Copyright 2009 Sevenuc.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ApiAccount.h"
#import "JiaoLiuRefreshDelegate.h"



@interface  RemarkViewController:BaseViewController
<UITableViewDataSource,UITableViewDelegate,downLoadDelegate>
{


    NSString    *string;
    UITextView  *textView;    
    UITableView * myTableView;
    
    
    
    
    NSDictionary * mpInfoDic;
    NSMutableDictionary * mpRemarkDic;
    NSMutableArray * mpDataAry;

}
@property(nonatomic,retain) NSString * theTitle;


@property (nonatomic, retain) NSString * string;
@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, assign) id <JiaoLiuRefreshDelegate> delegate;

@property (nonatomic,retain) NSDictionary * infoDict;
@property (nonatomic,assign) theStyle myStyle;


@end

