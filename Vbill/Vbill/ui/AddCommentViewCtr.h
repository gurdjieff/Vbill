//
//  AddCommentViewCtr.h
//  Examination
//
//  Created by gurdjieff on 13-8-4.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"
#import "ApiAccount.h"


@interface AddCommentViewCtr : BaseViewController
<downLoadDelegate>
{
    UITextView * mpTextView;
    NSDictionary * mpInfoDic;

}
@property(nonatomic, retain) NSDictionary * infoDic;
@property(nonatomic,assign) theStyle  ctrStyle;

@end
