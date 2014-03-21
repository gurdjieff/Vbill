//
//  HeadButton.h
//  Examination
//
//  Created by gurdjieff on 13-7-27.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadButton : UIButton
{
    UIImageView * mpImageView;
    @public
    BOOL open;
    UILabel * mpTitle;
}

-(void)headBtnClick;
@end
