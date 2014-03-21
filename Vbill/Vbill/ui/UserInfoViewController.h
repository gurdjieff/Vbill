//
//  UserInfoViewController.h
//  Examination
//
//  Created by Zhang Bo on 13-8-21.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NickNameViewController.h"
#import "ApiAccount.h"



@interface UserInfoViewController : BaseViewController
	<downLoadDelegate,NickNameDelegate,
	UIImagePickerControllerDelegate,
	UINavigationControllerDelegate ,
	UITableViewDataSource,
	UITableViewDelegate,UIActionSheetDelegate>
{
    UITableView * myTableView;
    BOOL isUploading;
    BOOL isChange;
	NSArray * labelNameArr;
	BOOL isRefresh;
}
@property(nonatomic,retain)UIImageView * myPhotoImageView;
@property(nonatomic,retain) NSDictionary * infoDict;



@end
