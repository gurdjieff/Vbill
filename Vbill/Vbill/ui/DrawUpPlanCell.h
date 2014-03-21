//
//  DrawUpPlanCell.h
//  Examination
//
//  Created by Zhang Bo on 13-7-22.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol DrawUpDelegate <NSObject>
@optional

-(void)WillAppeare:(NSInteger)tag;

@end

@interface DrawUpPlanCell : UITableViewCell<UITextFieldDelegate>
{
@public
    UIButton * comboboxBtn;
    UIImageView * imageView;
}
@property(nonatomic,retain)UILabel * leftLabel;
@property(nonatomic,retain)UILabel * rightLabel;
@property(nonatomic,retain)UITextField * rightTextField;
@property(nonatomic,retain)UIImageView * leftImageView;


@property(nonatomic,assign) NSInteger  cellStyle;
@property(nonatomic,assign)id<DrawUpDelegate>delegate;
@property(nonatomic,assign)BOOL isGetSource;
@end
