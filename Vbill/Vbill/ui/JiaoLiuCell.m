//
//  JiaoLiuCell.m
//  Examination
//
//  Created by Zhang Bo on 13-7-13.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "JiaoLiuCell.h"

@implementation JiaoLiuCell
@synthesize imageView;
@synthesize timulabel;
@synthesize timelabel;
@synthesize namelabel;




-(void)dealloc
{
    [imageView release];
    [timulabel release];
    [timelabel release];
    [namelabel release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 70,70)];
        imageView.backgroundColor =[UIColor blueColor];
        [self.contentView addSubview:imageView];

        namelabel =[[UILabel alloc] init];
        [namelabel setFont:[UIFont systemFontOfSize:18]];
        [namelabel setTextColor:[UIColor blackColor]];
        [namelabel setBackgroundColor:[UIColor clearColor]];
        [namelabel setTextAlignment:NSTextAlignmentLeft];
        [namelabel setFrame:CGRectMake(90, 5, 100, 30)];
        [[self contentView] addSubview:namelabel];

        timelabel =[[UILabel alloc] init];
        [timelabel setFont:[UIFont systemFontOfSize:18]];
        [timelabel setTextColor:[UIColor blackColor]];
        [timelabel setBackgroundColor:[UIColor clearColor]];
        [timelabel setTextAlignment:NSTextAlignmentLeft];
        [timelabel setFrame:CGRectMake(190, 5, 100, 30)];
        [[self contentView] addSubview:timelabel];

        
        
        timulabel =[[UILabel alloc] init];
        [timulabel setFont:[UIFont systemFontOfSize:16]];
        [timulabel setTextColor:[UIColor blackColor]];
        [timulabel setBackgroundColor:[UIColor clearColor]];
        [timulabel setTextAlignment:NSTextAlignmentLeft];
        [timulabel setFrame:CGRectMake(90, 50, 320-100, 30)];
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
