//
//  FirstTableViewTwoCell.m
//  Examination
//
//  Created by gurdjieff on 13-7-6.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "FirstTableViewTwoCell.h"
#import "Common.h"

@implementation FirstTableViewTwoCell
-(void)addsubviews
{
	
    UIView * lpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
    lpView.backgroundColor = cellBackColor;
    lpView.userInteractionEnabled = NO;
    [self.contentView addSubview:lpView];
    [lpView release];
        
    UIImageView* lpImageView=[[UIImageView alloc]
                              initWithFrame:CGRectMake(0, 47, 320, 1)];
    lpImageView.backgroundColor = cellSeparateColor;
    [self.contentView addSubview:lpImageView];
    [lpImageView release];
    
    float start = 50.0f;
    mpLabel = [[UILabel alloc] initWithFrame:CGRectMake(start, 0, 280-start, 48)];
    mpLabel.backgroundColor = [UIColor clearColor];
    mpLabel.font = [UIFont boldSystemFontOfSize:18];
    mpLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:mpLabel];
    [mpLabel release];
    
	
	countLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    countLabel.backgroundColor = [UIColor clearColor];
    countLabel.font = [UIFont systemFontOfSize:16];
    countLabel.textColor = [UIColor orangeColor];
	countLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:countLabel];
    [countLabel release];
	
    
    mpImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:mpImageView];
    [mpImageView release];
    
    
    
    mpImageViewOne = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 32, 32)];
	
	[mpImageViewOne setImage:[UIImage imageNamed:@"picGreen.png"]];
    [self.contentView addSubview:mpImageViewOne];
    [mpImageViewOne release];
	
	

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
