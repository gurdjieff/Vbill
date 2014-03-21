//
//  RemarkViewCtr.h
//  Examination
//
//  Created by gurdjieff on 13-7-6.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"

@interface RemarkViewCtr : BaseViewController
<downLoadDelegate>
{
    UITextView * mpTextView;
    NSDictionary * mpInfoDic;
    NSMutableDictionary * mpRemarkDic;
    
    NSMutableArray * mpDataAry;
}
@property(nonatomic, retain) NSDictionary * infoDic;

@end
