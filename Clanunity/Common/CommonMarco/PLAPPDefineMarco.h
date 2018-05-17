//
//  PLAPPDefineMarco.h
//  Clanunity
//
//  Created by wangyadong on 2017/6/6.
//  Copyright © 2017年 duolaimi. All rights reserved.
//

#ifndef PLAPPDefineMarco_h
#define PLAPPDefineMarco_h

#define WeakSelf __weak typeof(self) weakSelf = self;

#define APPDELEGATE ((AppDelegate*)[[UIApplication sharedApplication] delegate])


// --适配公式
#define F_I6(f)   ((f)* KScreenWidth/375.0)*1.0 

////开发的时候打印，但是发布的时候不打印的NSLog
#ifdef DEBUG
//#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
//#define NSLog(...)
#endif


#define NoLoginAlter [PLGlobalClass aletWithTitle:@"温馨提示" Message:@"您还未登录,请您先登录！" sureTitle:@"确定" CancelTitle:@"取消" SureBlock:^{\
[LOGIN_USER showLoginVCFromVC:weakSelf WithBackBlock:^(BOOL successBack, id modle) {\
}];\
} andCancelBlock:^{\
} andDelegate:weakSelf];\
EMError *error = [[EMClient sharedClient] logout:YES];\
if (!error) {\
    NSLog(@"退出成功");\
}


//-------------------获取设备大小-------------------------
// 动态获取屏幕宽高
#define KScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define KScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define KIPHONE_X   ([[UIScreen mainScreen] bounds].size.height == 812 ? YES : NO)

#define kScreenScale KScreenWidth/375.0

// NavBar高度
#define KNavigationBarHeight (44.0)
// 状态栏高度
#define KStatusBarHeight (KIPHONE_X == YES ? 44.0 : 20.0)
// 顶部高度
#define KTopHeight (KNavigationBarHeight + KStatusBarHeight)

// 底部 TabBar 高度
#define KTabBarHeight (49.0)
//底部虚拟状态高
#define KBottomStatusH (KIPHONE_X == YES ? 34.0 : 0.0)
//底部高
#define KBottomHeight (KTabBarHeight + KBottomStatusH)


// -----------获取系统信息----------------------
#define IOS11           ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 11.0)
#define IOS10           ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0)
#define IOS9            ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 9.0)
#define IOS8            ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)

#define IS_IOS11 (@available(iOS 11.0, *))

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]


/*****  根据屏幕尺寸判断retina和iPhone5 *****/
#define is3_5inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define is4inch_retina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define is4_7inch_retina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define is5_5inch_retina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


//---------沙盒路径-------------

#define DOCUMENT_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//------------------其他相关配置------------------

#define KNavigationBarTitleFont 16
#define KNavigationBarItemTitleFont 13
#define kNavigationBarColor     KColorFromRGB(0x4F93FC)
#define kNavigationBarLineColor [UIColor colorWithWhite:0.869 alpha:1]
#define kNavigationBarTintColor [UIColor whiteColor]


//----------通用按钮相关配置-----------
#define MainBtnUColor   KColorFromRGB(0x4F93FC)
#define MainBtnColor    KColorFromRGB(0x4F93FC)

#define KColorRGBA(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]
#define KColorRGB(r, g, b) KColorRGBA(r, g, b, 1.f)

#define KColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


// ------------------- 自定义LOG---------


#ifdef DEBUG
#define MyLog(format, ...)                     do {                                                                          \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n") ;                                          \
} while (0)
#else

#define MyLog(format, ...)

#endif

//--------- 判断是否是空字符串 非空字符串 ＝ yes ------


#define  NOEmptyStr(string)  string == nil ||[string isEqualToString: @""] || string == NULL ||[string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 ? NO : YES


#define  IsEmptyStr(string) string == nil || string == NULL || [string isEqualToString:@""] ||[string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 ? YES : NO



//TODO:友盟统计事件埋点方法
#define single_event(_eventName_) [MobClick event:_eventName_];
#define event(_enentName_,_dic_)  [MobClick event:_enentName_ attributes:_dic_];


#endif /* PLAPPDefineMarco_h */
