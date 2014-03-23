//
//  LoginViewController.h
//  Examination
//
//  Created by gurdjieff on 13-7-22.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"


@interface LoginViewController : BaseViewController
<downLoadDelegate>
{
    UITextField * mpName;
    UITextField * mpPassword;
    CGPoint center;

}

@end
