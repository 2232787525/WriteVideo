//
//  CLHttpBai.h
//  Clanunity
//
//  Created by bex on 2018/1/16.
//  Copyright © 2018年 zfy_srf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLHttpBai : NSObject
+ (instancetype)sharedhttpBai;//单例

#pragma mark －－－－－－－－－－－－－－－商家优惠－－－－－－－－－－--－－－－－
//TODO:商家优惠页banner
+(void)requestForBannerListReturn:(void (^)(BOOL isSuccess,NSString *msg,id data))completion;

//TODO:点赞
+(void)requestForGoodWithUUID:(NSString *)uuid block:(void(^)(BOOL isSuccess,NSString *msg,id data))completion;

@end
