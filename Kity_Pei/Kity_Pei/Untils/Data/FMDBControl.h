//
//  FMDBControl.h
//  Kity_Pei
//
//  Created by Kity_Pei on 2017/1/3.
//  Copyright © 2017年 Kity_Pei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

/**
 *  一个 ADFMDBControl 单例 控制一个DB
 *  为确保性能及多线程安全，本类所有update方法均采用多线程事务处理
 *  如需多个DB, 自行继承实现多个control对象
 *  update数据前 确保数据库表结构已更新(否则update会失败)
 *  单独获取字段: 字段默认值 [NULL],  取出为nil(nil存入为(null)取出为(null))、数值为0
 *  全部获取: 字段默认值 [NULL]
 */

@interface FMDBControl : NSObject

+ (instancetype)Instance;

/**
 *  创建数据库  必须首先执行(可放在app初始化时)
 *  @param path 文件路径 (传@“”:在cache中建立,close即clear; 传nil:内存中建立,close即clear)
 *  存在则读取,不存在则新建
 */
- (void)createDBWithPath:(NSString *)path;

/**
 *  创建表
 *  默认添加 id为主键
 *  @param keyDic 字段字典 key:字段名 value:类型(string)
 *  不存在则新建, 存在则更新字段(只会依次增加，不会删字段)
 */
- (void)createTableWithName:(NSString *)tableName keyDic:(NSDictionary *)keyDic;

/**
 *  增
 *  @param keyValueDic 字段字典List (key:字段名 value:值(string))
 *  @param filterSql sql条件
 */
- (void)insertDataInTableName:(NSString *)tableName keyValueDic:(NSDictionary *)keyValueDic filterSql:(NSString *)filterSql;

/**
 *  增
 *  @param keyValueDicList 字段字典List (key:字段名 value:值(string))List
 *  @param filterKeys 字段判断,字段值相同则覆盖 如: @[@"user_name", @"passwd"] (and关系)
 */
- (void)insertDataInTableName:(NSString *)tableName keyValueDicList:(NSArray *)keyValueDicList filterKeys:(NSArray *)filterKeys;

/**
 *  删
 *  @param filterSql sql条件 如: @"user_name = '600983'"  nil:则删除整张表数据
 */
- (void)deleteDataInTableName:(NSString *)tableName filterSql:(NSString *)filterSql;

/**
 *  改
 *  @param keyValueDic 字段字典 key:字段名 value:值(string)
 *  @param filterSql sql条件 如: @"user_name = '600983'"
 *
 */
- (void)updateDataInTableName:(NSString *)tableName keyValueDic:(NSDictionary *)keyValueDic filterSql:(NSString *)filterSql;

/**
 *  查
 *  @param key 要查询字段名
 *  @param filterSql sql条件 如: @"user_name = '600983'"
 *  @resultArray key存在@[id] 不存在@[@{key:value}]
 *
 */
- (void)selectDataInTableName:(NSString *)tableName key:(NSString *)key filterSql:(NSString *)filterSql result:(void (^) (NSArray *resultList))resultArray;

/**
 *  查 同步
 *  @param key 要查询字段名
 *  @param filterSql sql条件 如: @"WHERE user_name = '600983' ORDER BY m ASC,n DESC"
 *  @result key存在@[id] 不存在@[@{key:value}]
 */
- (NSArray *)selectDataInTableName:(NSString *)tableName key:(NSString *)key filterSql:(NSString *)filterSql;

@end
