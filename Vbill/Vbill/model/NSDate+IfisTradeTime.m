//
//  NSDate+IfisTradeTime.m
//  economicInfo
//
//  Created by gurdjieff on 12-11-15.
//
//

#import "NSDate+IfisTradeTime.h"

@implementation NSDate (IfisTradeTime)

+(NSInteger)getCurrentDay
{
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSDateComponents * components = [cal components:NSYearCalendarUnit
                                     | NSMonthCalendarUnit
                                     | NSDayCalendarUnit
                                     | NSHourCalendarUnit
                                     | NSMinuteCalendarUnit
                                     | NSWeekdayCalendarUnit fromDate:[NSDate date]];
    NSInteger day = [components day];
    return day;
}

+(BOOL)isTradeTime
{
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSDateComponents * components = [cal components:NSYearCalendarUnit
                                     | NSMonthCalendarUnit
                                     | NSDayCalendarUnit
                                     | NSHourCalendarUnit
                                     | NSMinuteCalendarUnit
                                     | NSWeekdayCalendarUnit fromDate:[NSDate date]];
//    NSInteger year = [components year];
//    NSInteger month = [components month];
//    NSInteger day = [components day];
    NSInteger hour = [components hour];
//    NSInteger minute = [components minute];
    NSInteger week = [components weekday];
    //周日 1， 周一2， 周二3， 周三4， 周四5， 周五6， 周六7；
    
//    if (week == 7
//        || week == 1
//        || hour < 9
//        || hour == 12
//        || hour > 15
//        || (hour == 9 && minute < 20)
//        || (hour == 11 && minute > 30)
//        || (hour == 13 && minute < 30)) {
//        return NO;
//    } else {
//        return YES;
//    }
    
    if (week == 7
        || week == 1
        || hour < 9
        || hour == 12
        || hour > 15) {
        return NO;
    } else {
        return YES;
    }

    return YES;
}

@end
