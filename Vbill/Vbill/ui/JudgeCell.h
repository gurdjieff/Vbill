//
//  JudgeCell.h
//  Examination
//
//  Created by gurd on 13-7-22.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"


@interface JudgeCell : UITableViewCell
{
    UIFont * font;
    @public
    UILabel * mpLabelIndex;
    UILabel * mpLabel1;
    UIButton * mpBtn1;
    UIButton * mpBtn2;
    UIButton * mpExplainBtn;
    UILabel * mpShadowLabel;
}
-(void)btnClick:(UIButton *)btn;

@end
