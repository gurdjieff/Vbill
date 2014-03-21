//
//  CommentCell.m
//  Examination
//
//  Created by gurdjieff on 13-7-6.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "CommentCell.h"
#import "Common.h"
#import "ApiAccount.h"

@implementation CommentCell
-(void)addsubviews
{
    
    
    mpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    [self.contentView addSubview:mpImageView];
    [mpImageView release];
    
    
  
    
    mpLabel1 = [[UILabel alloc] initWithFrame:CGRectZero];
    mpLabel1.backgroundColor = [UIColor clearColor];
    mpLabel1.font = [UIFont boldSystemFontOfSize:14];
    mpLabel1.textColor = yellowColor;
    [self.contentView addSubview:mpLabel1];
    [mpLabel1 release];
    
    
   
    
    mpLabel2 = [[UILabel alloc] initWithFrame:CGRectZero];
    mpLabel2.textAlignment = NSTextAlignmentLeft;
    mpLabel2.backgroundColor = [UIColor clearColor];
    mpLabel2.font = [UIFont systemFontOfSize:12];
    mpLabel2.textColor = [UIColor grayColor];
    [self.contentView addSubview:mpLabel2];
    [mpLabel2 release];
    
    imagview2 =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shijian.png"]];
    [imagview2 setFrame:CGRectZero];
    [self.contentView addSubview:imagview2];
    [imagview2 release];
  
    
    mpLabel3 = [[UILabel alloc] initWithFrame:CGRectZero];
    mpLabel3.backgroundColor = [UIColor clearColor];
    mpLabel3.font = communicationFont;
    mpLabel3.numberOfLines = 0;
    mpLabel3.lineBreakMode = UILineBreakModeCharacterWrap;
    mpLabel3.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:mpLabel3];
    [mpLabel3 release];
	
	
	mpLabel4 = [[UILabel alloc] initWithFrame:CGRectZero];
    mpLabel4.textAlignment = NSTextAlignmentLeft;
    mpLabel4.backgroundColor = [UIColor clearColor];
    mpLabel4.font = [UIFont boldSystemFontOfSize:12];
    mpLabel4.textColor = [UIColor grayColor];
    [self.contentView addSubview:mpLabel4];
    [mpLabel4 release];
    
    imagview4 =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"duihua.png"]];
    [imagview4 setFrame:CGRectZero];
    [self.contentView addSubview:imagview4];
    [imagview4 release];

    
    UIImageView* lpImageView=[[UIImageView alloc]
                              initWithImage:[UIImage imageNamed:@"separatorWhite.png"]];
    lpImageView.frame=CGRectMake(0, 0, 320, 1);
    [self.contentView addSubview:lpImageView];
    [lpImageView release];
    
    
    
    
    mpLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(145, 5, 100, 20)];
    mpLabel5.textAlignment = NSTextAlignmentLeft;
    mpLabel5.backgroundColor = [UIColor clearColor];
    mpLabel5.font = [UIFont systemFontOfSize:12];
    mpLabel5.textColor = [UIColor grayColor];
    [self.contentView addSubview:mpLabel5];
    [mpLabel5 release];
    
    imagview5 =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yanjing.png"]];
    [imagview5 setFrame:CGRectZero];
    [self.contentView addSubview:imagview5];
    [imagview5 release];
    
  
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
