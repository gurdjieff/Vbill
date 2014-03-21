//
//  CommonInterface.m
//  Examination
//
//  Created by gurdjieff on 13-8-3.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "CommonInterface.h"
#import "MBProgressHUD.h"
#import "CustomTabBarViewCtr.h"
#import "BaseViewController.h"

@implementation CommonInterface
+ (UIView *)getVisibleView
{
    CustomTabBarViewCtr * instance = [CustomTabBarViewCtr shareTabBarViewCtr];
    UIViewController *controller = instance.selectedViewController;
    if ([controller isKindOfClass:[UINavigationController class]]){
        controller = [(UINavigationController *)controller visibleViewController];
    }
    BaseViewController * ctr = (BaseViewController *)controller;
    UIView * v = ctr->mpBaseView;
//    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    return v;
}


+ (void)showToastViewForCurrentVisibleViewForTwoSecondsWithMessage:(NSString *)message
{
    [self showToastViewWithMessage:message ForView:[self getVisibleView] forTimeInterval:2];
}


+ (void)showToastViewWithMessage:(NSString *)message ForView:(UIView *)view forTimeInterval:(NSTimeInterval)timeInterval
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
	hud.mode = MBProgressHUDModeText;
	hud.labelText = message;
	hud.margin = 10.f;
	hud.yOffset = 150.f;
	hud.removeFromSuperViewOnHide = YES;
	[hud hide:YES afterDelay:timeInterval];
}

@end
