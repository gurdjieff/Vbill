//
//  HeadButton.m
//  Examination
//
//  Created by gurdjieff on 13-7-27.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "HeadButton.h"
#import "Common.h"

@implementation HeadButton

-(void)addsubviews
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, 2, 40)];
    label.backgroundColor = [UIColor grayColor];
    [self addSubview:label];
    [label release];
    mpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 10,  22, 12)];
    mpImageView.transform = CGAffineTransformMakeRotation(-3.14/2);
    mpImageView.image = [UIImage imageNamed:@"yellowArrow.png"];
    [self addSubview:mpImageView];
    [mpImageView release];
    
    
    mpTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 320, 40)];
    mpTitle.backgroundColor = [UIColor clearColor];
    mpTitle.font = [UIFont boldSystemFontOfSize:20];
    mpTitle.textColor = yellowColor;
    mpTitle.userInteractionEnabled = NO;
    [self addSubview:mpTitle];
    [mpTitle release];
    
   
}

-(void)headBtnClick
{
    open = !open;
    if (!open) {
        mpImageView.transform = CGAffineTransformMakeRotation(-3.14/2);
    } else {
        mpImageView.transform = CGAffineTransformMakeRotation(0);
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor] ;
        self.frame = CGRectMake(0, 0, 320, 40);
        open = YES;
        [self addsubviews];
        mpImageView.transform = CGAffineTransformMakeRotation(0);
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
