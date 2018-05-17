//
//  ThirdLoginManager.h
//  PlamLive
//
//  Created by wangyadong on 2016/11/23.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ThirdLoginSuccessBlock)(LoginType type,NSString*masg,id result);

typedef void(^ThirdLoginFailedBlock)(LoginType type ,NSString*masg,NSString *status);

@interface ThirdLoginManager : NSObject

+(instancetype)thirdLoginManager;

/**qq第三方登录 */
-(void)thirdLoginForQQWithSuccess:(ThirdLoginSuccessBlock)success failed:(ThirdLoginFailedBlock)failed;

/**微信第三方登录 */
-(void)thirdLoginForWeChatSuccess:(ThirdLoginSuccessBlock)success failed:(ThirdLoginFailedBlock)failed;
/**Appdeligate微信回调回来 触发的方法 */
-(void)weChatLoginWithcode:(NSString*)code success:(BOOL)success;


@end
