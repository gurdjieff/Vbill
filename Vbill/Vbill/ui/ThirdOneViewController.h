//
//  SecondTwoViewController.h
//  Examination
//
//  Created by Zhang Bo on 13-7-13.
//  Copyright (c) 2013年 gurd. All rights reserved.
//



#import <UIKit/UIKit.h>



@interface ThirdOneViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * tbView;
    NSArray     * data;
	BOOL bLandScape;
}

@property(nonatomic,retain) id helper;

@end
