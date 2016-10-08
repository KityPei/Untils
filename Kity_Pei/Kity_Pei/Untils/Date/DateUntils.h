//
//  DateUntils.h
//  Kity_Pei
//
//  Created by Kity_Pei on 16/10/8.
//  Copyright © 2016年 Kity_Pei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, TimeFormatType) {
    TimeFormatType_0 = 0,//yyyy-MM-dd
    TimeFormatType_1 = 1,//yyyy.MM.dd
    TimeFormatType_2 = 2,//yyyy-MM-dd HH:mm
    TimeFormatType_3 = 3,//yyyy.MM.dd HH:mm
    TimeFormatType_4 = 4,//MM-dd HH:mm
    TimeFormatType_5 = 5,//MM.dd HH:mm
    TimeFormatType_6 = 6,//MM-dd
    TimeFormatType_7 = 7,//MM.dd
    TimeFormatType_8 = 8,//HH:mm
    TimeFormatType_9 = 9// 前天 HH:mm / 昨天 HH:MM / 今天 HH:mm
};


@interface DateUntils : NSObject

/**
 * timestamp:时间戳（秒，毫秒） 适用于毫秒数大于10位的
 */
+ (NSString *)getTimeFormat:(double)timestamp type:(TimeFormatType)type;

/**
 *  timestamp:时间戳 秒
 */
+ (NSString *)getTimeFormatForSecond:(double)timestamp type:(TimeFormatType)type;

/**
 *  timestamp:时间戳 毫秒
 */
+ (NSString *)getTimeFormatForMSecond:(double)timestamp type:(TimeFormatType)type;

//+ (double)getTimeStampForTimeFormat:(NSString *)timeFormat type:(TimeFormatType)type;

@end
