//
//  DateUntils.m
//  Kity_Pei
//
//  Created by Kity_Pei on 16/10/8.
//  Copyright © 2016年 Kity_Pei. All rights reserved.
//

#import "DateUntils.h"

@implementation DateUntils

/**
 * timestamp:时间戳（秒，毫秒） 适用于毫秒数大于10位的
 */
+ (NSString *)getTimeFormat:(double)timestamp type:(TimeFormatType)type {
    double finalStamp = timestamp;
    NSString *str = [NSString stringWithFormat:@"%zd",(int64_t)timestamp];
    int strLength = (int)str.length;
    if (strLength > 10) {//超过10位为毫秒，10位以内是秒
        int moreNum = strLength - 10;
        finalStamp = timestamp / pow(10, moreNum);
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:finalStamp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    switch (type) {
        case TimeFormatType_0:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case TimeFormatType_1:
            [dateFormatter setDateFormat:@"yyyy.MM.dd"];
            break;
        case TimeFormatType_2:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case TimeFormatType_3:
            [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
            break;
        case TimeFormatType_4:
            [dateFormatter setDateFormat:@"MM-dd HH:mm"];
            break;
        case TimeFormatType_5:
            [dateFormatter setDateFormat:@"MM.dd HH:mm"];
            break;
        case TimeFormatType_6:
            [dateFormatter setDateFormat:@"MM-dd"];
            break;
        case TimeFormatType_7:
            [dateFormatter setDateFormat:@"MM.dd"];
            break;
        case TimeFormatType_8:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        case TimeFormatType_9:
            return [self getTimeText:finalStamp];
            break;
        default:
            break;
    }
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

/**
 *  timestamp:时间戳 秒
 */
+ (NSString *)getTimeFormatForSecond:(double)timestamp type:(TimeFormatType)type {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    switch (type) {
        case TimeFormatType_0:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case TimeFormatType_1:
            [dateFormatter setDateFormat:@"yyyy.MM.dd"];
            break;
        case TimeFormatType_2:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case TimeFormatType_3:
            [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
            break;
        case TimeFormatType_4:
            [dateFormatter setDateFormat:@"MM-dd HH:mm"];
            break;
        case TimeFormatType_5:
            [dateFormatter setDateFormat:@"MM.dd HH:mm"];
            break;
        case TimeFormatType_6:
            [dateFormatter setDateFormat:@"MM-dd"];
            break;
        case TimeFormatType_7:
            [dateFormatter setDateFormat:@"MM.dd"];
            break;
        case TimeFormatType_8:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        case TimeFormatType_9:
            return [self getTimeText:timestamp/1000];
            break;
        default:
            break;
    }
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

/**
 *  timestamp:时间戳 毫秒
 */
+ (NSString *)getTimeFormatForMSecond:(double)timestamp type:(TimeFormatType)type {
    return [self getTimeFormatForSecond:timestamp*1000 type:type];
}

/**
 *  timestamp:时间戳 秒
 */
+ (NSString *)getTimeText:(double)timestamp {
    NSDate *today = [NSDate date];
    NSDate *yesterday = [today dateByAddingTimeInterval:(-24*3600)];
    NSDate *afterYesterday = [today dateByAddingTimeInterval:(-2*24*3600)];
    
    NSString *todayString;
    NSString *yesterdayString;
    NSString *afterYesterdayString;
    
    NSString *dateString;
    @try {
        todayString = [[today description] substringToIndex:10];
        yesterdayString = [[yesterday description] substringToIndex:10];
        afterYesterdayString = [[afterYesterday description] substringToIndex:10];
        
        dateString = [[[NSDate dateWithTimeIntervalSince1970:timestamp] description] substringToIndex:10];
    } @catch (NSException *exception) {
        return @"未知";
    } @finally {}
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateTimeStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timestamp]];
    
    if ([dateString isEqualToString:todayString]) {
        return [NSString stringWithFormat:@"%@",dateTimeStr];
    } else if([dateTimeStr isEqualToString:yesterdayString]) {
        return [NSString stringWithFormat:@"昨天 %@",dateTimeStr];
    } else if ([dateTimeStr isEqualToString:afterYesterdayString]){
        return [NSString stringWithFormat:@"前天 %@",dateTimeStr];
    } else {
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
        NSString *dateStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timestamp]];
        return dateStr;
    }
    
}

@end
