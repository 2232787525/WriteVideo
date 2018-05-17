//
//  AppDelegate.m
//  Clanunity
//
//  Created by zfy_srf on 2017/4/1.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

#import "AppDelegate.h"
#import "ThirdLoginManager.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>

#import <UserNotifications/UserNotifications.h>
#import "UMessage.h"//友盟推送
#import "IQKeyboardManager.h"
#import "DeviceIdentifier.h"
#import "PLBindThirdManager.h"
#import "KNavigationController.h"
#import "XHlaunchAdManager.h"

extern CFAbsoluteTime StartTime;

@interface AppDelegate ()<UNUserNotificationCenterDelegate,UIAlertViewDelegate,UNUserNotificationCenterDelegate>
{
}
@end

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    NSLog(@"willFinishLaunchingWithOptions===> %@",launchOptions);
    [self appConfigThirdSDKWithOptions:launchOptions];
    [NetService AppSignPostforappsecretFresh:NO];
    [XHlaunchAdManager shareManager];

    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch
    UIWindow * window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
   
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    //这个判断是在程序没有运行的情况下收到通知，点击通知跳转页面
    if (launchOptions) {
        NSDictionary * remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (remoteNotification) {
            self.remoteNotification=(NSMutableDictionary *)remoteNotification;
        }
    }

    //应用内展示通知 代理设置
    UNUserNotificationCenter *center=[UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    
    self.baseTabBarController = [[PLBaseTabBarViewController alloc] init];
    self.window.rootViewController = self.baseTabBarController;

    [self configureNetworkStatus];
    
    [self.window makeKeyAndVisible];
    
    //友盟推送 适配Https
    [UMessage startWithAppkey:UMAppKey launchOptions:launchOptions httpsEnable:YES];
    [UMessage registerForRemoteNotifications];
    
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }}];
    
    double launchTime = CFAbsoluteTimeGetCurrent() - StartTime;
    NSLog(@"--->>>>%f",launchTime);
    return YES;
}
 
#pragma mark - 配置 监测网络状态的改变
- (void)configureNetworkStatus{

    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];//开始监视
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (self.networkStatus == status) {
            return ;
        }
        [NetService AppSignPostforappsecretFresh:NO];
        //网络状态的改变发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:NoticeNetworkReachabilityStauts object:nil userInfo:@{NoticeNetworkReachabilityStauts:[NSNumber numberWithInteger:status]}];
        self.networkStatus = status;
        if (status == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"未连接到网络，请检查您的网络设置" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [alert show];
        }
        switch (status) {
            case -1:
                NSLog(@"未知网络状态");//-1
                break;
            case 0:
                NSLog(@"无网络");//0
                break;
            case 1:
                NSLog(@"蜂窝数据网");//1
                break;
            case 2:
                NSLog(@"WiFi网络");//2
                break;
            default:
                break;
        
        }
    }] ;
}

#pragma mark - 配置注册第三方sdk
-(void)appConfigThirdSDKWithOptions:(NSDictionary *)launchOptions{
   
    //注册微信id
    [WXApi registerApp:ThirdWechatAppId];
    
    IQKeyboardManager *iqManager = [IQKeyboardManager sharedManager];
    iqManager.enable = YES;
    iqManager.overrideKeyboardAppearance = YES;
    iqManager.shouldResignOnTouchOutside = YES;//点击屏幕隐藏键盘
    iqManager.enableAutoToolbar = NO;//工具栏
    iqManager.keyboardDistanceFromTextField = 0;//当你的输入框被键盘覆盖后页面会自动上移,上移的距离
    
    [UMessage setLogEnabled:YES];//打开日志，方便调试
    [UMessage openDebugMode:YES];
    
    UMConfigInstance.appKey = UMAppKey;
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后
    [MobClick setLogEnabled: YES];
}

#pragma mark --  wxApiDelegate
/**
 *如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。
 *sendReq请求调用后，会切到微信终端程序界面。
 */
-(void) onResp:(BaseResp*)resp
{
    if ([resp isKindOfClass:[SendAuthResp class]]) {   //授权登录的类。
        if (resp.errCode == 0) {  //成功。
            //这里处理回调的方法。通过代理吧对应的登录消息传送过去。
            SendAuthResp *resp2 = (SendAuthResp *)resp;
            if (self.wxlogintype == 1) {
                [[ThirdLoginManager thirdLoginManager]weChatLoginWithcode:resp2.code success:YES];

            }else if (self.wxlogintype == 2){
                [[PLBindThirdManager bindThirdManager]weChatLoginWithcode:resp2.code success:YES];
            }
        }else{ //失败
            if (self.wxlogintype == 1) {
                [[ThirdLoginManager thirdLoginManager]weChatLoginWithcode:[NSString stringWithFormat:@"%d",resp.errCode] success:NO];
            }else if (self.wxlogintype == 2){
                [[PLBindThirdManager bindThirdManager]weChatLoginWithcode:[NSString stringWithFormat:@"%d",resp.errCode] success:NO];
            }
        }
    }
    else if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功");
                [[NSNotificationCenter defaultCenter]postNotificationName:@"PL_PROPERTY_PAY_END" object:@{@"paystatus":@"OK"}];
                break;
            default:
                NSLog(@"支付失败，retcode=%d",resp.errCode);
                [[NSNotificationCenter defaultCenter]postNotificationName:@"PL_PROPERTY_PAY_END" object:@{@"paystatus":@"ERROR"}];
                break;
        }
    }
}

//重写handleOpenURL和openURL方法
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSString *urlCodeString = [NSString stringWithFormat:@"%@",url];
    NSString *wx = [urlCodeString substringToIndex:18];
    NSString *tencentqq = [urlCodeString substringToIndex:17];
    if ([tencentqq isEqualToString:@"tencent1105941612"]) {
        return [TencentOAuth HandleOpenURL:url];
    }else
        if ([wx isEqualToString:@"wx1ffe4d2f525456b1"]){
            return [WXApi handleOpenURL:url delegate:self];
        }
    return YES;
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation
{
    NSString *urlCodeString = [NSString stringWithFormat:@"%@",url];
    NSString *wx = [urlCodeString substringToIndex:18];
    NSString *tencentqq = [urlCodeString substringToIndex:17];
    if ([tencentqq isEqualToString:@"tencent1105941612"]) {
        return [TencentOAuth HandleOpenURL:url];
    }else
        if ([wx isEqualToString:@"wx1ffe4d2f525456b1"]){
            return [WXApi handleOpenURL:url delegate:self];
        }
    return YES;
}
#ifdef IOS9
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    NSString *urlCodeString = [NSString stringWithFormat:@"%@",url];
    NSString *wx = [urlCodeString substringToIndex:18];
    NSString *tencentqq = [urlCodeString substringToIndex:17];
    if ([tencentqq isEqualToString:@"tencent1105941612"]) {
        return [TencentOAuth HandleOpenURL:url];
    }else
    if ([wx isEqualToString:@"wx1ffe4d2f525456b1"]){
        return [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}
#endif

#pragma mark -  AppDelegate

//启动基本完成程序准备开始运行
- (void)applicationWillResignActive:(UIApplication *)application {
}

// 当应用程序进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
}

//当程序从后台将要重新回到前台时候调用
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"PLVersionUpdate" object:nil];
}

#pragma mark - 通知
//iOS10新增：处理前台收到通知的代理方法
//(捕捉PLChatHelper里的showNotificationWithMessage发的通知并显示)
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    NSDictionary *userInfo = notification.request.content.userInfo;
    if ([userInfo.allKeys containsObject:@"msgbody"]) {
        if ([[userInfo objectForKey:@"msgbody"] integerValue] ==21) {//账号被顶下去
            UIAlertView * alertView  = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您的账号在其他设备登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }
    }
    //友盟
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
        //应用处于前台时的本地推送接受
    }
}

//iOS10新增：点击通知的代理方法

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{

    NSMutableDictionary * userInfo = (NSMutableDictionary *)response.notification.request.content.userInfo;

    if(!self.remoteNotification){
        //跳转弹窗等操作
        if ([userInfo.allKeys containsObject:@"msgbody"]) {
            if ([[userInfo objectForKey:@"msgbody"] integerValue] ==21) {
                //账号被踢
                [self.baseTabBarController userAccountDidLoginFromOtherDevice];
                
            }
        }
        //completionHandler();
        //友盟
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            //应用处于后台时的远程推送接受 //必须加这句代码
            [UMessage didReceiveRemoteNotification:userInfo];
        }else{
            //应用处于后台时的本地推送接受
        }
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [UIApplication sharedApplication].applicationIconBadgeNumber ++;
}

#pragma mark - alertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex ==0) {
       [LOGIN_USER loginOutClearDataWithRequestBlock:^(BOOL success) {
       }];
    }
}

//TODO:前台后台判定
+(BOOL) runningInBackground
{
    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    BOOL result = (state == UIApplicationStateBackground);
    
    return result;
}
+(BOOL) runningInForeground
{
    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    BOOL result = (state == UIApplicationStateActive);
    
    return result;
}

//TODO:获取当前页面
-(UIViewController*) currentViewController {
    
    // Find best view controller
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self findBestViewController:viewController];
}
-(UIViewController*) findBestViewController:(UIViewController*)vc {
    
    if (vc.presentedViewController) {
        // Return presented view controller
        return [self findBestViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}

/**分享到qq，在PLShareGlobalView中无法调起qq，只能在这里，此bug有待解决 */
- (void)shareToQQWithShareType:(ShareThirdType)shareType shareObjc:(QQApiObject *)shareObjc{
    TencentOAuth *auth =[[TencentOAuth alloc] initWithAppId:ThirdQQAppId andDelegate:nil];
    NSLog(@"%@",auth);
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:shareObjc];
    if (shareType == ShareThirdTypeQQ) {
        [QQApiInterface sendReq:req];
    }else if (shareType == ShareThirdTypeQQZone){
        [QQApiInterface SendReqToQZone:req];
    }
}


@end
