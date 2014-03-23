//
//  FourthViewController.m
//  Examination
//
//  Created by gurd on 13-6-23.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "FourthViewController.h"
#import "FirstTableViewCell.h"
#import "ChangePwdViewCtr.h"
#import "AboutUsViewController.h"
#import "LoginViewController.h"
#import "CustomNavigationViewCtr.h"
#import "FeedBackViewCtr.h"
#import "RemarkViewController.h"
#import "UserInfoViewController.h"
#import "DateSource.h"

@interface FourthViewController ()

@end

@implementation FourthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    mpTitleLabel.text = @"更多";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
}

@end
