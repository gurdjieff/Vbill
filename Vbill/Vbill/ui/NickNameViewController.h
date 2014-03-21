//
//  NickNameViewController.h
//  Examination
//
//  Created by Zhang Bo on 13-9-2.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"
#import "ApiAccount.h"



@protocol NickNameDelegate <NSObject>

-(void)callbackNickName:(BOOL)tag;

@end


@interface NickNameViewController : BaseViewController
	<downLoadDelegate,UITextFieldDelegate>
{
	UIView * myDateView;
	UIDatePicker * datePicker;
}
@property(nonatomic,retain) NSDictionary * infoDic;
@property(nonatomic,retain) UITextField * textField;
@property(nonatomic,retain) NSString * mpLabel ;
@property(nonatomic,assign) id<NickNameDelegate>delegate;
@property(nonatomic,assign) nickStyle _style;
@property(nonatomic,retain) NSString * mpTitleString;
@property(nonatomic,retain) NSString * mpContentString;

@end
