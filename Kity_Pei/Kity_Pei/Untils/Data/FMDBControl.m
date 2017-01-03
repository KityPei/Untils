//
//  FMDBControl.m
//  Kity_Pei
//
//  Created by Kity_Pei on 2017/1/3.
//  Copyright © 2017年 Kity_Pei. All rights reserved.
//

#import "FMDBControl.h"
#import "FMDatabaseAdditions.h"

@interface FMDBControl()

@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) FMDatabaseQueue *dbQueue;

@end


@implementation FMDBControl

static FMDBControl *instance = nil;

+ (instancetype)Instance; {
    @synchronized (self) {
        if (!instance) {
            instance = [[self alloc] init];
        }
    }
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    @synchronized (self) {
        if (!instance) {
            instance = [super allocWithZone:zone];
        }
    }
    return instance;
}

- (id)copy {
    return self;
}

- (id)mutableCopy {
    return self;
}

//  创建数据库  必须首先执行(可放在app初始化时)
- (void)createDBWithPath:(NSString *)path {
    self.path = path;
    self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:path];
}

//  创建表
- (void)createTableWithName:(NSString *)tableName keyDic:(NSDictionary *)keyDic {
    if (!tableName || tableName.length == 0) {
        return;
    }
    if (!keyDic || ![keyDic isKindOfClass:[NSDictionary class]] || keyDic.count == 0) {
        return;
    }
    
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if (![db tableExists:tableName]) {
            NSString *sqlCreateTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY AUTOINCREMENT",tableName];
            for (NSString *key in [keyDic allKeys]) {
                sqlCreateTable = [sqlCreateTable stringByAppendingString:[NSString stringWithFormat:@",%@ %@",key,keyDic[key]]];
            }
            sqlCreateTable = [sqlCreateTable stringByAppendingString:@")"];
            
            BOOL res = [db executeUpdate:sqlCreateTable];
            if (!res) {
                NSLog(@"DB: ERROR WHEN CREATING TABLE");
            } else {}
        } else {
            for (NSString *key in [keyDic allKeys]) {
                if (![db columnExists:key inTableWithName:tableName]) {
                    NSString *sql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@",tableName,key,keyDic[key]];
                    BOOL res = [db executeUpdate:sql];
                    if (!res) {
                        NSLog(@"DB: ERROR WHEN ALTER DB TABLE");
                    }
                }
            }
        }
    }];
    
}

//  增
- (void)insertDataInTableName:(NSString *)tableName keyValueDic:(NSDictionary *)keyValueDic filterSql:(NSString *)filterSql {
    if (!tableName || tableName.length == 0) {
        return;
    }
    if (!keyValueDic || ![keyValueDic isKindOfClass:[NSDictionary class]] || keyValueDic.count == 0) {
        return;
    }
    
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        @try {
            if (filterSql && filterSql.length > 0) {
                NSString *sqlSelect = [NSString stringWithFormat:@"SELECT * FROM %@ %@",tableName,filterSql];
                FMResultSet *rs = [db executeQuery:sqlSelect];
                if ([rs next]) {
                    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM %@ %@",tableName,filterSql];
                    BOOL res = [db executeUpdate:deleteSql];
                    if (!res) {
                        NSLog(@"DB:ERROR WHEN DELETE DB TABLE IN INSERT");
                    } else {
                        
                    }
                    [rs close];
                }
            }
            
            NSArray *keysList = keyValueDic.allKeys;
            NSString *sqlKeyString = [keysList componentsJoinedByString:@","];
            NSString *sqlValueString = [NSString stringWithFormat:@":%@",[keysList componentsJoinedByString:@",:"]];
            
            BOOL res = [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)",tableName,sqlKeyString,sqlValueString] withParameterDictionary:keyValueDic];
            if (!res) {
                NSLog(@"DB:ERROR WHEN INSERT DB TABLE");
            } else {}
        } @catch (NSException *exception) {
            NSLog(@"DB: ERROR WHEN INSERT TABLE");
            *rollback = YES;
        } @finally {}
    }];
}

//  增
- (void)insertDataInTableName:(NSString *)tableName keyValueDicList:(NSArray *)keyValueDicList filterKeys:(NSArray *)filterKeys {
    if (!tableName || tableName.length == 0) {
        return;
    }
    if (!keyValueDicList || ![keyValueDicList isKindOfClass:[NSArray class]] || keyValueDicList.count == 0) {
        return;
    }
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        @try {
            for (NSDictionary *keyValueDic in keyValueDicList) {
                if (!keyValueDic || ![keyValueDic isKindOfClass:[NSDictionary class]] || keyValueDic.count == 0) {
                    continue;
                }
                
                if (filterKeys && [filterKeys isKindOfClass:[NSArray class]] && filterKeys.count > 0) {
                    NSString *filterString = @"";
                    for (NSString *filterKey in filterKeys) {
                        NSString *filterKeyValue = keyValueDic[filterKey];
                        if (filterKeyValue) {
                            if ([filterString isEqualToString:@""]) {
                                filterString = [filterString stringByAppendingString:[NSString stringWithFormat:@"%@ = %@",filterKey,filterKeyValue]];
                            } else {
                                filterString = [filterString stringByAppendingString:[NSString stringWithFormat:@" and %@ = %@",filterKey,filterKeyValue]];
                            }
                        }
                    }
                    
                    if (filterString && filterString.length > 0) {
                        NSString *sqlSelect = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@",tableName,filterString];
                        FMResultSet *rs = [db executeQuery:sqlSelect];
                        if ([rs next]) {
                            NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@",tableName,filterString];
                            BOOL res = [db executeUpdate:deleteSql];
                            if (!res) {
                                NSLog(@"DB:ERROR WHEN DELETE DB TABLE IN INSERT");
                            } else {
                                
                            }
                        }
                        [rs close];
                    }
                }
                
                NSArray *keysList = keyValueDic.allKeys;
                NSString *sqlKeyString = [keysList componentsJoinedByString:@","];
                NSString *sqlValueString = [NSString stringWithFormat:@":%@",[keysList componentsJoinedByString:@",:"]];
                
                BOOL res = [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)",tableName,sqlKeyString,sqlValueString] withParameterDictionary:keyValueDic];
                if (!res) {
                    NSLog(@"DB:ERROR WHEN INSERT DB TABLE");
                } else {}
            }
        } @catch (NSException *exception) {
            NSLog(@"DB:ERROR WHEN INSERT TABLE");
            *rollback = YES;
        } @finally {}
    }];
}

//  删
- (void)deleteDataInTableName:(NSString *)tableName filterSql:(NSString *)filterSql {
    if (!tableName || tableName.length == 0) {
        return;
    }
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        @try {
            NSString *deleteSql = @"";
            if (filterSql && filterSql.length > 0) {
                deleteSql = [NSString stringWithFormat:@"DELETE FROM %@ %@",tableName,filterSql];
            } else {
                deleteSql = [NSString stringWithFormat:@"DELETE FROM %@",tableName];
            }
            BOOL res = [db executeUpdate:deleteSql];
            if (!res) {
                NSLog(@"ERROR WHEN DELETE DB TABLE");
            } else {}
        } @catch (NSException *exception) {
            NSLog(@"DB: ERROR WHEN DELETE TABLE");
            *rollback = YES;
        } @finally {}
    }];
}

//  改
- (void)updateDataInTableName:(NSString *)tableName keyValueDic:(NSDictionary *)keyValueDic filterSql:(NSString *)filterSql {
    if (!tableName || tableName.length == 0) {
        return;
    }
    if (!keyValueDic || ![keyValueDic isKindOfClass:[NSDictionary class]] || keyValueDic.count == 0) {
        return;
    }
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        @try {
            NSString *setString = @"";
            for (NSString *key in [keyValueDic allKeys]) {
                if ([setString isEqualToString:@""]) {
                    setString = [setString stringByAppendingString:[NSString stringWithFormat:@"%@ = :%@",key,key]];
                } else {
                    setString = [setString stringByAppendingString:[NSString stringWithFormat:@",%@ = :%@",key,key]];
                }
            }
            NSString *sqlUpdate;
            if (filterSql && filterSql.length > 0) {
                sqlUpdate = [NSString stringWithFormat:@"UPDATE %@ SET %@ %@",tableName,setString,filterSql];
            } else {
                sqlUpdate = [NSString stringWithFormat:@"UPDATE %@ SET %@",tableName,setString];
            }
            BOOL res = [db executeUpdate:sqlUpdate withParameterDictionary:keyValueDic];
            
            if (!res) {
                NSLog(@"DB: ERROR WHEN UPDATE DB TABLE");
            } else {
                
            }
            
        } @catch (NSException *exception) {
            NSLog(@"DB: ERROR WHEN UPDATE TABLE");
            *rollback = YES;
        } @finally {}
    }];
}

//  查
- (void)selectDataInTableName:(NSString *)tableName key:(NSString *)key filterSql:(NSString *)filterSql result:(void (^) (NSArray *resultList))resultArray {
    if (!tableName || tableName.length == 0) {
        if (resultArray) {
            resultArray(nil);
        }
        return;
    }
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            NSString *sqlSelect;
            if (filterSql && filterSql.length > 0) {
                sqlSelect = [NSString stringWithFormat:@"SELECT %@ FROM %@ %@",(key && key.length > 0)?key:@"*",tableName,filterSql];
            } else {
                sqlSelect = [NSString stringWithFormat:@"SELECT %@ FROM %@",(key && key.length > 0)?key:@"*",tableName];
            }
            
            FMResultSet *rs = [db executeQuery:sqlSelect];
            NSMutableArray *resultList = [NSMutableArray array];
            while ([rs next]) {
                if (key && key.length > 0) {
                    [resultList addObject:[rs objectForColumnName:key]];
                } else {
                    [resultList addObject:rs.resultDictionary];
                }
            }
            if (resultList) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    resultArray(resultList);
                });
            }
            [rs close];
        } @catch (NSException *exception) {
            NSLog(@"DB:ERROR WHEN SELECT DB TABLE");
        } @finally {}
    }];
    
}

//  查 同步
- (NSArray *)selectDataInTableName:(NSString *)tableName key:(NSString *)key filterSql:(NSString *)filterSql {
    if (!tableName || tableName.length == 0) {
        return nil;
    }
    FMDatabase *db = [FMDatabase databaseWithPath:self.path];
    if ([db open]) {
        @try {
            NSString *sqlSelect;
            if (filterSql && filterSql.length > 0) {
                sqlSelect = [NSString stringWithFormat:@"SELECT %@ FROM %@ %@",(key && key.length > 0) ? key : @"*",tableName,filterSql];
            } else {
                sqlSelect = [NSString stringWithFormat:@"SELECT %@ FROM %@",(key && key.length > 0)?key:@"*",tableName];
            }
            FMResultSet *rs = [db executeQuery:sqlSelect];
            NSMutableArray *resultList = [NSMutableArray array];
            while ([rs next]) {
                if (key && key.length > 0) {
                    [resultList addObject:[rs objectForColumnName:key]];
                } else {
                    [resultList addObject:rs.resultDictionary];
                }
            }
            [rs close];
            [db close];
            return  resultList;
        } @catch (NSException *exception) {
            NSLog(@"DB: ERROR WHEN SELECT TABLE SYNC");
        } @finally {}
    }
}

@end
