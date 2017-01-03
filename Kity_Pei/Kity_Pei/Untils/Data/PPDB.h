//
//  PPDB.h
//  Kity_Pei
//
//  Created by Kity_Pei on 2017/1/3.
//  Copyright © 2017年 Kity_Pei. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PATH_DocumentDirectory NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]
#define PATH_DocumentDirectoryWith(pathComponent) [PATH_DocumentDirectory stringByAppendingPathComponent:pathComponent]
#define DB_PATH   PATH_DocumentDirectoryWith(@"DataModel.sqlite")

#define DATA_TABLE_DEMO_Name @"demo"




@interface PPDB : NSObject

+ (void)DBInitWithName:(NSString *)name complete:(void (^)())complete;

+ (void)insertDataInTableName:(NSString *)tableName keyValueDic:(NSDictionary *)keyValueDic filterSql:(NSString *)filterSql;

+ (void)insertDataInTableName:(NSString *)tableName keyValueDicList:(NSArray *)keyValueDicList filterKeys:(NSArray *)filterKeys;

+ (void)updateDataInTableName:(NSString *)tableName keyValueDic:(NSDictionary *)keyValueDic filterSql:(NSString *)filterSql;

+ (void)deleteDataInTableName:(NSString *)tableName filterSql:(NSString *)filterSql;

+ (void)selectDataInTableName:(NSString *)tableName key:(NSString *)key filterSql:(NSString *)filterSql result:(void (^) (NSArray *resultList))result;

+ (NSArray *)selectDataInTableName:(NSString *)tableName key:(NSString *)key filterSql:(NSString *)filterSql;

@end
