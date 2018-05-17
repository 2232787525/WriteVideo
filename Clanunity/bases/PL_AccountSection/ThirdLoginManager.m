//
//  ThirdLoginManager.m
//  PlamLive
//
//  Created by wangyadong on 2016/11/23.
//  Copyright © 2016年 wangyadong. All rights reserved.
//
/*
 第三方登录
 1先获取关键操作，拿到appkey
 2拿到appkey之后，去第三方登录
 3第三方登录成功拿到openid(有的还拿到用户的所有信息),那这个openid给我们自己的服务器第三方登录校验。
 4.自己的服务器校验openid，如果是首次就要再调用上传用户信息的接口获取asd=apptopken。如果已经不是首次使用第三方登录那么就可以获取到用户信息，已经asd=apptoken
 5.拿到asd=apptoken之后就登录成功了
 */

#import "ThirdLoginManager.h"
#import "DeviceIdentifier.h"

#import "ThirdResultUserModel.h"
#import "WXApi.h"

#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/TencentApiInterface.h>

@interface ThirdLoginManager ()<TencentSessionDelegate>

/**QQ权限 */
@property (strong, nonatomic) NSArray * qqPermissions;

@property (nonatomic, strong) TencentOAuth * tencentOAuth;

@property(nonatomic,copy)ThirdLoginFailedBlock failedBlock;

@property(nonatomic,copy)ThirdLoginSuccessBlock successBlock;


@property(nonatomic,copy)NSString * importAppkey;

@property(nonatomic,strong)ThirdResultQQModel * userQQModel;
@property(nonatomic,strong)ThirdResultWeChatModel * userWXModel;


@end

static ThirdLoginManager * manager = nil;


@implementation ThirdLoginManager

+(instancetype)thirdLoginManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ThirdLoginManager alloc] init];
    });
    return manager;
}
#pragma mark - qq第三方登录
-(void)thirdLoginForQQWithSuccess:(ThirdLoginSuccessBlock)success failed:(ThirdLoginFailedBlock)failed{
    self.successBlock = success;
    self.failedBlock = failed;
    __weak typeof(self)weakSelf = self;
    
    if ([TencentOAuth iphoneQQInstalled]){
        weakSelf.tencentOAuth = [[TencentOAuth alloc] initWithAppId:ThirdQQAppId andDelegate:weakSelf];
        weakSelf.qqPermissions = [NSArray arrayWithObjects:kOPEN_PERMISSION_GET_INFO, kOPEN_PERMISSION_GET_USER_INFO, kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, nil];
        [weakSelf.tencentOAuth setAuthShareType:AuthShareType_QQ];
        
        BOOL auth = [weakSelf.tencentOAuth authorize:weakSelf.qqPermissions localAppId:ThirdQQAppId inSafari:NO];
        NSLog(@"qq第三方调起  %@",@(auth));
        
    }else{
        weakSelf.tencentOAuth = [[TencentOAuth alloc] initWithAppId:ThirdQQAppId andDelegate:weakSelf];
        weakSelf.qqPermissions = [NSArray arrayWithObjects:kOPEN_PERMISSION_GET_INFO, kOPEN_PERMISSION_GET_USER_INFO, kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, nil];
        weakSelf.failedBlock(LoginTypeQQ,@"未安装QQ",@"您的手机未安装QQ");
    }
}
#pragma mark -- qq TencentSessionDelegate
-(void)tencentDidLogin{
    if (_tencentOAuth.accessToken.length > 0) {
        // 获取用户信息
        if (![_tencentOAuth getUserInfo]) {
            self.failedBlock(LoginTypeQQ,@"获取信息失败",@"");
        }
    } else {
        NSLog(@"登录不成功 没有获取accesstoken");
        self.failedBlock(LoginTypeQQ,@"登录失败",nil);
    }
}
-(void)tencentDidNotLogin:(BOOL)cancelled{
    self.failedBlock(LoginTypeQQ,@"登录取消",nil);
}
-(void)tencentDidNotNetWork{
    self.failedBlock(LoginTypeQQ,@"网络",nil);
}
-(NSArray *)getAuthorizedPermissions:(NSArray *)permissions withExtraParams:(NSDictionary *)extraParams{
    return self.qqPermissions;
};
/** QQ登录成功拿到用户信息 */
-(void)getUserInfoResponse:(APIResponse *)response{
    NSDictionary *jsonDicE = response.jsonResponse;
    WeakSelf;
    [self thirdLoginWithOpenid:_tencentOAuth.openId utp:LoginTypeQQ withReturn:^(NSDictionary *result) {
        
        if (result == nil) {
            weakSelf.failedBlock(LoginTypeQQ,@"网络获取失败",nil);
        }else{
            NSNumber *code = result[@"code"];
            if ([code integerValue] == 100) {
                //登录成功
                weakSelf.successBlock(LoginTypeQQ, @"直接登录成功", result);
            }else{
                
                NSDictionary *jsonDic = response.jsonResponse;
                ThirdResultQQModel*model = [ThirdResultQQModel mj_objectWithKeyValues:jsonDic];
                NSDictionary *result = @{@"code":code,
                                         @"openid":weakSelf.tencentOAuth.openId,
                                         @"headimgurl":model.figureurl_qq_2,
                                         @"nickname":model.nickname,
                                         @"sex":([model.gender isEqualToString:@"男"]?@"1":@"0"),
                                         @"utp":@(LoginTypeQQ)
                                         };
                weakSelf.successBlock(LoginTypeQQ, @"登录成功",result);
            }
        }
        
    }];
}


#pragma mark - WeiChat第三方登录
-(void)thirdLoginForWeChatSuccess:(ThirdLoginSuccessBlock)success failed:(ThirdLoginFailedBlock)failed{
    self.successBlock = success;
    self.failedBlock = failed;
    __weak typeof(self)weakSelf = self;
    if ([WXApi isWXAppInstalled]) {
        [WXApi registerApp:ThirdWechatAppId];
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"ClanunityApp";
        [WXApi sendReq:req];
    }else{
        weakSelf.failedBlock(LoginTypeWechat,@"未安装微信",@"您的手机未安装微信");
    }
}
/**Appdeligate微信回调回来 触发的方法 */
-(void)weChatLoginWithcode:(NSString *)code success:(BOOL)success{
    if (success == NO) {
        self.failedBlock(LoginTypeWechat,@"微信登录失败",@"");
        return;
    }
    WeakSelf;
    [self getWeChatAccess_tokenAndOpenIdWithCode:code withReturn:^(NSString *access_Token, NSString *openid) {
        if (access_Token != nil&&openid != nil) {
            [weakSelf getWecChatUserInfoWithWXAccess_token:access_Token WXOpenid:openid withReturn:^(NSDictionary *result) {
                if (result == nil) {
                    weakSelf.failedBlock(LoginTypeWechat,@"信息解析失败",@"");
                }else{
                    ThirdResultWeChatModel *modle = [ThirdResultWeChatModel mj_objectWithKeyValues:result];
                    [weakSelf thirdLoginWithOpenid:openid utp:LoginTypeWechat withReturn:^(NSDictionary *result) {
                        if (result == nil) {
                            weakSelf.failedBlock(LoginTypeWechat,@"网络获取失败",@"");
                        }else{
                            NSNumber *code = result[@"code"];
                            
                            if ([code integerValue] == 100) {
                                //登录成功
                                weakSelf.successBlock(LoginTypeWechat, @"直接登录成功", result);
                            }else{
                                NSDictionary *result = @{@"code":code,
                                                         @"openid":modle.openid,
                                                         @"headimgurl":modle.headimgurl,
                                                         @"nickname":modle.nickname,
                                                         @"sex":[NSString stringWithFormat:@"%@",@(modle.sex)],
                                                         @"utp":@(LoginTypeWechat)
                                                         };
                                weakSelf.successBlock(LoginTypeWechat, @"",result);
                            }
                            
                        }
                    }];
                }
            }];
        }else{
            weakSelf.failedBlock(LoginTypeWechat,@"Access_token未获取到",@"");
        }
    }];
    
}

/** 使用access_token 和 openid 获取 微信用户数据 */
-(void)getWecChatUserInfoWithWXAccess_token:(NSString*)weChatAccess_token WXOpenid:(NSString*)weChatOpenid withReturn:(void(^)(NSDictionary*result))block{
    //使用access_token 和 openid 获取 微信用户数据
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",weChatAccess_token,weChatOpenid];
    __weak typeof(self)weakSelf = self;
    NSURL *zoneUrl = [NSURL URLWithString:url];
    NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        block(dic);
        weakSelf.userWXModel = [[ThirdResultWeChatModel alloc] initWithDic:dic];
        
    }else{
        block(nil);
    }
    
}

/** 拿到code，加上AppId，AppSecret配置这个url
    获取access_token 和 openId
 */
-(void)getWeChatAccess_tokenAndOpenIdWithCode:(NSString*)code withReturn:(void(^)(NSString*access_Token,NSString*openid))block{
    //拿到code，加上AppId，AppSecret配置这个url
    //获取access_token 和 openId
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",ThirdWechatAppId,ThirdWechatAppSecret,code];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *weChatAccess_token = [dic objectForKey:@"access_token"];
            NSString*weChatOpenid = [dic objectForKey:@"openid"];
            if ([weChatAccess_token length] != 0 && [weChatOpenid length] != 0 ) {
                block(weChatAccess_token,weChatOpenid);
            }else{
                block(nil,nil);
            }
        }
        else{
            block(nil,nil);
        }
    });
    
}
/**传openid调用接口--判断此openid是否可以直接登录 */
-(void)thirdLoginWithOpenid:(NSString*)openid utp:(LoginType)utp withReturn:(void(^)(NSDictionary*result))block{
    
    [PLHelp appkeyRequestReturn:^(NSString *appkey) {
        if (appkey==nil) {
            block(nil);
            return ;
        }
        NSString *ts =[PLHelp timestamp];
        NetworkParameter *par = [[NetworkParameter alloc] init];
        par.ts = ts;
        par.appkey = appkey;
        par.appsign = [PLHelp appsignGenerateWithAppkey:appkey timestamp:ts];
        par.parameter = @{@"opdi":openid,@"utp":@(utp)};
        [NetService POST_NetworkParameter:par url:URL_thirdlogin_validateOpenid successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *resDic = (NSDictionary*)responseObject;
            NSNumber *code = resDic[@"code"];
            NSDictionary *data = resDic[@"data"];
            if ([code integerValue] == 100) {
                //可以直接登录
                NSDictionary *sessionDic = [ResponseHelp getAsdApptokenCookeWithResponse:(NSHTTPURLResponse*)task.response];
                NSDictionary *result = @{@"session":sessionDic,@"data":data,@"code":code};
                block(result);
            }else{
                //需要绑定
                NSDictionary *result = @{@"code":code,@"data":data};
                block(result);
            }
        } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            block(nil);
        }];
    }];


}

#pragma mark - 第三方登录成后上传请求openID，类型
-(void)requestForQQPerfectUserInfoWithAsd:(NSString*)asdString{
    
    NSDictionary *pardic = @{
                             @"headimg":(self.userQQModel.figureurl_qq_2.length>0?self.userQQModel.figureurl_qq_2:@""),
                             @"nickname":(self.userQQModel.nickname.length>0?self.userQQModel.nickname:@""),
                             @"gender":(self.userQQModel.gender.length>0?self.userQQModel.gender:@""),
                             @"province":(self.userQQModel.province.length>0?self.userQQModel.province:@""),
                             @"city":(self.userQQModel.city.length?self.userQQModel.city:@"")};
    NetworkParameter *parModel = [[NetworkParameter alloc] init];
    parModel.parameter = pardic;
    parModel.asd = asdString;
    [NetService POST_NetworkParameter:parModel url:@"/ysjapp/v0909/account/addthirduser" successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"status"] isEqualToString:@"OK"]) {
                NSLog(@"完善信息成功");
            }
        }
    } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"完善信息失败 errorCode = %@",@(error.code));
        
    }];
    
}
-(void)requestForWeChatPerfectUserInfoWithAsd:(NSString*)asdString{
    NSString *headimg =self.userWXModel.headimgurl.length>0?self.userWXModel.headimgurl:@"";
    NSString *nickname = self.userWXModel.nickname.length >0?self.userWXModel.nickname:@"";
    NSString *province =(self.userWXModel.province.length>0?self.userWXModel.province:@"");
    NSString *city =(self.userWXModel.city.length?self.userWXModel.city:@"");
    NSString *gender =self.userWXModel.sex>0?[NSString stringWithFormat:@"%@",@(self.userWXModel.sex)]:@"";
    NSDictionary *pardic = @{
                             @"headimg":headimg,
                             @"nickname":nickname,
                             @"gender":gender,
                             @"province":province,
                             @"city":city};
    NetworkParameter *parModel = [[NetworkParameter alloc] init];
    parModel.parameter = pardic;
    parModel.asd = [LOGIN_USER loginGetSessionModel].session_asd;
    [NetService POST_NetworkParameter:parModel url:@"/ysjapp/v0909/account/addthirduser" successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"status"] isEqualToString:@"OK"]) {
                NSLog(@"完善信息成功");
            }
        }
    } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"完善信息失败 errorCode = %@",@(error.code));
    }];
}
@end
