//
//  ComboBoxView.h
//  Examination
//
//  Created by Zhang Bo on 13-7-22.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ComboBoxView : UIView
    < UITableViewDelegate, UITableViewDataSource >
{
	UILabel			*_selectContentLabel;
	UIButton		*_pulldownButton;
	UIButton		*_hiddenButton;
	UITableView		*_comboBoxTableView;
	NSArray			*_comboBoxDatasource;
	BOOL			_showComboBox;
}

@property (nonatomic, retain) NSArray *comboBoxDatasource;

- (void)initVariables;
- (void)initCompentWithFrame:(CGRect)frame;
- (void)setContent:(NSString *)content;
- (void)show;
- (void)hidden;
- (void)drawListFrameWithFrame:(CGRect)frame withContext:(CGContextRef)context;

@end
