//
//  PLBindThirdManager.h
//  Clanunity
//
//  Created by wangyadong on 2017/4/28.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 bindType 0微信，2qq
 
 result = @{@"openid":@"",@"nickname":@"",@"msg":@""}
 */

typedef void(^BindResultBlock)(NSInteger bindType,NSDictionary*result);


@interface PLBindThirdManager : NSObject
+(instancetype)bindThirdManager;

-(void)bindQQResultBlock:(BindResultBlock)block;
-(void)bindWeiChatResultBlock:(BindResultBlock)block;
/**Appdeligate微信回调回来 触发的方法 */
-(void)weChatLoginWithcode:(NSString *)code success:(BOOL)success;
@end
