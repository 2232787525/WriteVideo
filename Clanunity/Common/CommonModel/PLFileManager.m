//
//  PLFileManager.m
//  PlamLive
//
//  Created by wangyadong on 2016/11/7.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "PLFileManager.h"

#define CACHE_DEFINE_FILE_FOlDER @"CACHE_DEFINE_FILE_FOlDER"

#define CACHE_PICTURE_FILE_FOlDER @"CACHE_PICTURE_FILE_FOlDER"

@implementation PLFileManager

+(NSString*)cacheDefineFileFolder{
    NSFileManager *fileManager =  [NSFileManager defaultManager];
    NSString *cacheFolder =  [DOCUMENT_PATH stringByAppendingPathComponent:CACHE_DEFINE_FILE_FOlDER];
    if (![fileManager fileExistsAtPath:cacheFolder]) {
        [fileManager createDirectoryAtPath:cacheFolder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return cacheFolder;
}
+(BOOL)cacheDefineFileWithData:(NSData*)data fileName:(NSString*)name{
    return [data writeToFile:[[PLFileManager cacheDefineFileFolder] stringByAppendingPathComponent:name] atomically:YES];
}
+(BOOL)cacheDefineFileWithString:(NSString*)string fileName:(NSString*)name{
    return [[string dataUsingEncoding:NSUTF8StringEncoding] writeToFile:[[PLFileManager cacheDefineFileFolder] stringByAppendingPathComponent:name] atomically:YES];
}

+(NSData*)cacheWithFileName:(NSString*)name{
    return [NSData dataWithContentsOfFile:[[PLFileManager cacheDefineFileFolder] stringByAppendingPathComponent:name]];
}
+(NSString*)cacheTextWithFileName:(NSString*)name{
    NSError *error = nil;
    NSString *cacheText = [NSString stringWithContentsOfFile:[[PLFileManager cacheDefineFileFolder] stringByAppendingPathComponent:name] encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        return nil;
    }
    
    return cacheText;
}

+(BOOL)deleteDefineCacheWithName:(NSString*)name{
    NSFileManager *fileManager =  [NSFileManager defaultManager];
    NSError *error = nil;
    [fileManager removeItemAtPath:[[PLFileManager cacheDefineFileFolder] stringByAppendingPathComponent:name] error:&error];
    if (error) {
        return NO;
    }
    return YES;
}

//判断路径是非为文件夹
+(BOOL)isFolder:(NSString*)filePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = YES;
    //文件存在且为文件夹
    if([fileManager fileExistsAtPath:filePath isDirectory:&isDirectory]){
        //处理隐藏文件异常
        NSString *fileName = [filePath lastPathComponent];
        if ([fileName rangeOfString:@"._"].length == 0 && [fileName rangeOfString:@"._."].length == 0 && [fileName rangeOfString:@".DS_Store"].length == 0 && [fileName rangeOfString:@".svn"].length == 0){
            return YES;
        }
    }
    return NO;
}



@end
