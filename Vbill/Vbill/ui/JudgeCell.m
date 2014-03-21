//
//  JudgeCell.m
//  Examination
//
//  Created by gurd on 13-7-22.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "JudgeCell.h"
#import "UIView+ViewFrameGeometry.h"

@implementation JudgeCell
-(void)btnClick:(UIButton *)btn
{
    [mpBtn1 setBackgroundImage:[UIImage imageNamed:@"rightGray.png"] forState:UIControlStateNormal];
    [mpBtn1 setBackgroundImage:[UIImage imageNamed:@"rightGray.png"] forState:UIControlStateHighlighted];
    
    [mpBtn2 setBackgroundImage:[UIImage imageNamed:@"wrongGray.png"] forState:UIControlStateNormal];
    [mpBtn2 setBackgroundImage:[UIImage imageNamed:@"wrongGray.png"] forState:UIControlStateHighlighted];

    if (btn.tag == 101) {
        [mpBtn1 setBackgroundImage:[UIImage imageNamed:@"rightLight.png"] forState:UIControlStateNormal];
        [mpBtn1 setBackgroundImage:[UIImage imageNamed:@"rightLight.png"] forState:UIControlStateHighlighted];
    } else {
        [mpBtn2 setBackgroundImage:[UIImage imageNamed:@"wrongLight.png"] forState:UIControlStateNormal];
        mpBtn2.tag = 102;
        [mpBtn2 setBackgroundImage:[UIImage imageNamed:@"wrongLight.png"] forState:UIControlStateHighlighted];
    }
}

-(void)addSubViews
{
    mpShadowLabel = [[UILabel alloc] init];
    mpShadowLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:mpShadowLabel];
    [mpShadowLabel release];

    UIImageView * circle = [[UIImageView alloc] initWithFrame:CGRectMake(7, 0, 20, 20)];
    circle.image = [UIImage imageNamed:@"blueCircle.png"];
    [self.contentView addSubview:circle];
    [circle release];
    
    mpLabelIndex = [[UILabel alloc] initWithFrame:CGRectMake(7, 0, 20, 20)];
    mpLabelIndex.backgroundColor = [UIColor clearColor];
    mpLabelIndex.textColor = [UIColor whiteColor];
    mpLabelIndex.textAlignment = NSTextAlignmentCenter;
    mpLabelIndex.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:mpLabelIndex];
    [mpLabelIndex release];

    mpLabel1 = [[UILabel alloc] init];
    mpLabel1.font = font;
    mpLabel1.backgroundColor = [UIColor clearColor];
    mpLabel1.numberOfLines = 0;
    [self.contentView addSubview:mpLabel1];
    [mpLabel1 release];
    
    mpBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [mpBtn1 setBackgroundImage:[UIImage imageNamed:@"rightGray.png"] forState:UIControlStateNormal];
    [mpBtn1 setBackgroundImage:[UIImage imageNamed:@"rightGray.png"] forState:UIControlStateHighlighted];
    mpBtn1.tag = 101;
    [self.contentView addSubview:mpBtn1];
    
    mpBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [mpBtn2 setBackgroundImage:[UIImage imageNamed:@"wrongGray.png"] forState:UIControlStateNormal];
    mpBtn2.tag = 102;
    [mpBtn2 setBackgroundImage:[UIImage imageNamed:@"wrongGray.png"] forState:UIControlStateHighlighted];
    [self.contentView addSubview:mpBtn2];
    
    mpExplainBtn = [[UIButton alloc] init];
    [mpExplainBtn setBackgroundImage:[UIImage imageNamed:@"explain.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:mpExplainBtn];
    [mpExplainBtn release];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = [mpLabel1.text sizeWithFont:font constrainedToSize:CGSizeMake(askWidth, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    mpLabel1.frame = CGRectMake(30, 0, askWidth, size.height);
    mpBtn1.frame = CGRectMake(170, mpLabel1.buttom + 10, choiceBtnHeight, choiceBtnHeight);
    mpBtn2.frame = CGRectMake(250, mpLabel1.buttom + 10, choiceBtnHeight, choiceBtnHeight);
    mpExplainBtn.frame = CGRectMake(220, mpBtn1.buttom + 10, 80, explainBtnHeight);
    if (mpExplainBtn.hidden) {
        mpShadowLabel.frame = CGRectMake(17, 0, 2, mpBtn1.buttom + 10);
    } else {
        mpShadowLabel.frame = CGRectMake(17, 0, 2, mpExplainBtn.buttom + 10);
    }

}

-(void)initData
{
    font = askFont;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initData];
        [self addSubViews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
