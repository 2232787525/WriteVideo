//
//  CLHttpBai.m
//  Clanunity
//
//  Created by bex on 2018/1/16.
//  Copyright © 2018年 zfy_srf. All rights reserved.
//

#import "CLHttpBai.h"
#import "PLURLConstHeader.h"
@implementation CLHttpBai
+ (instancetype)sharedhttpBai{
    static dispatch_once_t onceToken;
    static CLHttpBai *httpBai = nil;
    
    dispatch_once(&onceToken, ^{
        httpBai = [[[self class ]alloc]init];
    });
    return httpBai;
}

#pragma mark －－－－－－－－－－－－－－－商家优惠－－－－－－－－－－--－－－－－
//TODO:商家优惠页banner
+(void)requestForBannerListReturn:(void (^)(BOOL isSuccess,NSString *msg,id data))completion;
{
    NetworkParameter *par = [[NetworkParameter alloc]init];
    par.parameter = @{
                      @"num":@"10"
                      };
    
    [NetService GET_NetworkParameter:par url:URL_shopproductdiscount_recommend successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (completion) {
            completion(YES,responseObject[@"msg"],nil);
        }
        
    } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(YES,@"获取失败商家优惠banner失败",nil);
    }];
}


#pragma mark －－－－－－－－－－－－－－－多处复用链接－－－－－－－－－－--－－－

//TODO:点赞
+(void)requestForGoodWithUUID:(NSString *)uuid block:(void(^)(BOOL isSuccess,NSString *msg,id data))completion;{
    NetworkParameter *par = [[NetworkParameter alloc] init];
    par.parameter = @{@"cntuid":uuid};
//    par.asd =[LOGIN_USER loginGetSessionModel].session_asd;

    [NetService POST_NetworkParameter:par url:@"/ysjapp/v0909/zfy/news/contentpraise" successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if (completion) {
                NSString *status = responseObject[@"status"];
                if ([status isEqualToString:@"OK"]) {
                    completion(YES,responseObject[@"msg"],nil);
                }else{
                    completion(NO,responseObject[@"msg"],nil);
                }
            }
        }
        
    } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            if( APPDELEGATE.networkStatus == 0){
                completion(NO,@"请检查您的网络",nil);
            }else{
                completion(NO,@"请求失败",nil);
            }
        }
    }];
}

@end
