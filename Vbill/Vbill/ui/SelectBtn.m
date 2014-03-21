//
//  SelectBtn.m
//  Examination
//
//  Created by gurd on 13-8-1.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "SelectBtn.h"
#import "Common.h"

@implementation SelectBtn

-(void)btnClick
{
    selected = !selected;
    if (selected) {
        mpTitleView.image = [UIImage imageNamed:@"selected.png"];
        mpTitle.textColor = yellowColor;
    } else {
        mpTitleView.image = [UIImage imageNamed:@"unSelect.png"];
        mpTitle.textColor = [UIColor colorWithRed:0x88/255.0f green:0x88/255.0f blue:0x88/255.0f alpha:1.0];
    }
}

-(void)resetBtnState
{
    selected = NO;
    mpTitleView.image = [UIImage imageNamed:@"unSelect.png"];
    mpTitle.textColor = [UIColor colorWithRed:0x88/255.0f green:0x88/255.0f blue:0x88/255.0f alpha:1.0];

}

-(void)addsubviews
{
    mpTitleView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 4, 12, 12)];
    mpTitleView.image = [UIImage imageNamed:@"unSelect.png"];
    [self addSubview:mpTitleView];
    [mpTitleView release];
    
    mpTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 280-30, 40)];
    mpTitle.textAlignment = NSTextAlignmentLeft;
    mpTitle.backgroundColor = [UIColor clearColor];
    mpTitle.numberOfLines = 0;
    mpTitle.textColor = [UIColor colorWithRed:0x88/255.0f green:0x88/255.0f blue:0x88/255.0f alpha:1.0];
    mpTitle.font = askFont;
    [self addSubview:mpTitle];
    [mpTitle release];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self addsubviews];
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
