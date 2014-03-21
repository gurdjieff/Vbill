//
//  CustomTabBarViewCtr.m
//  Examination
//
//  Created by gurd on 13-6-23.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "CustomTabBarViewCtr.h"
#import "BaseViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "CustomNavigationViewCtr.h"
#import "LoginViewController.h"
#import "FirstViewThreeController.h"

@interface CustomTabBarViewCtr ()

@end

@implementation CustomTabBarViewCtr

+(CustomTabBarViewCtr *)shareTabBarViewCtr
{
    static CustomTabBarViewCtr * instance = nil;
    if (instance == nil) {
        instance = [[CustomTabBarViewCtr alloc] init];
    }
    return instance;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)addViewCtrs
{
    FirstViewController * fvc = [[FirstViewController shareFirstViewCtr] retain];
    CustomNavigationViewCtr * cvc1 = [[CustomNavigationViewCtr alloc] initWithRootViewController:fvc];
    [fvc release];
    
    SecondViewController * svc = [[SecondViewController alloc] init];
    CustomNavigationViewCtr * cvc2 = [[CustomNavigationViewCtr alloc] initWithRootViewController:svc];
    [svc release];
    
    ThirdViewController * tvc = [[ThirdViewController alloc] init];
    CustomNavigationViewCtr * cvc3 = [[CustomNavigationViewCtr alloc] initWithRootViewController:tvc];
    [tvc release];
    
    FourthViewController * fvc2 = [[FourthViewController alloc] init];
    CustomNavigationViewCtr * cvc4 = [[CustomNavigationViewCtr alloc] initWithRootViewController:fvc2];
    [fvc2 release];
    
    
    NSArray * aryTemp = [NSArray arrayWithObjects:cvc1,cvc2,cvc3,cvc4, nil];
    [cvc1 release];
    [cvc2 release];
    [cvc3 release];
    [cvc4 release];
    
    self.viewControllers = aryTemp;
}

-(void)btnClick:(UIButton *)apBtn
{
    NSArray * ary = [NSArray arrayWithObjects:@"firstGray.png",@"secondGray.png",@"thirdGray.png",@"fourthGray.png", nil];
    NSArray * ary2 = [NSArray arrayWithObjects:@"firstYellow.png",@"secondYellow.png",@"thirdYellow.png",@"fourthYellow.png", nil];

    for (int i = 0; i < 4; i++) {
        UIButton * btn = (UIButton *)[mpView viewWithTag:100+i];
        [btn setBackgroundImage:[UIImage imageNamed:[ary objectAtIndex:i]] forState:UIControlStateNormal];
        btn.userInteractionEnabled = YES;
    }
    apBtn.userInteractionEnabled = NO;
    [apBtn setBackgroundImage:[UIImage imageNamed:[ary2 objectAtIndex:apBtn.tag - 100]] forState:UIControlStateNormal];
    [apBtn setBackgroundImage:[UIImage imageNamed:[ary2 objectAtIndex:apBtn.tag - 100]] forState:UIControlStateHighlighted];

    self.selectedIndex = apBtn.tag-100;
}

-(void)addCustomTabBarView
{
    mpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
    mpView.backgroundColor = [UIColor grayColor];
    [self.tabBar addSubview:mpView];
    [mpView release];
    
    
    NSArray * ary = [NSArray arrayWithObjects:@"firstGray.png",@"secondGray.png",@"thirdGray.png",@"fourthGray.png", nil];
    float width = 320.0f/4;
    for (int i = 0; i < 4; i++) {
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(width*i, 0, width, 48)];
        if (i == 0) {
            [btn setBackgroundImage:[UIImage imageNamed:@"firstYellow.png"] forState:UIControlStateNormal];
        } else {
            [btn setBackgroundImage:[UIImage imageNamed:[ary objectAtIndex:i]] forState:UIControlStateNormal];
        }
        
        if (i == 0) {
            btn.backgroundColor = [UIColor darkGrayColor];
        } else {
            btn.backgroundColor = [UIColor grayColor];
        }
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        btn.tag = 100+i;
        [mpView addSubview:btn];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addViewCtrs];
    [self addCustomTabBarView];
	// Do any additional setup after loading the view.
}

- (BOOL) shouldAutorotate {
    

    
    UIViewController *controller = self.selectedViewController;
    if ([controller isKindOfClass:[UINavigationController class]])
        controller = [(UINavigationController *)controller visibleViewController];
    if ([controller isKindOfClass:NSClassFromString(@"MPInlineVideoFullscreenViewController")]) {
        return YES;
    } else {
        return NO;
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
   
    
    
    UIViewController *controller = self.selectedViewController;
    if ([controller isKindOfClass:[UINavigationController class]])
        controller = [(UINavigationController *)controller visibleViewController];
    if ([controller isKindOfClass:[FirstViewThreeController class]]) {
        return YES;
    } else
        return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
