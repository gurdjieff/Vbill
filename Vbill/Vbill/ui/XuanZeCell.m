//
//  XuanZeCell.m
//  Examination
//
//  Created by Zhang Bo on 13-8-7.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "XuanZeCell.h"

@implementation XuanZeCell
@synthesize rightLabel = _rightLabel;
@synthesize midLabel = _midLabel;
@synthesize leftLabel = _leftLabel;
@synthesize leftImageView = _leftImageView;

-(void)dealloc
{
    [_leftImageView release];
    [_rightLabel release];
    [_midLabel release];
    [_leftLabel release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView * imagevew =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellcontent.png"]];
        [imagevew setFrame:CGRectMake(5, 5, 310, 51)];
        [self.contentView addSubview:imagevew];
        [imagevew release];

        
        _leftImageView =[[UIImageView alloc] init];
//        [_leftImageView setFrame:CGRectMake(5, 10, 19, 19)];
        [[self contentView] addSubview:_leftImageView];
        
        _leftLabel =[[UILabel alloc] init];
        [_leftLabel setFont:[UIFont systemFontOfSize:14]];
        [_leftLabel setTextColor:[UIColor blackColor]];
        [_leftLabel setBackgroundColor:[UIColor clearColor]];
        [_leftLabel setTextAlignment:NSTextAlignmentLeft];
        [_leftLabel setText:@"每天学"];
//        [_leftLabel setFrame:CGRectMake(10, 5, 100, 14)];
        [[self contentView]  addSubview:_leftLabel];
        
        
        _midLabel =[[UILabel alloc] init];
        [_midLabel setFont:[UIFont systemFontOfSize:14]];
        [_midLabel setTextColor:[UIColor orangeColor]];
        [_midLabel setBackgroundColor:[UIColor clearColor]];
        [_midLabel setTextAlignment:NSTextAlignmentCenter];
        [_midLabel setText:@""];
//        [_midLabel setFrame:CGRectMake(110, 5, 50, 30)];
        [[self contentView]  addSubview:_midLabel];
        
        
        _rightLabel =[[UILabel alloc] init];
        [_rightLabel setFont:[UIFont systemFontOfSize:14]];
        [_rightLabel setTextColor:[UIColor blackColor]];
        [_rightLabel setBackgroundColor:[UIColor clearColor]];
        [_rightLabel setTextAlignment:NSTextAlignmentLeft];
        [_rightLabel setText:@"个知识点"];
//        [_rightLabel setFrame:CGRectMake(160, 5,120, 30)];
        [[self contentView]  addSubview:_rightLabel];
        
      
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end
