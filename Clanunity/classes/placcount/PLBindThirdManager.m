//
//  PLBindThirdManager.m
//  Clanunity
//
//  Created by wangyadong on 2017/4/28.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

#import "PLBindThirdManager.h"
#import "WXApi.h"
#import "ThirdResultUserModel.h"

#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/TencentApiInterface.h>




@interface PLBindThirdManager ()<TencentSessionDelegate>

@property(nonatomic,strong)ThirdResultQQModel * userQQModel;
@property(nonatomic,strong)ThirdResultWeChatModel * userWXModel;

/**QQ权限 */
@property (strong, nonatomic) NSArray * qqPermissions;

@property (nonatomic, strong) TencentOAuth * tencentOAuth;

@property(nonatomic,copy)BindResultBlock resultBlock;

@end

static PLBindThirdManager * manager = nil;


@implementation PLBindThirdManager

+(instancetype)bindThirdManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PLBindThirdManager alloc] init];
    });
    return manager;
}
-(void)bindQQResultBlock:(BindResultBlock)block{
    self.resultBlock = block;
    if ([TencentOAuth iphoneQQInstalled]){
        self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:ThirdQQAppId andDelegate:self];
        self.qqPermissions = [NSArray arrayWithObjects:kOPEN_PERMISSION_GET_INFO, kOPEN_PERMISSION_GET_USER_INFO, kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, nil];
        [self.tencentOAuth setAuthShareType:AuthShareType_QQ];
        
        BOOL auth = [self.tencentOAuth authorize:self.qqPermissions localAppId:ThirdQQAppId inSafari:NO];
        NSLog(@"%@",@(auth));
    }else{
        self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:ThirdQQAppId andDelegate:self];
        self.qqPermissions = [NSArray arrayWithObjects:kOPEN_PERMISSION_GET_INFO, kOPEN_PERMISSION_GET_USER_INFO, kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, nil];
        self.resultBlock(2,@{@"msg":@"未安装QQ"});
    }
    
}
#pragma mark -- qq TencentSessionDelegate
-(void)tencentDidLogin{
    if (_tencentOAuth.accessToken.length > 0) {
        // 获取用户信息
        if (![_tencentOAuth getUserInfo]) {
            self.resultBlock(2,nil);
        }
    } else {
        NSLog(@"登录不成功 没有获取accesstoken");
        self.resultBlock(2,nil);
    }
}
-(void)tencentDidNotLogin:(BOOL)cancelled{
    self.resultBlock(2,nil);
}
-(void)tencentDidNotNetWork{
    self.resultBlock(2,nil);
}
-(NSArray *)getAuthorizedPermissions:(NSArray *)permissions withExtraParams:(NSDictionary *)extraParams{
    return self.qqPermissions;
};
/** QQ登录成功拿到用户信息 */
-(void)getUserInfoResponse:(APIResponse *)response{
    NSDictionary *jsonDic = response.jsonResponse;
    self.userQQModel = [[ThirdResultQQModel alloc]initWithDic:jsonDic];
    NSString *openid =  _tencentOAuth.openId;
    self.resultBlock(2,@{@"openid":openid,@"nickname":(self.userQQModel.nickname.length>0?self.userQQModel.nickname:@"")});
}
#pragma mark - 微信绑定
-(void)bindWeiChatResultBlock:(BindResultBlock)block{
    self.resultBlock = block;
    if ([WXApi isWXAppInstalled]) {
        [WXApi registerApp:ThirdWechatAppId];
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"ClanunityApp";
        [WXApi sendReq:req];
    }else{
        self.resultBlock(0,@{@"msg":@"未安装微信"});
    }
    
}
-(void)weChatLoginWithcode:(NSString *)code success:(BOOL)success{
    if (success == NO) {
        self.resultBlock(0,nil);
        return;
    }
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",ThirdWechatAppId,ThirdWechatAppSecret,code];
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *weChatAccess_token = [dic objectForKey:@"access_token"];
            NSString*weChatOpenid = [dic objectForKey:@"openid"];
            if ([weChatAccess_token length] != 0 && [weChatOpenid length] != 0 ) {
                [weakSelf getWecChatUserInfoWithWXAccess_token:weChatAccess_token WXOpenid:weChatOpenid];
            }else{
                weakSelf.resultBlock(0,nil);
            }
        }else{
            //失败
            weakSelf.resultBlock(0,nil);
        }
    });

}
-(void)getWecChatUserInfoWithWXAccess_token:(NSString*)weChatAccess_token WXOpenid:(NSString*)weChatOpenid{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",weChatAccess_token,weChatOpenid];
    NSURL *zoneUrl = [NSURL URLWithString:url];
    NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
    
    if (data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.userWXModel = [[ThirdResultWeChatModel alloc] initWithDic:dic];
        self.resultBlock(0,@{@"openid":weChatOpenid,@"nickname":(self.userWXModel.nickname.length>0?self.userWXModel.nickname:@"")});
        
    }else{
        self.resultBlock(0,nil);
    }
    
}


@end
