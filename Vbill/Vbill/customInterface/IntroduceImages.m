//
//  IntroduceImages.m
//  LafasoPad
//
//  Created by gurd on 13-7-24.
//  Copyright (c) 2013年 LAFASO. All rights reserved.
//

#import "IntroduceImages.h"
#import "UIImageView+setImagewithFile.h"

@implementation IntroduceImages


+(void)addIntruduceImages
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults boolForKey:@"intruduceAnimation"]) {
        return;
    }

    UIView * lpWindow = [UIApplication sharedApplication].keyWindow;
    IntroduceImages * lpView = [[IntroduceImages alloc] init];
//    lpView.transform = CGAffineTransformMakeRotation(-3.14/2);

    [lpWindow addSubview:lpView];
}

-(id)init
{
    if ((self = [super init])) {
        [self addTntruduceViews];
    }
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width;
    float offset = scrollView.contentOffset.x;
    int p = (offset + width/2) / width;
    mpPageControl.currentPage = p;
    if (page == 2 && offset > 640) {
        [self scrollBeyondBoarder];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width;
    float offset = scrollView.contentOffset.x;
    page = (offset + width/2) / width;
}

-(void)addPageControl
{
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    CGFloat width = frame.size.height;
    CGFloat heith = frame.size.width;

    mpPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, heith-100, width, 20)];
    mpPageControl.numberOfPages = 3;
    [self addSubview:mpPageControl];
}

-(void)EnterBtnClick
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:@"intruduceAnimation"];
    [userDefaults synchronize];
    [UIView animateWithDuration:0.30 animations:^(void){
        mpScrollView.alpha = 0.0;
        mpPageControl.alpha = 0.0;

    } completion:^(BOOL finished) {
        [mpScrollView removeFromSuperview];
        [mpPageControl removeFromSuperview];
        [self removeFromSuperview];
    }];
}

-(void)scrollBeyondBoarder
{
    [self EnterBtnClick];
}

-(void)addTntruduceViews
{
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    CGFloat width = frame.size.width;
    CGFloat heith = frame.size.height;
    self.frame = CGRectMake(0, 0, 320, 480);
    mpScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, heith)];
    mpScrollView.contentSize = CGSizeMake(width*3+1, heith);
    mpScrollView.delegate = self;
    mpScrollView.backgroundColor = [UIColor blackColor];
    mpScrollView.pagingEnabled = YES;
    mpScrollView.bounces = NO;
    mpScrollView.showsHorizontalScrollIndicator = NO;
    
    UIImageView * lpImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, heith)];
    UIImageView * lpImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(width, 0, width, heith)];
    UIImageView * lpImageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(width*2, 0, width, heith)];
    lpImageView1.userInteractionEnabled = YES;
    lpImageView2.userInteractionEnabled = YES;
    lpImageView3.userInteractionEnabled = YES;
      
    [lpImageView1 setImageWithFileName:@"launch1.jpg"];
    [lpImageView2 setImageWithFileName:@"launch2.jpg"];
    [lpImageView3 setImageWithFileName:@"launch3.jpg"];
    
    [mpScrollView addSubview:lpImageView1];
    [mpScrollView addSubview:lpImageView2];
    [mpScrollView addSubview:lpImageView3];
           
    UIButton * btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = self.bounds;
    [btn3 addTarget:self action:@selector(EnterBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [lpImageView3 addSubview:btn3];;
    
    [self addSubview:mpScrollView];
    
}

+(id)shareIntroduceImages
{
    static IntroduceImages * instance = nil;
    if (instance == nil) {
        instance = [[IntroduceImages alloc] init];
    }
    return instance;
}
@end
