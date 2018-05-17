//
//  UIColor+PLColor.m
//  PlamLive
//
//  Created by wangyadong on 2016/10/21.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "UIColor+PLColor.h"

@implementation UIColor (PLColor)

#pragma mark - Hex Color

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}


+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

+ (UIColor*) colorWithHex:(NSInteger)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}

+ (NSString *) hexFromUIColor: (UIColor*) color {
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    
    return [NSString stringWithFormat:@"#%x%x%x", (int)((CGColorGetComponents(color.CGColor))[0]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[1]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];
}


#pragma mark - PLColor

+(UIColor *)KNavigationBarTintColor{
    return [UIColor whiteColor];
}
+(UIColor *)KNavigationBarColor{
    return [UIColor colorWithHexString:@"#333333"];
}
+(UIColor*)plNavBarBackColorWithAlpha:(CGFloat)alph{
    return [UIColor colorWithHexString:@"#019ae4" alpha:alph];
}
+(UIColor *)plBackGroundColor{
    return [UIColor whiteColor];
}

+(UIColor *)plTabBarUnSelected{
    
    return [UIColor colorWithHexString:@"#b7bdc4"];
}
+(UIColor *)plTabBarSelected{
    return [UIColor colorWithHexString:@"#00ad65"];
}
+(UIColor*)plTabBarBackColor{
    return [UIColor yellowColor];
}
+(UIColor *)plTabbarToplineColor{
    return [UIColor colorWithHexString:@"#d3d7d9"];
}
//
+(UIColor *)plLineColor{
    return [UIColor PLColorSeparateLine];
//   return  [UIColor colorWithHexString:@"#dedede"];
}
//标题 深色
+(UIColor*)plDarkTitleColor{
    return [UIColor colorWithHexString:@"#232323"];
}
//标题 浅色
+(UIColor *)plLightTitleColor{
    return [UIColor colorWithHexString:@"#a0a0a0"];
}
//简介，内容,点赞数,--读书--
+(UIColor *)plLightInfoColor{
    return [UIColor colorWithHexString:@"#959595"];
}
//公众号字体颜色
+(UIColor*)plLightColor{
    return [UIColor colorWithHexString:@"#cbc9c9"];
}

+(UIColor*)plBlueColorWithAlph:(CGFloat)alph{
    return [UIColor colorWithHexString:@"#00ad65" alpha:alph];
}
//导航标题的字体颜色 self.knavigationItem.titleColor
+(UIColor*)plNavTitleColor{
    return [UIColor whiteColor];
}

+(UIColor*)plCellSelectedColor{
    return [UIColor colorWithHexString:@"#f5f5f5"];
}
//滑条颜色
+(UIColor*)plSliderDarkColor{
    return [UIColor colorWithHexString:@"#464c56"];
}

/**
 黄色颜色
 */
+(UIColor*)plYellowcolor{
    return [UIColor colorWithHexString:@"#f0c726"];
}
/**
 橘色
 */
+(UIColor*)color1Orange{
    return [UIColor colorWithHexString:@"#f76b38"];
}

+(UIColor*)color2blue{
    return [UIColor colorWithHexString:@"#019ae4"];
}
+(UIColor*)color3blue{
    return [UIColor colorWithHexString:@"#077af1"];
}

+(UIColor*)color4yellow{
    return [UIColor colorWithHexString:@"#ffcc1c"];
}

+(UIColor *)colorThemeTitleColor{
    return [UIColor colorWithHexString:@"#343434"];
}
+(UIColor *)textColor1{
    return [UIColor colorWithHexString:@"#343434"];
}


+(UIColor*)blueColor1{
    return [UIColor colorWithHexString:@"#409cfb"];
}



/**
 *409cfd
 */
+(UIColor*)PLColorBlue{
    return [UIColor colorWithHexString:@"#409cfb"];
}

/**
 *343434
 */
+(UIColor*)PLColorBlack{
    return [UIColor colorWithHexString:@"#343434"];
}

/**
 ffe700
 */
+(UIColor*)PLColorYellow{
    return [UIColor colorWithHexString:@"#ffe700"];
}

/**
 ff0000
 */
+(UIColor*)PLColorRed{
    return [UIColor colorWithHexString:@"#ff0000"];
}
+(UIColor*)PLColorPinkRed{
    return [UIColor colorWithHexString:@"#f75252"];
}

/**
 * 用于普通段落信息 999999
 * 如导咨询内容简介，动态内容简介，链接等
 */
+(UIColor*)PLColorGrayDark{
    return [UIColor colorWithHexString:@"#999999"];
}

/**
 用于辅助，次要信息显示 cdcdcd
 */
+(UIColor*)PLColorGrayLight{
    return [UIColor colorWithHexString:@"#cdcdcd"];

}
/**
 分割线的颜色
 */
+(UIColor*)PLColorSeparateLine{
    return [UIColor colorWithHexString:@"#ececec"];
}

/**
 分享内容背景色  f4f4f4
 */
+(UIColor*)PLColorShare{
    return [UIColor colorWithHexString:@"#f4f4f4"];
}

/**
 内容背景色 ffffff
 */
+(UIColor*)PLColorContentBack{
    return [UIColor colorWithHexString:@"#ffffff"];
}

/**
 背景色f5f6f8
 */
+(UIColor*)PLColorGlobalBack{
    return [UIColor colorWithHexString:@"#f5f6f8"];
}
+(UIColor*)PLColorCellSelected{
    return [UIColor colorWithHexString:@"#282828"];
}
#pragma mark - 新的色值定义
//主题颜色 绿色
+(UIColor *)PLColorTheme{
    return [UIColor PLColorThemeAlph:1];
}



+(UIColor *)PLColorEEEEEE_Background{
    return [UIColor colorWithHexString:@"#f3f5f9"];
}
+(UIColor *)PLColor33333{
    return [UIColor colorWithHexString:@"#333333"];
}

+(UIColor *)PLColorF5F5F5{
    return [UIColor colorWithHexString:@"#F5F5F5"];
}

+(UIColor *)PLColor666666{
    return [UIColor colorWithHexString:@"#666666"];
}

+(UIColor *)PLColor999999{
    return [UIColor colorWithHexString:@"#999999"];
}

+(UIColor *)PLColorDFDFDF_Cutline{
    return [UIColor colorWithHexString:@"#dfdfdf"];
}

+(UIColor *)PLColorEC6EB5{
    return [UIColor colorWithHexString:@"#ec6eb5"];
}

+(UIColor*)PLColor33ABCD{
    return [UIColor colorWithHexString:@"#33abcd"];
}

+(UIColor*)PLColorEBAB47{
    return [UIColor colorWithHexString:@"#ebab47"];
}

+(UIColor *)PLColorA86CEB{
    return [UIColor colorWithHexString:@"#a86ceb"];
}

+(UIColor*)PLColorC53D43{
    return [UIColor colorWithHexString:@"#c53d43"];
}

+(UIColor*)PLColorThemeAlph:(CGFloat)alph{
    return [UIColor colorWithHexString:@"#12b06b" alpha:alph];
}
+(UIColor *)PLColor12B06B_Theme{
    return [UIColor PLColorThemeAlph:1];
}
+(UIColor *)PLColor45B25E{
    return [UIColor colorWithHexString:@"#45b25e"];
    
}
+(UIColor *)PLColorChangeStart12B06B{
    return [UIColor colorWithHexString:@"#12b06b"];
}

+(UIColor *)PLColorChangeStop3BA839{
    return [UIColor colorWithHexString:@"#3ba839"];
}
+(UIColor *)PLColorCCCCCC_CellDown{
    return [UIColor colorWithHexString:@"#cccccc"];
}

+(UIColor *)PLColord9d9d9_UnTouch{
    return [UIColor colorWithHexString:@"#d9d9d9"];
}

+(UIColor*)PLColorFFFFFF_white{
    return [UIColor colorWithHexString:@"#ffffff"];
    
}

+(UIColor*)PLColorBAE1E7{
    return [UIColor colorWithHexString:@"#bae1e7"];
    
}

+(UIColor*)PLColorFF9211{
    return [UIColor colorWithHexString:@"#ff9211"];
}

+(UIColor *)PLColorD0D0D0{
    return [UIColor colorWithHexString:@"#D0D0D0"];
}

+(UIColor *)PLColorFFB1E3{
    return [UIColor colorWithHexString:@"#FFB1E3"];
}

+(UIColor *)PLColorB1E8FF{
    return [UIColor colorWithHexString:@"#B1E8FF"];
}
+(UIColor*)PLColorddfbee{
    return [UIColor colorWithHexString:@"#ddfbee"];
}
+(UIColor*)PLColor448685{
    return [UIColor colorWithHexString:@"#448685"];
}
+(UIColor*)PLColorA2D3D2{
    return [UIColor colorWithHexString:@"#A2D3D2"];
}
+(UIColor*)PLColorE36767{
    return [UIColor colorWithHexString:@"#E36767"];
}
+(UIColor*)PLColorB7C7C7{//补签背景色
    return [UIColor colorWithHexString:@"#B7C7C7"];
}



@end
