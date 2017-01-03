//
//  PPDB.m
//  Kity_Pei
//
//  Created by Kity_Pei on 2017/1/3.
//  Copyright © 2017年 Kity_Pei. All rights reserved.
//

#import "PPDB.h"
#import "FMDBControl.h"

#define DATA_TABLE_DEMO_Struct [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Demo" ofType:@"plist"]]


@implementation PPDB

+ (void)DBInitWithName:(NSString *)name complete:(void (^)())complete {
    if (name && name.length > 0) {
        NSString *pathName = [NSString stringWithFormat:@"%@.sqlite",name];
        [[FMDBControl Instance] createDBWithPath:PATH_DocumentDirectoryWith(pathName)];
    } else {
        [[FMDBControl Instance] createDBWithPath:DB_PATH];
    }
    
    [self DBUpdateStruct];//初始化数据库的表
    
    NSLog(@"PATH_DocumentDirectory === %@",PATH_DocumentDirectory);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (complete) {
            complete();
        }
    });
    
    
}

+ (void)DBUpdateStruct {
    [[FMDBControl Instance] createTableWithName:DATA_TABLE_DEMO_Name keyDic:DATA_TABLE_DEMO_Struct];
}

+ (void)insertDataInTableName:(NSString *)tableName keyValueDic:(NSDictionary *)keyValueDic filterSql:(NSString *)filterSql {
    [[FMDBControl Instance] insertDataInTableName:tableName keyValueDic:keyValueDic filterSql:filterSql];
}

+ (void)insertDataInTableName:(NSString *)tableName keyValueDicList:(NSArray *)keyValueDicList filterKeys:(NSArray *)filterKeys {
    [[FMDBControl Instance] insertDataInTableName:tableName keyValueDicList:keyValueDicList filterKeys:filterKeys];
}

+ (void)updateDataInTableName:(NSString *)tableName keyValueDic:(NSDictionary *)keyValueDic filterSql:(NSString *)filterSql {
    [[FMDBControl Instance] updateDataInTableName:tableName keyValueDic:keyValueDic filterSql:filterSql];
}

+ (void)deleteDataInTableName:(NSString *)tableName filterSql:(NSString *)filterSql {
    [[FMDBControl Instance] deleteDataInTableName:tableName filterSql:filterSql];
}

+ (void)selectDataInTableName:(NSString *)tableName key:(NSString *)key filterSql:(NSString *)filterSql result:(void (^) (NSArray *resultList))result {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[FMDBControl Instance] selectDataInTableName:tableName key:key filterSql:filterSql result:result];
    });
}

+ (NSArray *)selectDataInTableName:(NSString *)tableName key:(NSString *)key filterSql:(NSString *)filterSql {
    return [[FMDBControl Instance] selectDataInTableName:tableName key:key filterSql:filterSql];
}

@end
