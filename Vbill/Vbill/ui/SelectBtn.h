//
//  SelectBtn.h
//  Examination
//
//  Created by gurd on 13-8-1.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectBtn : UIButton
{
    @public
    BOOL selected;
    UIImageView * mpTitleView;
    UILabel * mpTitle;
}

-(void)btnClick;
-(void)resetBtnState;

@end
