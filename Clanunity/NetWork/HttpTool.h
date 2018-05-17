//
//  HttpTool.h
//  PLHttp
//
//  Created by Mac on 16/10/19.
//  Copyright © 2016年 ZhangFY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "AFNetworking.h"

//响应成功的回调
typedef void(^SuccessHandle) (NSURLSessionDataTask *  task, id  responseObject);
//响应错误的回调
typedef void(^FailureHandle) (NSURLSessionDataTask *  task, NSError *  error);
//响应进度的回调
typedef void(^ProgressHandle) (NSProgress *  downloadProgress);
//下载回调
typedef void (^DownLoadFileBlock)(NSError *  error);


@interface HttpTool : NSObject

/**
 *  Base64编码
 *
 *  @param string          字符串
 */

+(NSString *)base64EncodeString:(NSString *)string;

/**
 *  字典转json格式字符串
 *
 *  @param dic             字典
 */

+(NSString *_Nullable)dictionaryToJson:(NSDictionary *_Nullable)dic;

/**
 *  通用文件下载
 *
 *  @param url          URL
 *  @param savePath     保存路径
 *  @param down         下载失败回调
 *  @param progress     进度回调
 */

+(void)DownLoadFileFromHttp:(NSString * )url
                   SavePath:(NSString * )savePath
                       Down:(DownLoadFileBlock )down
                   progress:(ProgressHandle )progress;


/**
 *  验证身份证号码是否正确的方法
 *
 *  @param IDNumber 传进身份证号码字符串
 *
 *  @return 返回YES或NO表示该身份证号码是否符合国家标准
 */

+ (BOOL)isCorrect:(NSString *)IDNumber;

/**
 *  返回错误判断
 *
 *  @param status          状态
 */

+(NSString *)StateTo:(NSString *)status;

+(NSString *)base64EncodeString:(NSString *)string;
+ (NSString *)encodeToPercentEscapeString: (NSString *) input;
+(BOOL)isBlankString:(id  )sting;

@end
