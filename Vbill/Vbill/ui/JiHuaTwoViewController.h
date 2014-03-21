//
//  JiHuaTwoViewController.h
//  Examination
//
//  Created by Zhang Bo on 13-7-22.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"
#import "DrawUpPlanCell.h"
#import "TSLocateView.h"
#import "ThirdTwoViewController.h"


@interface JiHuaTwoViewController : BaseViewController
    <UITableViewDataSource,UITableViewDelegate,
    downLoadDelegate,
    DrawUpDelegate,
    UIActionSheetDelegate>
{
    NSString * theTitle;
    
    UITableView * myTableView;
    NSArray * leftDisArr;
    
    NSMutableString * CourseIDStr;
    NSInteger uptag;
    BOOL isGetSource;
    
    
    NSInteger knowledgeCount;

    NSDate * sDate;
    NSDate * eDate;
    
    UIDatePicker * datePicker;
    UIView * myDateView;
    
    
    
    NSArray * imageArray;

}
@property(nonatomic,retain) NSString * theTitle;
@property(nonatomic,retain) UITextField * textField;
@property(nonatomic,retain) UILabel * textlLabel;
@property(nonatomic,assign)id<JiHuaRefreshDelegate>delegate;
@end
