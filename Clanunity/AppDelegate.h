//
//  AppDelegate.h
//  Clanunity
//
//  Created by zfy_srf on 2017/4/1.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "PLBaseTabBarViewController.h"
#import "PlEnumHeader.h"

//#import <TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
//#import <TencentOpenAPI/TencentOAuth.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>
{
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) PLBaseTabBarViewController *baseTabBarController;
@property (strong, nonatomic) NSMutableDictionary *remoteNotification;
@property (strong, nonatomic) NSData *deviceToken;

/**当前网络状态 */ //0无网络 1流量 2无线
@property(nonatomic,assign)NSInteger networkStatus;

/**微信登录1，微信绑定是2 */
@property(nonatomic,assign)NSInteger wxlogintype;



//TODO:------------环信调用-白尔雪>>>>>>>>>------
+(BOOL) runningInBackground;
+(BOOL) runningInForeground;

//判断环信是否登录
-(void)checkIfHuanxinIsLoginreturnBlock:(void(^)(NSInteger statue))returnBlock;
//环信直接登录
-(void)huanxinLogin;
-(UIViewController*) currentViewController;

/**分享到qq，在PLShareGlobalView中无法调起qq，只能在这里，此bug有待解决 */
- (void)shareToQQWithShareType:(ShareThirdType)shareType shareObjc:(QQApiObject *)shareObjc;

@end

