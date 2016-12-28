//
//  NSArray+Extension.m
//  Kity_Pei
//
//  Created by Kity_Pei on 16/9/29.
//  Copyright © 2016年 Kity_Pei. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

- (BOOL)haveObject:(id)obj {
    NSUInteger index = [self indexOfObject:obj];
    return (index != NSNotFound);
}

//  获取元素 无视 beyond bounds
- (id)pp_objectAtIndex:(NSInteger)index{
    if (index >= 0 && index < self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
}

//  数组 元素移动
- (NSArray *)pp_moveObjectFromIndex:(NSInteger)from toIndex:(NSInteger)to{
    NSMutableArray *tmp = [self mutableCopy];
    
    if (from < 0 || from >= self.count) {
        return tmp.copy;
    }
    if (from == to) {
        return tmp.copy;
    }
    
    id targetObj = tmp[from];
    
    [tmp removeObject:targetObj];
    
    if (to >= [tmp count]) {
        [tmp addObject:targetObj];
    } else {
        if (to < 0 ) {
            to = 0;
        }
        [tmp insertObject:targetObj atIndex:to];
    }
    
    return tmp.copy;
}

//  数组 元素交换
- (NSArray *)pp_exchangeObjectAtIndex:(NSInteger)index withObjectAtIndex:(NSInteger)withIndex{
    NSMutableArray *tmp = [self mutableCopy];
    
    if (index < 0 || index >= self.count) {
        return tmp.copy;
    }
    if (withIndex < 0 || withIndex >= self.count) {
        return tmp.copy;
    }
    if (index == withIndex) {
        return tmp.copy;
    }
    
    [tmp exchangeObjectAtIndex:index withObjectAtIndex:withIndex];
    
    return tmp.copy;
}

//  截取指定数量元素
- (NSArray *)pp_subArrayWithRange:(NSRange)range{
    if (range.location == NSNotFound || range.length == 0) {
        return [NSArray array];
    }
    
    if (range.location >= self.count) {
        return [NSArray array];
    }
    
    if (range.location + range.length <= self.count) {
        return [self subarrayWithRange:range];
    }else{
        return [self subarrayWithRange:NSMakeRange(range.location, self.count - range.location)];
    }
}

//  随机(连续且按序)截取指定数量元素
- (NSArray *)pp_subRandArrayWithCount:(NSInteger)count{
    if (count <= 0) {
        return [NSArray array];
    }
    if (count >= self.count) {
        return self.copy;
    }
    
    NSInteger waitCount = self.count - count;
    
    NSInteger index = arc4random() % (waitCount+1);
    
    if (index >= 0 && index < self.count) {
        return [self pp_subArrayWithRange:NSMakeRange(index, count)];
    }
    return [self pp_subArrayWithRange:NSMakeRange(0, count)];
}

//  仅支持对 元素实现compare:方法的 数组排序
- (NSArray *)pp_sortedForValueWithAscending:(BOOL)ascending{
    NSArray *tmp = self.copy;
    if (tmp.count == 0) {
        return tmp;
    }
    NSArray *sortedArray;
    @try {
        sortedArray= [tmp sortedArrayUsingSelector:@selector(compare:)];
    }
    @catch (NSException *exception) {
        NSLog(@"ad_sortedForValueWithAscending: object compare error");
    }
    @finally {}
    
    if (sortedArray.count == 0) {
        return tmp;
    }
    
    if (ascending) {
        return sortedArray;
    }else{
        return [sortedArray reverseObjectEnumerator].allObjects;
    }
}

//  仅支持对 元素实现compare:方法的 数组排序
- (NSArray *)pp_sortedForValueCaseInsensitiveWithAscending:(BOOL)ascending{
    NSArray *tmp = self.copy;
    if (tmp.count == 0) {
        return tmp;
    }
    NSArray *sortedArray;
    @try {
        sortedArray= [tmp sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];//不区分大小排序
    }
    @catch (NSException *exception) {
        NSLog(@"ad_sortedForValueCaseInsensitiveWithAscending: object compare error");
    }
    @finally {}
    
    if (sortedArray.count == 0) {
        return tmp;
    }
    
    if (ascending) {
        return sortedArray;
    }else{
        return [sortedArray reverseObjectEnumerator].allObjects;
    }
}


//  支持对 元素为未实现compare:方法的对象 数组排序
- (NSArray *)pp_sortedForObjWithAscending:(BOOL)ascending byKeys:(NSArray *)keys{
    NSArray *tmp = self.copy;
    if (tmp.count == 0 || keys.count == 0) {
        return tmp;
    }
    
    
    NSMutableArray *descrips = [NSMutableArray array];
    for (NSString *key in keys) {
        NSSortDescriptor *sorter  = [NSSortDescriptor sortDescriptorWithKey:key ascending:ascending];
        [descrips addObject:sorter];
    }
    
    NSArray *sortedArray = [tmp sortedArrayUsingDescriptors:descrips];
    
    if (ascending) {
        return sortedArray;
    }else{
        return [sortedArray reverseObjectEnumerator].allObjects;
    }
}


//  支持对 数组 进行大小排序 (按Integer比较)
- (NSArray *)pp_sortedForValueByIntegerWithAscending:(BOOL)ascending{
    NSArray *tmp = self.copy;
    if (tmp.count == 0) {
        return tmp;
    }
    NSComparator cmptr = ^(id obj1, id obj2){
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    
    NSArray *sortedArray;
    @try {
        sortedArray= [tmp sortedArrayUsingComparator:cmptr];
    }
    @catch (NSException *exception) {
        NSLog(@"ad_sortedForValueWithAscending: object compare error");
    }
    @finally {}
    
    if (sortedArray.count == 0) {
        return tmp;
    }
    
    if (ascending) {
        return sortedArray;
    }else{
        return [sortedArray reverseObjectEnumerator].allObjects;
    }
}

@end
