//
//  UIColor+PLColor.h
//  PlamLive
//
//  Created by wangyadong on 2016/10/21.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]


@interface UIColor (PLColor)

#pragma mark - Hex Color
+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*) colorWithHex:(NSInteger)hexValue;
+ (NSString *) hexFromUIColor: (UIColor*) color;



#pragma mark - PLColor
+(UIColor*)KNavigationBarTintColor;
+(UIColor*)KNavigationBarColor;
+(UIColor*)plNavBarBackColorWithAlpha:(CGFloat)alph;
+(UIColor*)plBackGroundColor;

/**
 tabbar非选中状态
 */
+(UIColor*)plTabBarUnSelected;

/**
 tabbar选中的状态
 */
+(UIColor*)plTabBarSelected;

+(UIColor*)plTabBarBackColor;

+(UIColor*)plTabbarToplineColor;

/**
 分割线线颜色
 */
+(UIColor *)plLineColor;


/**
 *   标题 深色232323
 */
+(UIColor*)plDarkTitleColor;

/**
 标题 浅色a0a0a0

 @return <#return value description#>
 */
+(UIColor*)plLightTitleColor;

/**
 简介，内容，小标题 ，点赞数 颜色959595

 @return <#return value description#>
 */
+(UIColor*)plLightInfoColor;

/**
 公众号字体颜色cbc9c9

 @return <#return value description#>
 */
+(UIColor*)plLightColor;

+(UIColor*)plCellSelectedColor;

/**
 蓝色
 */
+(UIColor*)plBlueColorWithAlph:(CGFloat)alph;
+(UIColor*)plNavTitleColor;
/*
 滑条颜色464c56
 */
+(UIColor*)plSliderDarkColor;
/**
 黄色颜色
 */
+(UIColor*)plYellowcolor;


/**
 主字体颜色 #343434深色
 */
+(UIColor*)colorThemeTitleColor;

/**
 橘色
 */
+(UIColor*)color1Orange;

/**
 蓝色 按钮字体颜色 “完成”“登录”

 @return <#return value description#>
 */
+(UIColor*)color2blue;

/**
 <#Description#>

 @return <#return value description#>
 */
+(UIColor*)color3blue;

/**
 主要黄色  获取验证码

 @return <#return value description#>
 */
+(UIColor*)color4yellow;

/**
 字体颜色 黑色 343434
 */
+(UIColor*)textColor1;

/**
 * 蓝色 409cfb
 */
+(UIColor*)blueColor1;
/**
 *409cfd
 */
+(UIColor*)PLColorBlue;

/**
 *343434
 */
+(UIColor*)PLColorBlack;

/**
 ffe700
 */
+(UIColor*)PLColorYellow;

/**
 ff0000
 */
+(UIColor*)PLColorRed;

/**
面议 红色 #f75252
 */
+(UIColor*)PLColorPinkRed;


/**
 * 用于普通段落信息 999999
 * 如导咨询内容简介，动态内容简介，链接等
 */
+(UIColor*)PLColorGrayDark;

/**
 用于辅助，次要信息显示 cdcdcd
 */
+(UIColor*)PLColorGrayLight;
/**
 分割线的颜色ececec
 */
+(UIColor*)PLColorSeparateLine;

/**
 分享内容背景色  f4f4f4
 */
+(UIColor*)PLColorShare;

/**
 内容背景色 ffffff
 */
+(UIColor*)PLColorContentBack;

/**
 背景色f5f6f8
 */
+(UIColor*)PLColorGlobalBack;

/**
 cell选中的颜色
 */
+(UIColor*)PLColorCellSelected;

/**
 主题颜色 绿色#00ad65
 */
+(UIColor *)PLColorTheme;




#pragma mark - projectcolor

/**背景底色f3f5f9 */
+(UIColor*)PLColorEEEEEE_Background;

/**用于标题文字主要提示文字33333 */
+(UIColor*)PLColor33333;

/*分类按钮背景色*/
+(UIColor *)PLColorF5F5F5;

/**用于标题较为重要的操作按钮666666 */
+(UIColor*)PLColor666666;

/**用于辅助说明提示文字999999*/
+(UIColor*)PLColor999999;

/**分割线线颜色dfdfdf */
+(UIColor *)PLColorDFDFDF_Cutline;


/**粉色深的ec6eb5,用于信息提示icon*/
+(UIColor*)PLColorEC6EB5;

/**蓝色深的33abcd,用于信息提示icon*/
+(UIColor*)PLColor33ABCD;

/**橙黄色ebab47,用于信息提示icon*/
+(UIColor*)PLColorEBAB47;

/**紫色a86ceb,用于信息提示icon*/
+(UIColor*)PLColorA86CEB;

/**大红色c53d43,用于信息提示icon*/
+(UIColor*)PLColorC53D43;

/**主题颜色 绿色#12b06b */
+(UIColor *)PLColor12B06B_Theme;

/**绿色 较浅*/
+(UIColor *)PLColor45B25E;

/**
 主题颜色#12B06B  绿色
 @param alph 透明度
 */
+(UIColor*)PLColorThemeAlph:(CGFloat)alph;

/**渐变开始 */
+(UIColor*)PLColorChangeStart12B06B;
/**渐变结束色 */
+(UIColor*)PLColorChangeStop3BA839;

/**列表cell触碰按下去的颜色ccccc */
+(UIColor*)PLColorCCCCCC_CellDown;

/**
 *按钮不可点击的颜色9d9d9
 */
+(UIColor*)PLColord9d9d9_UnTouch;

/**白色fffff */
+(UIColor*)PLColorFFFFFF_white;

/**蓝色背景色BAE1E7 */
+(UIColor*)PLColorBAE1E7;
/**橙色 ff9211 */
+(UIColor*)PLColorFF9211;

/**提示textT plachoder D0D0D0*/
+(UIColor*)PLColorD0D0D0;
/**粉色，女性 */
+(UIColor *)PLColorFFB1E3;
/**蓝色，男性 */
+(UIColor *)PLColorB1E8FF;
/**取消报名 */
+(UIColor*)PLColorddfbee;
/**签到背景色 */
+(UIColor*)PLColor448685;
/**小圆点背景 */
+(UIColor*)PLColorA2D3D2;
/*日历今天颜色 豆沙红*/
+(UIColor*)PLColorE36767;
/*补签背景色*/
+(UIColor*)PLColorB7C7C7;
//[UIColor colorWithHexString:@"#448685"];

@end

