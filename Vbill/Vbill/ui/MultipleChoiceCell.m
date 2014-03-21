//
//  MultipleChoiceCell.m
//  Examination
//
//  Created by gurd on 13-7-22.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "MultipleChoiceCell.h"
#import "UIView+ViewFrameGeometry.h"
#import "SelectBtn.h"
#import "Common.h"
@implementation MultipleChoiceCell
-(void)setBtnsTitle:(NSArray *)apAry
{
    choices = [apAry count];
    [mpDataAry setArray:apAry];
    for (int i = 0; i < choices; i++) {
        NSString * info = apAry[i];
        SelectBtn * btn = (SelectBtn *)[self viewWithTag:100 + i];
        btn->mpTitle.text = info;
        btn->mpTitle.textColor = [UIColor colorWithRed:0x88/255.0f green:0x88/255.0f blue:0x88/255.0f alpha:1.0];
    }
}

-(void)btnClick:(SelectBtn *)btn
{
    [btn btnClick];
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
    mpLabel1.backgroundColor = [UIColor clearColor];
    mpLabel1.font = font;
    mpLabel1.numberOfLines = 0;
    [self.contentView addSubview:mpLabel1];
    [mpLabel1 release];
    
    for (int i = 0; i < totalCount; i++) {
        SelectBtn * btn = [[SelectBtn alloc] init];
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = 100 + i;
        [self addSubview:btn];
        [btn release];
    }
    
    mpExplainBtn = [[UIButton alloc] init];
    [mpExplainBtn setBackgroundImage:[UIImage imageNamed:@"explain.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:mpExplainBtn];
    [mpExplainBtn release];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    float heigh = 40.0;
    NSString * info = [NSString stringWithString:mpLabel1.text];
    CGSize size = [info sizeWithFont:askFont constrainedToSize:CGSizeMake(askWidth, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    mpLabel1.frame = CGRectMake(30, 0, askWidth, size.height);
    
//    int count = choices;
    float lastBottom = mpLabel1.buttom + 10;
    
    for (int i = 0; i < totalCount; i++) {
        SelectBtn * btn = (SelectBtn *)[self viewWithTag:100 + i];
        btn.hidden = YES;
        //        btn.frame = CGRectZero;
    }
    
    for (int i = 0; i < [mpDataAry count]; i++) {
        SelectBtn * btn = (SelectBtn *)[self viewWithTag:100 + i];
        btn.hidden = NO;
        NSString * info2 = [NSString stringWithString:[mpDataAry objectAtIndex:i]];
        CGSize size = [info2 sizeWithFont:askFont constrainedToSize:CGSizeMake(280-30, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        if (heigh < size.height) {
            heigh = size.height;
        }
        
        btn.frame = CGRectMake(30, lastBottom, 280, heigh);
        btn->mpTitle.frame = CGRectMake(30, 0, 280-30, size.height);
        lastBottom = btn.buttom;
    }
    
    mpExplainBtn.frame = CGRectMake(220, lastBottom + 10, 80, explainBtnHeight);
    mpShadowLabel.frame = CGRectMake(17, 0, 2, mpExplainBtn.buttom + 10);
    
    if (mpExplainBtn.hidden) {
        mpShadowLabel.frame = CGRectMake(17, 0, 2, lastBottom + 10);
    } else {
        mpShadowLabel.frame = CGRectMake(17, 0, 2, mpExplainBtn.buttom + 10);
    }
}

-(void)initData
{
    font = askFont;
    totalCount = 16;
    mpDataAry = [[NSMutableArray alloc] init];

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.clipsToBounds = YES;
        [self initData];
        [self addSubViews];
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc
{
    [mpDataAry release], mpDataAry = nil;
    [super dealloc];
}


@end
