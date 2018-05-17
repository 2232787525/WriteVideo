//
//  JCF_ModelManager.m
//  FMDB_JCF_Pro
//
//  Created by jing on 16/11/7.
//  Copyright © 2016年 jing. All rights reserved.
//

#import "JCF_ModelManager.h"
@interface JCF_ModelManager ()
/**
 * FMDB对象
 */
@property (nonatomic,strong)FMDatabaseQueue *dbQueue;
/**
 * 辅助方法类
 * 生成sql语句
 * 搜索结果 转 model
 */
@property (nonatomic,strong)JCF_ModelManagerHelper *helping;
//
@property (nonatomic,strong)NSString *name;
//用来存储class的数组
@property (nonatomic,strong)NSMutableArray *classNameArray;

#pragma mark 建表
- (BOOL)createTableName:(NSString*)tabname ByClass:(Class)modelClass;
#pragma mark 增删改
- (BOOL)addModel:(NSObject <JCF_ModelProtocol>*)model forTabName:(NSString*)tabname;
- (BOOL)removeModel:(NSObject <JCF_ModelProtocol>*)model forTabName:(NSString*)tabname;
- (BOOL)updateModel:(NSObject <JCF_ModelProtocol>*)model forTabName:(NSString*)tabname;

@end
@implementation JCF_ModelManager

#pragma mark 初始化___数据库的名字
- (instancetype)initWithDataBaseName:(NSString *)name{
    self = [super init];
    if (self) {
        self.name = name;//数据库名称的一部分，忘记就会丢库～～
    }
    return self;
}
#pragma mark 单个___增删改
-(BOOL)updataModelForTabName:(NSString *)tabname ByType:(MODEL_MANAGER_TYPE)type WithModel:(NSObject<JCF_ModelProtocol> *)model{
    //建表或更新列(内部做了判断，一个类只会调用一次)
    [self createTableName:tabname ByClass:model.class];
    
    BOOL res = NO;
    switch (type) {
            case MODEL_MANAGER_TYPE_ADD:
            res = [self addModel:model forTabName:tabname];
            break;
            case MODEL_MANAGER_TYPE_REM:
            res = [self removeModel:model forTabName:tabname];
            break;
            case MODEL_MANAGER_TYPE_CHANGE:
            res =  [self updateModel:model forTabName:tabname];
            break;
    }
    return res;
}

#pragma mark 批量___增删改

-(void)updateModelsForTabName:(NSString *)tabname ByType:(MODEL_MANAGER_TYPE)type WithModels:(NSArray<NSObject<JCF_ModelProtocol> *> *)models AndFinishBlock:(JCF_ResultBlock)block{
    __weak typeof(self) weakSelf = self;
    
    BOOL(^swithBlock)(MODEL_MANAGER_TYPE type,NSObject<JCF_ModelProtocol> *model,FMDatabase *db) = ^(MODEL_MANAGER_TYPE type,NSObject<JCF_ModelProtocol> *model,FMDatabase *db){
        BOOL res = NO;
        switch (type) {
                case MODEL_MANAGER_TYPE_ADD:
                res = [weakSelf addAction:db withModel:model forTabname:tabname];
                break;
                case MODEL_MANAGER_TYPE_REM:
                res = [weakSelf removeAction:db withModel:model forTabName:tabname];
                break;
                case MODEL_MANAGER_TYPE_CHANGE:
                res = [weakSelf updateAction:db withModel:model forTabName:tabname];
                break;
        }
        return res;
    };
    
    NSMutableArray *fairModelArray = [NSMutableArray array];
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (NSObject<JCF_ModelProtocol> *model in models) {
            //建表
            [weakSelf createTableAction:db WithRollback:rollback AndTabname:tabname andClass:model.class];
            //不同的操作
            BOOL success = swithBlock(type,model,db);
            if (!success) [fairModelArray addObject:model];
        }
    }];
    if (fairModelArray.count == 0){
        block(YES,nil);
    }else{
        block(NO,fairModelArray);
    }
    
}

#pragma mark 条件查找
- (NSArray *)searchModelsByTabname:(NSString*)tabname ModelClass:(Class)modelClass AndSearchPropertyDictionary:(NSDictionary *)propertyDictionary{
    //建表或更新列(内部做了判断，一个类只会调用一次)
    
    [self createTableName:tabname ByClass:modelClass];
    NSMutableArray *models = [NSMutableArray array];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sqlString = [self.helping searchModelToFmdbTabName:tabname WithModelClass:modelClass AndInfoDictionary:propertyDictionary];
        FMResultSet *resultSet = [db executeQuery:sqlString];
        while ([resultSet next]) {
            NSObject <JCF_ModelProtocol> *model = [self.helping modelByModelClass:modelClass AndGetModelValueBlock:^id(NSString *columeName, PROPERTY_TYPE type) {
                switch (type) {
                        case PROPERTY_TYPE_STRING:
                        return [resultSet stringForColumn:columeName];
                        case PROPERTY_TYPE_DATA:
                        return [resultSet dataForColumn:columeName];
                        case PROPERTY_TYPE_LONGLONG:
                        return @([resultSet longLongIntForColumn:columeName]);
                }
            }];
            [models addObject:model];
            FMDBRelease(model);
        }
    }];
    return models;
}

/**
 * 建表 类，表名
 * createTableAction 为了解决 addmodels 导致的嵌套死锁
 */
- (BOOL)createTableAction:(FMDatabase *)db WithRollback:(BOOL *)rollback AndTabname:(NSString*)tabname andClass:(Class)modelClass{
    __block BOOL res = YES;
    NSString *tableName = tabname;
    //不包含则 更新表 或者 创建表
    if ([self.classNameArray containsObject:tableName]) {
        return YES;
    }
   NSString *tableHaveSQLString = [self.helping judgeSQLTableHave];
    
    FMResultSet *rs = [db executeQuery:tableHaveSQLString,tableName];
    BOOL isCreate = NO;
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        if (count != 0) isCreate = YES;
    }
    if (isCreate) {
        //已经创建：添加tab的 新列
        NSArray *columns = [self dataBaseProertyByFMDatabase:db AndTableName:tableName];
        [self.helping judgeSQLTableAddPropertyHaveByTabname:tabname modelClass:modelClass withPropertySaveArray:columns AndSQLBlock:^(NSString *sqlString) {
            if (![db executeUpdate:sqlString]) {
                res = NO;
                *rollback = YES;
                //                return ;
            }
        }];
    }else{
        //未被创建：创建tab
        NSString *tableCreateSQLString =[self.helping createSQLTableByTabName:tabname modelClass:modelClass];
        if (![db executeUpdate:tableCreateSQLString]) {
            res = NO;
            *rollback = YES;
        };
    }
    
    //成功的话存储一下class
    if (res) {
        [self.classNameArray addObject:tableName];
    }
    return res;
}

- (BOOL)createTableName:(NSString*)tabname ByClass:(Class)modelClass{
    __block BOOL res = YES;
    __weak typeof(self) weakSelf = self;
    //1. 判断表是否存在，存在则继续执行第二步,（不存在不需要执行第二步）
    //2. 判断是否属性有删减，
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [weakSelf createTableAction:db WithRollback:rollback AndTabname:tabname andClass:modelClass];
    }];
    return res;
}

/**
 * 增
 * 批量增
 * 单个增
 *
 */
- (BOOL)addModel:(NSObject <JCF_ModelProtocol>*)model forTabName:(NSString*)tabname{
    __block BOOL res = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        res = [self addAction:db withModel:model forTabname:tabname];
    }];
    NSLog(@"-------%@",res?@"成功":@"失败");
    return res;
}

- (BOOL)addAction:(FMDatabase *)db
        withModel:(NSObject <JCF_ModelProtocol>*)model forTabname:(NSString*)tabname{
    __block BOOL res = NO;
    [self.helping addModelToFmdbTabName:tabname WithModel:model AndResult:^(NSString *sqlString, NSArray *valueArray) {
        res = [db executeUpdate:sqlString withArgumentsInArray:valueArray];
        NSLog(@"%@,%@",res?@"成功":@"失败",sqlString);
    }];
    return res;
}

/**
 * 删
 * 批量删
 * 单个删
 *
 */
- (BOOL)removeModel:(NSObject <JCF_ModelProtocol>*)model forTabName:(NSString*)tabname{
    __block BOOL res = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        res = [self removeAction:db withModel:model forTabName:tabname];
    }];
    return res;
}
- (BOOL)removeAction:(FMDatabase *)db
           withModel:(NSObject <JCF_ModelProtocol>*)model forTabName:(NSString*)tabname{
    __block BOOL res = NO;
    [self.helping removeModelToFmdbTabName:tabname WithModel:model AndResult:^(NSString *sqlString, NSArray *valueArray) {
        res = [db executeUpdate:sqlString withArgumentsInArray:valueArray];
        NSLog(@"%@,%@",res?@"成功":@"失败",sqlString);
    }];
    return res;
}
/**
 * 改
 * 批量改
 * 单个改
 * 注意：加上这个需求（如果是model以前没存在则自动add）
 */
- (BOOL)updateModel:(NSObject <JCF_ModelProtocol>*)model forTabName:(NSString*)tabname{
    __block BOOL res = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        res = [self updateAction:db withModel:model forTabName:tabname];
    }];
    return res;
}
- (BOOL)updateAction:(FMDatabase *)db
           withModel:(NSObject <JCF_ModelProtocol>*)model forTabName:(NSString*)tabname{
    __block BOOL res = NO;
    [self.helping updateModelToFmdbTabName:tabname WithModel:model AndResult:^(NSString *sqlString, NSArray *valueArray) {
        res = [db executeUpdate:sqlString withArgumentsInArray:valueArray];
        NSLog(@"%@,%@",res?@"成功":@"失败",sqlString);
    }];
    return res;
}
/**
 * 查找
 * modelClass model的class
 * propertyDictionary = @{
 @"属性名":value,
 @"属性名":value,
 };
 * SoreArray 条件排序
 */
// AndSoreArray  以后在添加排序


-(void)deleteAllDataFromTable:(NSString*)tabname AndFinishBlock:(JCF_ResultBlock)block{
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        NSString *sql = [NSString stringWithFormat:@"delete from %@",tabname];
        NSString *haveTabSql = [self.helping judgeSQLTableHave];//判断是否有这个表的sql语句
        FMResultSet *rs = [db executeQuery:haveTabSql,tabname];
        
        BOOL isTabHave = NO;
        while ([rs next]) {
            NSInteger count = [rs intForColumn:@"count"];
            if (count != 0) isTabHave = YES;
        }
        if (isTabHave) {//表存在 就去删除这个表的数据
            isTabHave = [db executeUpdate:sql];
        }else{
            //不存在也就不需要删除，相当于删除成功了
            isTabHave = YES;
        }
        block(isTabHave,nil);
    }];
    
}



#pragma mark 辅助方法。
- (NSArray *)dataBaseProertyByFMDatabase:(FMDatabase *)db AndTableName:(NSString *)tableName{
    NSMutableArray *columns = [NSMutableArray array];
    FMResultSet *resultSet = [db getTableSchema:tableName];
    while ([resultSet next]) {
        NSString *column = [resultSet stringForColumn:@"name"];
        [columns addObject:column];
    }
    return columns;
}
#pragma mark get 方法
-(JCF_ModelManagerHelper *)helping{
    if (!_helping) {
        _helping = [[JCF_ModelManagerHelper alloc] init];
    }
    return _helping;
}
-(FMDatabaseQueue *)dbQueue{
    if (!_dbQueue) {
        _dbQueue = [[FMDatabaseQueue alloc] initWithPath:[self.helping dbZFYPathByString:self.name]];
    }
    return _dbQueue;
}
-(NSMutableArray *)classNameArray{
    if (!_classNameArray) {
        _classNameArray = [NSMutableArray array];
    }
    return _classNameArray;
}
@end
