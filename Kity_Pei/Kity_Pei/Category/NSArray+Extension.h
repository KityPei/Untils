//
//  NSArray+Extension.h
//  Kity_Pei
//
//  Created by Kity_Pei on 16/9/29.
//  Copyright © 2016年 Kity_Pei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)

- (BOOL)haveObject:(id)obj;

/**
 *  获取元素 无视 beyond bounds
 */
- (id)pp_objectAtIndex:(NSInteger)index;

/**
 *  数组 元素移动
 */
- (NSArray *)pp_moveObjectFromIndex:(NSInteger)from toIndex:(NSInteger)to;

/**
 *  数组 元素交换
 */
- (NSArray *)pp_exchangeObjectAtIndex:(NSInteger)index withObjectAtIndex:(NSInteger)withIndex;

/**
 *  截取指定数量元素
 *  如果超过则截取 如果少于则按实际
 */
- (NSArray *)pp_subArrayWithRange:(NSRange)range;

/**
 *  随机(连续且按序)截取指定数量元素
 *  如果超过则截取 如果少于则按实际
 */
- (NSArray *)pp_subRandArrayWithCount:(NSInteger)count;

/**
 *  仅支持对 元素实现compare:方法的 数组排序
 *  @param ascending 升序 default:YES
 *  区分大小写
 */
- (NSArray *)pp_sortedForValueWithAscending:(BOOL)ascending;

/**
 *  仅支持对 元素实现compare:方法的 数组排序
 *  @param ascending 升序 default:YES
 *  不区分大小写
 */
- (NSArray *)pp_sortedForValueCaseInsensitiveWithAscending:(BOOL)ascending;

/**
 *  支持对 元素为未实现compare:方法的对象 数组排序
 *  @param ascending 升序 default:YES
 *  @param keys 需要针对排序的keys(字典为key，对象为属性(_name)), 默认已第一个key排序，当第一个key相同则排序下一个key
 */
- (NSArray *)pp_sortedForObjWithAscending:(BOOL)ascending byKeys:(NSArray *)keys;

/**
 *  支持对 数组 进行大小排序 (按Integer比较)
 *  @param ascending 升序 default:YES
 */
- (NSArray *)pp_sortedForValueByIntegerWithAscending:(BOOL)ascending;

@end
