//
//  LoginUserManager.m
//  PlamLive
//
//  Created by wangyadong on 2016/11/15.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "LoginUserManager.h"
#import "PLLoginViewController.h"
#import "KNavigationController.h"

static LoginUserManager  * manager = nil;

@implementation LoginUserManager

+(instancetype)loginShareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LoginUserManager alloc] init];
    });
    return manager;
}

/**保存登录成功之后 LoginSessionModel数据 */
-(void)loginSuccessSaveSessionData:(LoginSessionModel*)model{
    
    if (model!=nil) {
        [PLFileManager cacheDefineFileWithString:[model mj_JSONString] fileName:LOGIN_USER_SESSION];
    }
}

/**返回LoginSessionModel数据 */
-(LoginSessionModel*)loginGetSessionModel{
    NSString *jsonString = [PLFileManager cacheTextWithFileName:LOGIN_USER_SESSION];
    if (jsonString.length <= 0) {
        return nil;
    }
    NSDictionary *dic= [jsonString mj_JSONObject];    
    return [LoginSessionModel mj_objectWithKeyValues:dic];;
}

/**保存登录成功之后LoginUserModel 用户的数据 */
-(void)loginSuccessSaveUserData:(LoginUserModel*)userModel{
    if (userModel != nil) {
        [PLFileManager cacheDefineFileWithString:[userModel mj_JSONString] fileName:USER_LoginUserModel_DATA];
    }
}
-(void)loginRefreshIntegralWithIntegral:(NSInteger)integral{
    LoginUserModel *model = [self loginGetUserModel];
    model.integral = integral;
    [self loginSuccessSaveUserData:model];
}

/**返回 LoginUserModel 数据 */
-(LoginUserModel *)loginGetUserModel{
    
    NSString *jsonString = [PLFileManager cacheTextWithFileName:USER_LoginUserModel_DATA];
    if (jsonString.length <= 0) {
        return nil;
    }
    NSDictionary *dic= [jsonString mj_JSONObject];
    return [LoginUserModel mj_objectWithKeyValues:dic];
}

/**保存登录成功之后 BindModel数组 用户的数据 */
-(void)loginSuccessSaveBindsData:(NSArray<BindModel*>*)binds{
    NSMutableArray *bindsArray = [NSMutableArray arrayWithCapacity:0];
    for (BindModel *model in binds) {
        NSDictionary *dic = [model mj_keyValues];
        [bindsArray addObject:dic];
    }
    NSString *jsonString = @"";
    if (bindsArray != nil) {
        jsonString = [bindsArray mj_JSONString];
    }
    [PLFileManager cacheDefineFileWithString:jsonString fileName:USER_binds_DATA];
}
/**返回 LoginUserModel 数据 */
-(NSArray<BindModel*>*)loginGetBinds{
    
    NSString *jsonString = [PLFileManager cacheTextWithFileName:USER_binds_DATA];
    if (jsonString.length <= 0) {
        return nil;
    }
    NSArray *array= [jsonString mj_JSONObject];
    return [BindModel mj_objectArrayWithKeyValuesArray:array];
}
/**utp数据 */
-(void)loginSuccessSaveUTPData:(LoginType)utp{
    NSString *utpString = [NSString stringWithFormat:@"%@",@(utp)];
    [PLFileManager cacheDefineFileWithString:utpString fileName:USER_utp_DATA];
}
/**sharecode数据 */
-(void)loginSuccessSavesharecodeData:(NSString *_Nullable)sharecode shareName:(NSString*_Nullable)name{
    if (sharecode != nil) {
        NSString *sharecodeString = [NSString stringWithFormat:@"%@",sharecode];
        [PLFileManager cacheDefineFileWithString:sharecodeString fileName:USER_sharecode_DATA];
    }else{
        [PLFileManager cacheDefineFileWithString:nil fileName:USER_sharecode_DATA];
    }
    if (name != nil) {
        NSString *sharenameString = [NSString stringWithFormat:@"%@",name];
        [PLFileManager cacheDefineFileWithString:sharenameString fileName:USER_shareName_DATA];
    }else{
        [PLFileManager cacheDefineFileWithString:nil fileName:USER_shareName_DATA];
    }
}

/**返回 utp 数据 */
-(LoginType)loginGetUtp{
    
    NSString *jsonString = [PLFileManager cacheTextWithFileName:USER_utp_DATA];
    if (jsonString.length <= 0) {
        return LoginTypeAccount;
    }
    return  [jsonString integerValue];
}
/**sharecode数据 */
-(NSString *)loginGetsharecodeData{
    
    NSString *String = [PLFileManager cacheTextWithFileName:USER_sharecode_DATA];
    
    if (String != nil || String.length > 0) {
        return String;
    }
    return nil;
}
/**sharename数据 */
-(NSString *)loginGetshareNameData{
    
    NSString *String = [PLFileManager cacheTextWithFileName:USER_shareName_DATA];
    
    if (String != nil || String.length > 0) {
        return String;
    }
    return nil;
}


//清除数据
-(BOOL)logoutClearUserSessionData{
    //清除用户绑定信息数据
    [PLFileManager deleteDefineCacheWithName:USER_binds_DATA];
    //清除登录session数据
    [PLFileManager deleteDefineCacheWithName:LOGIN_USER_SESSION];
    //清除用户 基础信息数据
    [PLFileManager deleteDefineCacheWithName:USER_LoginUserModel_DATA];
    //清除 邀请人数据
    [PLFileManager deleteDefineCacheWithName:USER_sharecode_DATA];
    [PLFileManager deleteDefineCacheWithName:USER_shareName_DATA];
    //清除签到记录
    [PLHelp delegateFile:@"signHistory"];
    
    //退出登录后发通知，刷新需要登录才能访问的页面，权限等
    [[NSNotificationCenter defaultCenter] postNotificationName:NoticeLogOutSuccess object:nil];
    NSLog(@"退出通知");
    return YES;
}

/**
 清理session数据
 */
-(void)deleteSessionData{
    [PLFileManager deleteDefineCacheWithName:LOGIN_USER_SESSION];
}
-(void)showLoginVCFromVC:(PLBaseViewController*)fatherVC WithBackBlock:(void (^)(BOOL successBack,id modle))block{
    
    PLLoginViewController *login = [[PLLoginViewController alloc] init];
    login.fatherSuperVC = fatherVC;
    KNavigationController *loginNav = [[KNavigationController alloc] initWithRootViewController:login];
    [login setLoginSuccessBlock:^(BOOL success){
        block(success,nil);
    }];
//    login.navigationController.navigationBar.hidden = YES;
    
    if ([fatherVC isKindOfClass:[PLBaseViewController class]]) {
        PLBaseViewController *superVC = (PLBaseViewController*)fatherVC;
        if (superVC.isRootVC == YES) {
            [APPDELEGATE.baseTabBarController presentViewController:loginNav animated:YES completion:^{
            }];
            return;
        }
    }
    [fatherVC.navigationController presentViewController:loginNav animated:YES completion:nil];
}

-(void)loginOutClearDataWithRequestBlock:(void(^)(BOOL success))block{
    //清除数据并发送登出的通知
    NSString * asd = [LOGIN_USER loginGetSessionModel].session_asd;
    if (asd.length<=0) {
        block(YES);
        [LOGIN_USER logoutClearUserSessionData];
        return;
    }
    NetworkParameter *par = [[NetworkParameter alloc] init];
    par.asd = asd;
    [self deleteSessionData];
    //本质上退出登录只要把session_asd的值清空就已经达到了退出的功能
    //但是好意给服务器通知一下，不管服务器返回成功失败都把asd清空以示退出成功
    [NetService POST_NetworkParameter:par url:URL_logincommit_logout successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [LOGIN_USER logoutClearUserSessionData];
        block(YES);
    } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [LOGIN_USER logoutClearUserSessionData];
        block(YES);
    }];
}

-(void)areaCacheArea:(NSDictionary *)area{
    if (area !=nil) {
        NSString *json = [area mj_JSONString];
        [PLFileManager cacheDefineFileWithString:json fileName:CACHE_SELECTED_AREA_KEY];
        [[NSNotificationCenter defaultCenter] postNotificationName:NoticeRefreshLocation object:nil];
    }
}
-(NSDictionary *)areaGetCacheArea{
    NSString *jsonString = [PLFileManager cacheTextWithFileName:CACHE_SELECTED_AREA_KEY];
    NSDictionary *dic = [jsonString JSONValue];
    return dic;

}

-(void)areaCacheAreaAllInfo:(NSDictionary *)area{
    if (area !=nil) {
        NSString *json = [area mj_JSONString];
        [PLFileManager cacheDefineFileWithString:json fileName:CACHE_SELECTED_AREA_alllnfo_KEY];
        [[NSNotificationCenter defaultCenter] postNotificationName:NoticeRefreshLocation object:nil];
    }
}
-(NSDictionary *)areaGetCacheAreaAllInfo{
    NSString *jsonString = [PLFileManager cacheTextWithFileName:CACHE_SELECTED_AREA_alllnfo_KEY];
    NSDictionary *dic = [jsonString JSONValue];
    return dic;
    
}

-(void)deviceTokenSaveKey:(NSString *)deviceToken{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:deviceToken forKey:ZFYAPP_DEVICETOKEN];
    [user synchronize];
}
-(NSString *)deviceTokenGet{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    id token = [user objectForKey:ZFYAPP_DEVICETOKEN];
    if (token) {
        return (NSString*)token;
    }
    return token;
}

@end

