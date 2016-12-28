//
//  NSMutableArray+Extension.h
//  Kity_Pei
//
//  Created by Kity_Pei on 2016/12/28.
//  Copyright © 2016年 Kity_Pei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Extension)

//  数组 元素交换
- (void)pp_exchangeObjectAtIndex:(NSInteger)index withObjectAtIndex:(NSInteger)withIndex;

//  添加数据
- (void)safeAddObject:(id)anObject;

//  判断是否包含某元素
- (BOOL)haveObject:(id)object;

@end
