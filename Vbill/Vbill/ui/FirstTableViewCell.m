//
//  FirstTableViewCell.m
//  Examination
//
//  Created by gurdjieff on 13-7-6.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "FirstTableViewCell.h"
#import "Common.h"


@implementation FirstTableViewCell

-(void)addsubviews
{
    UIView * lpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
    lpView.backgroundColor = cellBackColor;
    lpView.userInteractionEnabled = NO;
    [self.contentView addSubview:lpView];
    [lpView release];
    
    
    float start = 60.0f;
    mpLabel = [[UILabel alloc] initWithFrame:CGRectMake(start, 0, 280-start, 48)];
    mpLabel.backgroundColor = [UIColor clearColor];
    mpLabel.font = [UIFont boldSystemFontOfSize:18];
    mpLabel.textColor = [UIColor colorWithRed:69.0/255 green:53.0/255 blue:61.0/255 alpha:1];
    [self.contentView addSubview:mpLabel];
    [mpLabel release];
    
    
    mpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 32, 32)];
    [self.contentView addSubview:mpImageView];
    [mpImageView release];
    
    UIImageView* lpImageView=[[UIImageView alloc] init];
    lpImageView.backgroundColor = cellSeparateColor;
    lpImageView.frame=CGRectMake(0, 47, 320, 1);
    [self.contentView addSubview:lpImageView];
    [lpImageView release];
    
    rightLabel = [[UILabel alloc] init];
    rightLabel.backgroundColor = [UIColor clearColor];
    rightLabel.font = [UIFont systemFontOfSize:14];
    rightLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:rightLabel];
    [rightLabel release];


    
    
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addsubviews];
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
