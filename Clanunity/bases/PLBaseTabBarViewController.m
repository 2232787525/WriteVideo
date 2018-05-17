//
//  PLBaseTabBarViewController.m
//  Clanunity
//  Dev::songruifeng
//  Created by zfy_srf on 2017/4/1.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

#import "PLBaseTabBarViewController.h"
#import "KNavigationController.h"
#import "PLNewsViewController.h"
#import "PLDetailsVC.h"

@interface PLBaseTabBarViewController ()



@end

@implementation PLBaseTabBarViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self becomeFirstResponder];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self setDelegate:self];

    if ([self.tabBar respondsToSelector:@selector(setTintColor:)]) {
        self.tabBar.tintColor = [UIColor PLColorContentBack];
    }
    //取消tabBar的透明效果
    [UITabBar appearance].translucent = NO;
    [self cinfigTabbar];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(plVersionUpdate) name:@"PLVersionUpdate" object:nil];
    
    
    [self userNotificationSettings];
    [self registAccountStateNotification];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
  
}

-(void)userNotificationSettings{
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (UIUserNotificationTypeNone != setting.types) {
        NSLog(@"打开了");
    }else{
        //当前日期yyyy-MM-dd
        NSString *keyDate = [PLHelp timestampYMD:[PLHelp timestamp]];
        //当前日期是周几
        NSString *week = [PLHelp timestampWeekDayWithYMD:keyDate];
        //约定周六，可以弹出提示
        if ([week isEqualToString:@"周六"]) {
            //判断今天是否弹过提示
            id checkStatus = [[NSUserDefaults standardUserDefaults] objectForKey:@"NoticeSetSunDay"];//获取上次弹出提示的时间
            if (checkStatus != nil && [checkStatus isEqualToString:keyDate]) {//如果跟当前日期一样，说明当天已经弹过，无须再弹
                return;
            }
            //没有弹出提示，周六当天首次弹
            [PLGlobalClass aletWithTitle:@"\"掌方圆\"想给您发送通知" Message:@"\"通知\"可能包括提醒、声音和图标标记。现在去\"设置\"中开启通知？" sureTitle:@"去开启" CancelTitle:@"取消" SureBlock:^{
                //去设置
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            } andCancelBlock:^{
            } andDelegate:self];
            //已弹提示把当前日期保存
            [[NSUserDefaults standardUserDefaults] setObject:keyDate forKey:@"NoticeSetSunDay"];
        }
    }
}



#pragma mark -  登录登出的通知
-(void)registAccountStateNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginSuccessNotification) name:NoticeLoginSuccess object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginOutSuccessNotification) name:NoticeLogOutSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registSuccessNotification) name:NoticeRegistUserSuccess object:nil];
}

-(void)loginSuccessNotification{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
    });
}

-(void)loginOutSuccessNotification{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    });
}

-(void)registSuccessNotification
{}



//TODO:被动退出登录回调
- (void)userAccountDidLoginFromOtherDevice;{
    NSLog(@"被动退出登录回调");
    //账号被踢
    UIAlertView * alertView  = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您的账号在其他设备登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    
    [alertView show];
}

#pragma mark - tabbar控制器设置
-(void)cinfigTabbar{
    _plNewsViewController = [[PLNewsViewController alloc] init];
    _plNewsViewController.isRootVC = YES;
    _plNewsNavigationViewController = [[KNavigationController alloc] initWithRootViewController:_plNewsViewController];

    ChatListVC *chatListVC = [[ChatListVC alloc]init];
//    _SocialCommunityViewController.isRootVC = YES;
    _socialCommunityNavigationViewController = [[KNavigationController alloc]initWithRootViewController:chatListVC];
    
    _myViewController = [[MyUserInfoVC alloc]init];
    _myViewController.isRootVC = YES;
    _myNavigationViewController = [[KNavigationController alloc]initWithRootViewController:_myViewController];
    
    NSArray *viewControllers = [NSArray arrayWithObjects:_plNewsNavigationViewController,_socialCommunityNavigationViewController,_myNavigationViewController, nil];
    [self setViewControllers:viewControllers];

    for (int i = 0; i < [self.tabBar.items count]; i++) {
        UITabBarItem *item = self.tabBar.items[i];
        item.tag = 12306+i;
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor plTabBarSelected],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor plTabBarUnSelected],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont PLFont12],NSFontAttributeName, nil] forState:UIControlStateNormal];

        switch (i) {
            case 0:{
                [item setImage:[[UIImage imageNamed:@"homeIcon_n"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                [item setSelectedImage:[[UIImage imageNamed:@"homeIcon_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                [item setTitle:@"首页"];
            }
                break;
            case 1:{
                [item setImage:[[UIImage imageNamed:@"circleIcon_n"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                [item setSelectedImage:[[UIImage imageNamed:@"circleIcon_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                [item setTitle:@"社群"];
            }
                break;
            case 2:{
                [item setImage:[[UIImage imageNamed:@"myIcon_n"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                [item setSelectedImage:[[UIImage imageNamed:@"myIcon_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                [item setTitle:@"我"];
            }
                break;
        }
    }
    self.selectedIndex = 0;
    self.tabBar.backgroundImage = [UIImage imageWithColor:[UIColor whiteColor]];
    
    [self.tabBar setShadowImage:[UIImage imageWithColor:[UIColor PLColorDFDFDF_Cutline]]];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//没有登录时的弹框和相应处理
-(void)notLoginAlterShow{
    WeakSelf
    PLBaseViewController *vc = (PLBaseViewController *)[APPDELEGATE currentViewController];
    [PLGlobalClass aletWithTitle:@"温馨提示" Message:@"您还未登录,请您先登录！" sureTitle:@"确定" CancelTitle:@"取消" SureBlock:^{
        [LOGIN_USER showLoginVCFromVC:vc WithBackBlock:^(BOOL successBack, id modle) {
        }];
    } andCancelBlock:^{
    } andDelegate:weakSelf];
}

@end
