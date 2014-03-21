//
//  NSDate+IfisTradeTime.h
//  economicInfo
//
//  Created by gurdjieff on 12-11-15.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (IfisTradeTime)
+(BOOL)isTradeTime;
+(NSInteger)getCurrentDay;

@end
