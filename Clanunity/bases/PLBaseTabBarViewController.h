//
//  PLBaseTabBarViewController.h
//  Clanunity
//
//  Created by zfy_srf on 2017/4/1.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatListVC.h"
#import "MyUserInfoVC.h"
@class PLNewsViewController,KNavigationController,PLSocialCommunityViewController,PLMyUserInfoVC;

@interface PLBaseTabBarViewController : UITabBarController<UITabBarDelegate,UITabBarControllerDelegate>
@property(nonatomic,assign) NSInteger lastTabBarIndex;
@property(nonatomic,assign) NSInteger currentTabBarIndex;

@property(nonatomic,strong) KNavigationController *plNewsNavigationViewController;
@property(nonatomic,strong) KNavigationController *nearbyNavigationViewController;
@property (nonatomic,strong)KNavigationController *myNavigationViewController;
@property (nonatomic,strong)KNavigationController *circleNavigationViewController;
@property (nonatomic,strong)KNavigationController *socialCommunityNavigationViewController;

@property (nonatomic,strong)MyUserInfoVC *myViewController;

@property(nonatomic,strong) PLNewsViewController *plNewsViewController;
@property(nonatomic,strong)ChatListVC *SocialCommunityViewController;//社群


//远程通知跳转
-(void)gotoChatVCWithremoteNotification:(NSDictionary *)remoteNotification;
//本地推送跳转
-(void)gotoChatVCWithDictionary:(NSMutableDictionary *)userInfo;
//点击加社群通知跳转社群通知页
-(void)gotoSocialApplyList;
//点击好友聊天信息跳转好友列表
-(void)gotoNewFriendList;
//跳转-活动详情
-(void)gotoActivityInfo:(NSMutableDictionary *)userInfo;
//本地推送跳转方法-新闻资讯详情
-(void)gotoNewsInfo:(NSMutableDictionary *)userInfo;
//本地推送跳转方法-社区公告详情
-(void)gotoShequPunlic:(NSMutableDictionary *)userInfo;
//模态退出前判断当前页面是否是模态退出的页面
-(void)checkBeforePresent;


//退出加登录
-(void)loginSuccessNotification;
//退出
-(void)loginOutSuccessNotification;

//TODO:被动退出登录回调
- (void)userAccountDidLoginFromOtherDevice;

@end
