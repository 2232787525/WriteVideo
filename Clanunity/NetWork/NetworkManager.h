//
//  NetworkManager.h
//  PlamLive
//
//  Created by wangyadong on 2016/12/6.
//  Copyright © 2016年 wangyadong. All rights reserved.
//
#import <AFNetworking/AFNetworking.h>
//#import "AFNetworking.h"

#define NetService NetworkManager

typedef void(^SuccessHandleBlock) (NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);

typedef void(^FailureHandleBlock) (NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);

typedef void(^ProgressHandleBlock) (NSProgress * _Nonnull downloadProgress);

typedef void(^DispathMainHandleBlock) (id  _Nullable sender);


@class NetworkParameter;
@interface NetworkManager : AFHTTPSessionManager

+(nonnull instancetype )shareNetworkManager;

@property(nonatomic,copy,readonly)NSString  * _Nullable reachabilityStatus;

+(void)POST_NetworkParameter:(NetworkParameter*_Nullable)model
                        url:(NSString*_Nonnull)url
               successBlock:(SuccessHandleBlock _Nonnull)successBlock
               failureBlock:(FailureHandleBlock _Nonnull)failureBlock;

/**
 get请求

 @param model 参数，特别注意如果get请求参数中需要用到asd，请使用model.asd
 @param url url
 @param successBlock 成功
 @param failureBlock 失败
 */
+(void)GET_NetworkParameter:(NetworkParameter*_Nullable)model
                        url:(NSString*_Nonnull)url
               successBlock:(SuccessHandleBlock _Nonnull)successBlock
               failureBlock:(FailureHandleBlock _Nonnull)failureBlock;

+(void)dispatch_mainQuine:(DispathMainHandleBlock _Nonnull)mainBlock;

/**
 

 @param model        <#model description#>
 @param url          <#url description#>
 @param fileParDic   传文件字典（字典中的key是根据服务端确定的）
  @{@"logo":@[logoimgDate],
    @"headimg":@[头像Date],
    @"bgimg":@[背景Date],
    @"idfrontimg":@[idfrontimgData],
    @"idbackimg":@[idbackImgData],
    @"idcard":@[idcardData],
    @"imgfile":@[imgImgData],
    @"imgfiles":@[img1Data,img2Data]
 }
 @param successBlock 成功
 @param failureBlock 失败
 */
+(void)POST_UpdateFilesNetworkParameter:(NetworkParameter*_Nullable)model
                                    url:(NSString*_Nonnull)url
                      withFileParameter:(NSDictionary*_Nonnull)fileParDic
                           successBlock:(SuccessHandleBlock _Nonnull)successBlock
                           failureBlock:(FailureHandleBlock _Nonnull)failureBlock;

//提交appkey，是否需要刷新
+(void)AppSignPostforappsecretFresh:(BOOL)fresh;

/**
 网络状态监视
 */
+(void)networkReachabilityStatus;


@end


@interface NetworkParameter : PLBaseModel

+(NetworkParameter *_Nonnull)networkParameter;

@property(nonatomic,strong,nullable)NSDictionary * parameter;
@property(nonatomic,copy,nullable)NSString * asd;
@property(nonatomic,copy,nullable)NSString * ts;

@property(nonatomic,copy,nullable)NSString * appkey;

@property(nonatomic,copy,nullable)NSString * appsign;

@property(nonatomic,copy,nullable)NSString * lon;

@property(nonatomic,copy,nullable)NSString * lat;

@property(nonatomic,copy,nullable)NSString * devicetoken;


@end
