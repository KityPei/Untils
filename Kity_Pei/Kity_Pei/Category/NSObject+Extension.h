//
//  NSObject+Extension.h
//  Kity_Pei
//
//  Created by Kity_Pei on 16/10/9.
//  Copyright © 2016年 Kity_Pei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

//  转化成json格式字符串
- (NSString *)JSONValue;

//  判断是否有效，有效则返回YES, nil或者null返回NO
- (BOOL) isValid;

//  执行perform延迟方法
- (void)performAfterDelay:(NSTimeInterval)delay block:(void (^)())block;

@end
