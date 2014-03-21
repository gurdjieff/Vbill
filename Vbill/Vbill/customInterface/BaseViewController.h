//
//  BaseViewController.h
//  Examination
//
//  Created by gurd on 13-6-23.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commonDataOperation.h"
#import "Common.h"
#import "JSON.h"
#import "UIView+ViewFrameGeometry.h"
#import "NewItoast.h"
#import "UIImageView+WebCache.h"

#define appFrameHeigh [[UIScreen mainScreen] applicationFrame].size.height

@interface BaseViewController : UIViewController
{
    NSOperationQueue * mpOperationQueue;

@public
	UIImageView * mpNavitateView;
    UILabel * mpTitleLabel;
    UIView * mpBaseView;
    
    float screenHeight;
    float screenWidth;
}


-(void)addLeftButton;
-(void)leftBtnClick;

@end
