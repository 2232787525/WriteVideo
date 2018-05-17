//
//  LoginUserManager.h
//  PlamLive
//
//  Created by wangyadong on 2016/11/15.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginResultModel.h"

#define LOGIN_USER [LoginUserManager loginShareManager]
@class PLBaseViewController;
@interface LoginUserManager : NSObject

+(instancetype _Nonnull )loginShareManager;

/**保存登录成功之后 LoginSessionModel数据 */
-(void)loginSuccessSaveSessionData:(LoginSessionModel * _Nullable )model;
/**sharecode数据 */
-(void)loginSuccessSavesharecodeData:(NSString *_Nullable)sharecode shareName:(NSString*_Nullable)name;

/**返回LoginSessionModel数据 */
-(LoginSessionModel*_Nullable)loginGetSessionModel;

/**保存登录成功之后LoginUserModel 用户的数据 */
-(void)loginSuccessSaveUserData:(LoginUserModel*_Nullable)userModel;
-(void)loginRefreshIntegralWithIntegral:(NSInteger)integral;

/**返回 LoginUserModel 数据 */
-(LoginUserModel *_Nullable)loginGetUserModel;
/**sharecode数据 */
-(NSString *_Nullable)loginGetsharecodeData;
/**sharename数据 */
-(NSString *_Nullable)loginGetshareNameData;

/**保存登录成功之后 BindModel数组 用户的数据 */
-(void)loginSuccessSaveBindsData:(NSArray<BindModel*>*_Nullable)binds;
/**返回 LoginUserModel 数据 */
-(NSArray<BindModel*>*_Nullable)loginGetBinds;

/**utp数据 */
-(void)loginSuccessSaveUTPData:(LoginType)utp;
/**返回 utp 数据 */
-(LoginType)loginGetUtp;

/**获取保存的选好的地址，name,code[NSNumber],level[NSNumber](1省，2市，3区，4社区，5小区) */
-(NSDictionary<NSString *,id>*)areaGetCacheArea;
/**保存数据name,code[NSNumber],level[NSNumber] */
-(void)areaCacheArea:(NSDictionary*)area;

-(void)areaCacheAreaAllInfo:(NSDictionary *)area;
-(NSDictionary *)areaGetCacheAreaAllInfo;

-(void)deviceTokenSaveKey:(NSString*)deviceToken;
-(NSString*)deviceTokenGet;

/**
 present弹出登录页面
 */
-(void)showLoginVCFromVC:(PLBaseViewController*)fatherVC WithBackBlock:(void (^)(BOOL successBack,id modle))block;

/**
 退出登录调用退出接口，清空asd数据，清空用户数据
 @param block 回调
 */
-(void)loginOutClearDataWithRequestBlock:(void(^)(BOOL success))block;


@end



