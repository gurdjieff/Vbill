//
//  PredictTestViewCtr.h
//  Examination
//
//  Created by gurdjieff on 13-7-13.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "HeadButton.h"
#import <QuartzCore/QuartzCore.h>

enum testType {
    Predict = 0,
    Zhenti,
    Moni,
    Cuoti,
    benzhangceshi,
};



@interface PredictTestViewCtr : BaseViewController
<UITableViewDataSource, UITableViewDelegate, downLoadDelegate>
{
    UITableView * mpTableView;
    NSDictionary * mpInfoDic;
    NSMutableArray * mpDataAry;
    
//    NSMutableDictionary * mpSingleDic;
//    NSMutableDictionary * mpMultiChioceDic;
//    NSMutableDictionary * mpYesOrNoDic;

    NSMutableArray * mpSingleChioceAry;
    NSMutableArray * mpMultiChioceAry;
    NSMutableArray * mpYesOrNoAry;
    
    
    HeadButton * mpHeadBtn1;
    HeadButton * mpHeadBtn2;
    HeadButton * mpHeadBtn3;
    
    int testType;
    
    
    
    UIView * scoreView;
    UIView *bgView;
    
    
    UIView * mpExplainView;
    UILabel * mpExplainLabel;
    UIButton * mpCloseBtn;

}
@property(nonatomic, retain) NSDictionary * infoDic;
@property(nonatomic, retain) NSMutableArray * dataAry;
@property int testType;
@property(nonatomic, retain) NSString * theTitle;



@end
