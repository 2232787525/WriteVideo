//
//  DeviceIdentifier.h
//  PLHttp
//
//  Created by Mac on 16/10/21.
//  Copyright © 2016年 ZhangFY. All rights reserved.
//

/**
 
 使用方式:
 1.把 类库 目录下的DeviceIdentifierUtils文件夹拖到你的项目中
 2.打开你项目的Target->Build Phases->Compile Sources, 找到SFHFKeychainUtils.m项, 双击此项并填入-fno-objc-arc (因为此文件不是ARC下编写的)
 3.现在可以开始使用了.
 
 d_brand	设备品牌         iphone
 d_platform	平台及版本       ios 9.3.3
 d_model	设备型号         iphone 5s
 d_code     设备编号         E49A1AB0-CDFD-4200-A5E3-EE3CBACC5AE4
 dpi        设备像素         320
 resolution	分辨率           1136*640
 v_code     版本             0.6
 v_name     版本类型         common
 _dticket	时间戳（13位）
 nc         网络状况         wifi/3g/4g
 openuuid	用户临时身份票据
 
 */

#import <Foundation/Foundation.h>

@interface DeviceIdentifier : NSObject
/**
 *  返回唯一设备标识   fagei
 *
 *  @return 设备标识
 */

+(NSString*)deviceIdentifier;

/**
 *  本应用是第一次安装
 *
 *  @return 是否是第一次安装
 */

+(BOOL)isFirstInstall;

/**
 *  返回设备型号 detype       ipone 5s
 *
 *  @return 设备型号
 */

+(NSString *)DevicephoneModel;

/**
 *  返回设备版本号 outerver   9.3.3
 *
 *  @return 设备版本号
 */

+(NSString *)DevicestrSysVersion;

/**
 *   返回设备分辨率 Screenrl   1136*640
 *
 *   @return 设备分辨率
 */

+(NSString *)DeviceScreenrl;

/**
 *   返回设备像素 Screenpx   像素
 *
 *   @return 设备像素
 */

+(NSString *)DeviceScreenpx;

/**
 *   返回设备分辨率 DeviceBrand   iphone
 *
 *   @return 设备品牌
 */

+(NSString *)DeviceBrand;

/**
 *  返回APP版本 aps          0.6
 *
 *  @return APP版本
 */

+(NSString *)AppstrAppVersion;

/**
 *  返回APP应用名称 strAppName        Clanunity
 *
 *  @return APP应用名称
 */

+(NSString *)AppstrAppName;

/**
 *  监听网络状态
 *
 *  @return 返回网络状态
 */

+(NSString *)networkingStatesFromStatebar;

/**
 *  hmac 加密
 *
 *  @return 返回SHA1
 */

+(NSString *)hmac:(NSString *)plainText withKey:(NSString *)key;

/**
 *  机型
 *
 *  @return 返回设备型号
 */

+ (NSString*)deviceModelName;

@end
