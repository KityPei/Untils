//
//  NSMutableArray+Extension.m
//  Kity_Pei
//
//  Created by Kity_Pei on 2016/12/28.
//  Copyright © 2016年 Kity_Pei. All rights reserved.
//

#import "NSMutableArray+Extension.h"

@implementation NSMutableArray (Extension)

//  数组 元素交换
- (void)pp_exchangeObjectAtIndex:(NSInteger)index withObjectAtIndex:(NSInteger)withIndex {
    if (index < 0 || index >= self.count) {
        return;
    }
    if (withIndex < 0 || withIndex >= self.count) {
        return;
    }
    if (index == withIndex) {
        return;
    }
    [self exchangeObjectAtIndex:index withObjectAtIndex:withIndex];
}

//  添加数据
- (void)safeAddObject:(id)anObject {
    if (anObject) {
        [self addObject:anObject];
    } else {
        [self addObject:@""];
    }
}

//  判断是否包含某元素
- (BOOL)haveObject:(id)object {
    NSUInteger index = [self indexOfObject:object];
    return (index != NSNotFound);
}

@end
