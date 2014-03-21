//
//  UIImageView+setImagewithFile.m
//  LafasoPad
//
//  Created by gurd on 13-7-24.
//  Copyright (c) 2013年 LAFASO. All rights reserved.
//

#import "UIImageView+setImagewithFile.h"

@implementation UIImageView (setImagewithFile)
-(void)setImageWithFileName:(NSString *)fileName
{
    NSArray * fileAry = [fileName componentsSeparatedByString:@"."];
    if ([fileAry count] != 2) {
        NSLog(@"文件名不对");
        return;
    }
    NSString * filePath = [[NSBundle mainBundle] pathForResource:[fileAry objectAtIndex:0] ofType:[fileAry objectAtIndex:1]];
    if (filePath == nil) {
        NSLog(@"文件名不对");
        return;
    }
    
    UIImage * lpImage = [[UIImage alloc] initWithContentsOfFile:filePath];
    self.image = lpImage;
}


@end
