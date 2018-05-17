//
//  PLFileManager.h
//  PlamLive
//
//  Created by wangyadong on 2016/11/7.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLFileManager : NSObject

/**
 *  缓存文件默认目录
 *
 *  @return <#return value description#>
 */
+(NSString*)cacheDefineFileFolder;

/**
 *  缓存NSData为文件
 *
 *  @param data 文件名
 *  @param name <#name description#>
 *
 *  @return <#return value description#>
 */
+(BOOL)cacheDefineFileWithData:(NSData*)data fileName:(NSString*)name;

/**
 *  缓存字符串为文件
 *
 *  @param string 字符串内容
 *  @param name   文件名
 *
 *  @return <#return value description#>
 */
+(BOOL)cacheDefineFileWithString:(NSString*)string fileName:(NSString*)name;

/**
 *  获取缓存文件为NSData
 *
 *  @param name 文件名
 *
 *  @return <#return value description#>
 */
+(NSData*)cacheWithFileName:(NSString*)name;

/**
 *  获取缓存文件为字符串
 *
 *  @param name 文件名
 *
 *  @return <#return value description#>
 */

+(NSString*)cacheTextWithFileName:(NSString*)name;
/**
 *  根据文件名删除文件
 *
 *  @param name 文件名
 *
 *  @return <#return value description#>
 */
+(BOOL)deleteDefineCacheWithName:(NSString*)name;
//判断路径是非为文件夹
+(BOOL)isFolder:(NSString*)filePath;

@end
