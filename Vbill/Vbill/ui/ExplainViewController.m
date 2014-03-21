//
//  ExplainViewController.m
//  Examination
//
//  Created by gurdjieff on 13-7-27.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "ExplainViewController.h"

@interface ExplainViewController ()

@end

@implementation ExplainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self createLabel];
        // Custom initialization
    }
    return self;
}

-(void)createLabel
{
    mpLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, appFrameHeigh-44)];
    mpLabel.numberOfLines = 0;
}

-(void)addLabel
{
    [mpBaseView addSubview:mpLabel];
    [mpLabel release];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    mpTitleLabel.text = @"解  析";
    [self addLeftButton];
    [self addLabel];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [super dealloc];
}

@end
