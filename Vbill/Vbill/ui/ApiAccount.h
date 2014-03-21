//
//  ApiAccount.h
//  Examination
//
//  Created by Zhang Bo on 13-7-13.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <Foundation/Foundation.h>




typedef enum{
    pinglun,
    jiaoliu,
    fabiao,
    duqu,
    fankui,
	pinglunbianji,
	jiaoliubianqi,
	huifu,
	huifubianji,
	tuisong
}theStyle;


typedef enum {
    zhentiyanlian = 0,
    yanlanshijuan ,
    cuotizhongxin,
    cuotitongji,
    suoyoucuoti,
    monikaoshi,
    tiku,
    shuqianbiji,
    mingjiajiangtang,
    xuexijiaoliu,
    xuexiaoxinxi,
    xuexiaoliebiao,
    jiangtanxiangqing,
    xuexiaoxiangqing,
    jiaoliuxiangqing,
	xuexijihua,
    xuexijihuabianji,
    shuqianliebiao,
	shuqianliebiaobianji,
    tuijianurl
}ListStyle;


typedef enum {
	nickname,
	nicktel,
	nickdate
}nickStyle;


#define mySetColor [UIColor colorWithRed:220.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1];

#define myFont [UIFont systemFontOfSize:16]

#define communicationFont [UIFont systemFontOfSize:14]

#define eachCharactersinCell 110



#define WIDTH  61/2
#define HEIGHT  67/2
#define Hrow 5
#define BIG_IMG_WIDTH 264
#define BIG_IMG_HEIGHT 300
/*
 System/Init.action接口，增加ExamDate字段，用于考研倒计时
 
 Course/RemarkList.action接口增加ReadCount字段，表示阅读数
 
 真题题库列表/Exam/PoolList.action和模拟题库列表/Exam/QuizList.action不要带CourseID参数了
 
 
 
 */



