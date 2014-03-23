//
//  IntroduceImages.h
//  LafasoPad
//
//  Created by gurd on 13-7-24.
//  Copyright (c) 2013年 LAFASO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntroduceImages : UIView<UIScrollViewDelegate> {
    UIScrollView * mpScrollView;
    UIPageControl * mpPageControl;
    int page;
//    UIButton * mpBtn;
}
+(void)addIntruduceImages;
@end

