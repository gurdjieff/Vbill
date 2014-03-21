//
//  DrawUpPlanCell.m
//  Examination
//
//  Created by Zhang Bo on 13-7-22.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "DrawUpPlanCell.h"

@implementation DrawUpPlanCell
@synthesize leftLabel = _leftLabel;
@synthesize rightLabel = _rightLabel;
@synthesize cellStyle = _cellStyle;
@synthesize rightTextField = _rightTextField;
@synthesize delegate = _delegate;
@synthesize isGetSource = _isGetSource;
@synthesize leftImageView = _leftImageView;


- (void)dealloc
{
    _delegate = nil;
    [_leftImageView release];
    [_rightTextField release];
    [_leftLabel release];
    [_rightLabel release];
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
        [_leftImageView setFrame:CGRectZero];
        [[self contentView] addSubview:_leftImageView];
        
        
        _leftLabel =[[UILabel alloc] init];
        [_leftLabel setFont:[UIFont systemFontOfSize:14]];
        [_leftLabel setTextColor:[UIColor blackColor]];
        [_leftLabel setBackgroundColor:[UIColor clearColor]];
        [_leftLabel setTextAlignment:NSTextAlignmentLeft];
       
        [[self contentView] addSubview:_leftLabel];
                

        _rightLabel =[[UILabel alloc] init];
        [_rightLabel setFont:[UIFont systemFontOfSize:13]];
        [_rightLabel setTextColor:[UIColor grayColor]];
        [_rightLabel setBackgroundColor:[UIColor clearColor]];
        [_rightLabel setTextAlignment:NSTextAlignmentLeft];
        [_rightLabel setFrame:CGRectZero];
        [[self contentView] addSubview:_rightLabel];
        
             
        _rightTextField =[[UITextField alloc] init];
        [_rightTextField setFont:[UIFont systemFontOfSize:14]];
        [_rightTextField setTextColor:[UIColor blackColor]];
        [_rightTextField setBackgroundColor:[UIColor clearColor]];
        [_rightTextField setTextAlignment:NSTextAlignmentLeft];
        [_rightTextField setFrame:CGRectZero];
        _rightTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

        [[self contentView] addSubview:_rightTextField];
        _rightTextField.delegate = self;
        
        
        
        imageView =[[UIImageView alloc] initWithFrame:CGRectZero];
        [imageView setImage:[UIImage imageNamed:@"xiala.png"]];
        [[self contentView] addSubview:imageView];
        [imageView release];
        
        comboboxBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [comboboxBtn setFrame:CGRectZero];
        [[self contentView] addSubview:comboboxBtn];

        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}



- (void)drawRect:(CGRect)rect
{
       
    if (_cellStyle == 0)
    {
        [comboboxBtn setFrame:CGRectZero];
    }else
    {
        [comboboxBtn addTarget:self
                        action:@selector(appearPicker:)
              forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    if (_cellStyle==1) {
        
        [imageView setFrame:CGRectMake(320-40, 7, 22, 22)];

        
        if(_isGetSource)
        {
            CGRect frame = CGRectMake(100, 5, 210, 32);
            [_rightTextField setFrame:frame];
            [_rightLabel setFrame:CGRectMake(100, 32, 190, 32)];
            
        }
        else
        {
            
            CGRect frame = CGRectMake(100, 5, 210, 32);
            [_rightLabel setFrame:frame];
            [_rightTextField setFrame:frame];
            
        }
    }
    


}




-(void)appearPicker:(id)sender
{
    if (_delegate != nil
        && [_delegate respondsToSelector:@selector(WillAppeare:)])
    {
        [_delegate WillAppeare:_cellStyle];
    }

}




- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_delegate != nil
        && [_delegate respondsToSelector:@selector(WillAppeare:)])
    {
        [_delegate WillAppeare:_cellStyle];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField setText:[NSString stringWithFormat:@"  %@",textField.text]];
}

@end
