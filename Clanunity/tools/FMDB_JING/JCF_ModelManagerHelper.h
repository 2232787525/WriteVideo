//
//  JCF_ModelManagerHelper.h
//  FMDB_JCF_Pro
//
//  Created by jing on 16/11/7.
//  Copyright © 2016年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JCF_ModelProtocol.h"
#import "JCF_ModelBlockHeader.h"

//typedef NS_ENUM(NSInteger){
//    SQL_STATUS_ADD = 1,
//    SQL_STATUS_REMOVE = 2,
//    SQL_STATUS_UPDATA = 3,
//    SQL_STATUS_SEARCH = 4
//}SQL_STATUS;


/** SQLite五种数据类型 */
#define SQLTEXT     @"TEXT"
#define SQLINTEGER  @"INTEGER"
#define SQLREAL     @"REAL"
#define SQLBLOB     @"BLOB"
#define SQLNULL     @"NULL"
//sql 关键字
#define PrimaryKey  @"primary key"


@interface JCF_ModelManagerHelper : NSObject


/**根据名称生成数据库的路径  生成name */
- (NSString *)dbZFYPathByString:(NSString *)sqlLibraryName;

/** 根据class生成表名 */
- (NSString *)tableNameByModelClass:(Class)modelClass;

/**
 判断是否需要生成新列，若有block(sqlstring)
 @param tabname 保存的表名字
 @param modelClass 类
 @param saveNameArray 之前这个表的字段名字数组
 @param block 结果 sqlstring
 */
- (void)judgeSQLTableAddPropertyHaveByTabname:(NSString*)tabname modelClass:(Class)modelClass withPropertySaveArray:(NSArray *)saveNameArray AndSQLBlock:(JCF_AddPropertyBlcok)block;

/**创建表的sql语句 */
- (NSString *)createSQLTableByTabName:(NSString*)tabname modelClass:(Class)modelClass;

/**判断表存在的sql语句 */
- (NSString *)judgeSQLTableHave;

/**
 * 增加操作
 * 此方法生成sql语句，以及与sql匹配的value数组
 */
- (void)addModelToFmdbTabName:(NSString*)tabname WithModel:(NSObject <JCF_ModelProtocol>*)model
                    AndResult:(JCF_SQLAddModelBlock)block;

/**
 * 删除操作 （通过主键删除）
 * 通过model的delegate获取主键
 */
- (void)removeModelToFmdbTabName:(NSString*)tabname WithModel:(NSObject <JCF_ModelProtocol>*)model
                       AndResult:(JCF_SQLAddModelBlock)block;
/**更新model */
- (void)updateModelToFmdbTabName:(NSString*)tabname WithModel:(NSObject <JCF_ModelProtocol>*)model
                       AndResult:(JCF_SQLAddModelBlock)block;
/**
 * 查找
 * 1. 生成sql语句
 * 2. 结果转model
 * modelClass就是作为表名字，如果之前用的是model的class作为表名字，那么这里就传那个model的class，并且tabname可以不传
 * 总而言之就是 表名字要一至
 */
- (NSString *)searchModelToFmdbTabName:(NSString*)tabname WithModelClass:(Class)modelClass AndInfoDictionary:(NSDictionary *)infoDictionary;

- (NSObject <JCF_ModelProtocol> *)modelByModelClass:(Class)modelClass AndGetModelValueBlock:(JCF_GetModelValueBlock)block;

/**
 * 添加额外的sql语句
 */

@end

/**
 */
///**
// * sql语句
// *
// *
// */
//- (NSString *)sqlBySQLStatus:(SQL_STATUS)status WithPropertyDictionary:(NSDictionary *)propertyDictionary;
