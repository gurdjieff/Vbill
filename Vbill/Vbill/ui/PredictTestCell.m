//
//  PredictTestCell.m
//  Examination
//
//  Created by gurdjieff on 13-7-13.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "PredictTestCell.h"

@implementation PredictTestCell

-(void)addSubviews
{
    float start = 30.0f;
    mpLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(start, 0, 300-start, 80)];
    mpLabel1.backgroundColor = [UIColor clearColor];
    mpLabel1.numberOfLines = 0;
    mpLabel1.font = [UIFont boldSystemFontOfSize:15];
    mpLabel1.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:mpLabel1];
    [mpLabel1 release];
    
    start = 50.0f;

    mpLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(start, 80, 300-start, 30)];
    mpLabel2.backgroundColor = [UIColor clearColor];
    mpLabel2.font = [UIFont boldSystemFontOfSize:15];
    mpLabel2.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:mpLabel2];
    [mpLabel2 release];
    
    mpLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(start, 110, 300-start, 30)];
    mpLabel3.backgroundColor = [UIColor clearColor];
    mpLabel3.font = [UIFont boldSystemFontOfSize:15];
    mpLabel3.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:mpLabel3];
    [mpLabel3 release];
    
    mpLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(start, 140, 300-start, 30)];
    mpLabel4.backgroundColor = [UIColor clearColor];
    mpLabel4.font = [UIFont boldSystemFontOfSize:15];
    mpLabel4.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:mpLabel4];
    [mpLabel4 release];
    
    mpLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(start, 170, 300-start, 30)];
    mpLabel5.backgroundColor = [UIColor clearColor];
    mpLabel5.font = [UIFont boldSystemFontOfSize:15];
    mpLabel5.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:mpLabel5];
    [mpLabel5 release];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
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
