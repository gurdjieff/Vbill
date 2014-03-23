//
//  AppDelegate.m
//  Vbill
//
//  Created by daiyuzhang on 14-3-21.
//  Copyright (c) 2014年 daiyuzhang. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomTabBarViewCtr.h"
#import "IntroduceImages.h"
#import "LoginViewController.h"
#import "CustomNavigationViewCtr.h"



@implementation AppDelegate

-(void)pushLoginViewCtr
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults boolForKey:@"ifLogin"] == NO) {
        CustomTabBarViewCtr * instance = [CustomTabBarViewCtr shareTabBarViewCtr];
        UIViewController *controller = instance.selectedViewController;
        if ([controller isKindOfClass:[UINavigationController class]]){
			
            controller = [(UINavigationController *)controller visibleViewController];
            LoginViewController * lpViewCtr = [[LoginViewController alloc] init];
//            CustomNavigationViewCtr * cvc4 = [[CustomNavigationViewCtr alloc] initWithRootViewController:lpViewCtr];
//            [lpViewCtr release];
            [controller presentViewController:lpViewCtr animated:YES completion:nil];
        }
    } else {
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        NSString * sessionValue = [userDefaults objectForKey:@"cookie"];
        if (sessionValue) {
            NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
            [cookieProperties setObject:@"AutoReLogin" forKey:NSHTTPCookieName];
            [cookieProperties setObject:sessionValue forKey:NSHTTPCookieValue];
            [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
            
            NSArray * ary = [[serverIp substringFromIndex:7] componentsSeparatedByString:@":"];
            if ([ary isKindOfClass:[NSArray class]] && [ary count] > 0) {
                [cookieProperties setObject:ary[0] forKey:NSHTTPCookieDomain];
            }
            NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    CustomTabBarViewCtr * ctvc = [CustomTabBarViewCtr shareTabBarViewCtr];
    self.window.rootViewController = ctvc;
    [self.window makeKeyAndVisible];
    [self pushLoginViewCtr];
    [IntroduceImages addIntruduceImages];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
