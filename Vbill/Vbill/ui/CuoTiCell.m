//
//  CuoTiCell.m
//  Examination
//
//  Created by Zhang Bo on 13-7-13.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "CuoTiCell.h"
#import "Common.h"

@implementation CuoTiCell
@synthesize timulabel;
@synthesize zhishilabel;
@synthesize timelabel;


-(void)dealloc
{
    [timelabel  release];
    [zhishilabel release];
    [timulabel release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
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
        
        timulabel =[[UILabel alloc] init];
        timulabel.textColor = [UIColor darkGrayColor];
        [timulabel setFont:[UIFont boldSystemFontOfSize:16]];

        [timulabel setBackgroundColor:[UIColor clearColor]];
        [timulabel setTextAlignment:NSTextAlignmentLeft];
        [timulabel setFrame:CGRectMake(10, 10, 160, 30)];
        [[self contentView] addSubview:timulabel];
        
        timelabel =[[UILabel alloc] init];
        timelabel.textColor = [UIColor lightGrayColor];
        [timelabel setFont:[UIFont systemFontOfSize:16]];

        [timelabel setBackgroundColor:[UIColor clearColor]];
        [timelabel setTextAlignment:NSTextAlignmentCenter];
        [timelabel setFrame:CGRectMake(170, 10, 90, 30)];
        [[self contentView] addSubview:timelabel];
        
        
        zhishilabel =[[UILabel alloc] init];
        [zhishilabel setFont:[UIFont boldSystemFontOfSize:16]];
        [zhishilabel setTextColor:[UIColor orangeColor]];
        [zhishilabel setBackgroundColor:[UIColor clearColor]];
        [zhishilabel setTextAlignment:NSTextAlignmentCenter];
        [zhishilabel setFrame:CGRectMake(260, 10, 50, 30)];
        [[self contentView] addSubview:zhishilabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
