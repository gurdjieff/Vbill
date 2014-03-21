//
//  BaiKuangCell.m
//  Examination
//
//  Created by Zhang Bo on 13-7-13.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaiKuangCell.h"

@implementation BaiKuangCell
@synthesize timulabel;

-(void)dealloc
{
    [timulabel release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView * iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 44)];
        iv.backgroundColor =[UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:1.0f];
        [self.contentView addSubview:iv];
        [iv release];
 
        
        timulabel =[[UILabel alloc] init];
        [timulabel setFont:[UIFont systemFontOfSize:18]];
        [timulabel setTextColor:[UIColor blackColor]];
        [timulabel setBackgroundColor:[UIColor clearColor]];
        [timulabel setTextAlignment:NSTextAlignmentCenter];
        [timulabel setFrame:CGRectMake(10, 15, 320-20, 30)];
        [[self contentView] addSubview:timulabel];

        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
