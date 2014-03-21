//
//  MultipleChoiceCell.h
//  Examination
//
//  Created by gurd on 13-7-22.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectBtn.h"
#define askWidth 280.0f
#define selectedBtn 40.0f

@interface MultipleChoiceCell : UITableViewCell
{
    UIFont * font;
    NSMutableArray * mpDataAry;
@public
    UILabel * mpLabelIndex;
    UILabel * mpLabel1;
    UIButton * mpExplainBtn;
    int choices;
    int totalCount;
    UILabel * mpShadowLabel;
}
-(void)setBtnsTitle:(NSArray *)apAry;
-(void)btnClick:(SelectBtn *)btn;
@end
