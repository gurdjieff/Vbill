//
//  CustomButton.m
//  Examination
//
//  Created by Zhang Bo on 13-9-11.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "CustomButton.h"
#import "UIView+ViewFrameGeometry.h"


@implementation CustomButton



-(void)addSubviews
{
    CGSize size = self.frame.size;
    float width = size.width;
    float heigh = size.height;
	
    mpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 6, width-12, heigh-80)];
    mpImageView.image = [UIImage imageNamed:@"zhenti.png"];
    [self addSubview:mpImageView];
    mpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, mpImageView.buttom, width, 80)];
    mpLabel.textAlignment = NSTextAlignmentCenter;
    mpLabel.text = @"真题演练";
    mpLabel.font = [UIFont boldSystemFontOfSize:22];
    mpLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:mpLabel];
}




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self addSubviews];
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
