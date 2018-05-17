//
//  DeviceIdentifier.m
//  PLHttp
//
//  Created by Mac on 16/10/21.
//  Copyright © 2016年 ZhangFY. All rights reserved.
//

#import "DeviceIdentifier.h"
//iphone    型号
#import <sys/utsname.h>
//hmac_sha1 加密
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
#import "DeviceKeychain.h"
//获取包名 如:com.hext.uuidDemo
#define bundleIdentifier [[NSBundle mainBundle]bundleIdentifier]

@implementation DeviceIdentifier


/**
 *  返回唯一设备标识
 *
 *  @return 设备标识
 */
+(NSString*)deviceIdentifier{
    //从钥匙串中获取唯一设备标识
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *uuid = [user objectForKey:@"PL_UUID"];
    if (uuid == nil) {
        NSString *uuid =[DeviceKeychain getIDFV];
        [user setObject:uuid forKey:@"PL_UUID"];
        return uuid;
    }
    return uuid;
}

/**
 *  本应用是第一次安装
 *
 *  @return 是否是第一次安装
 */
+(BOOL)isFirstInstall{

    NSString * deviceIdentifier = [DeviceIdentifier deviceIdentifier];
    NSString * identifierForVendor = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    /**
     *  如果钥匙串中存的deviceIdentifier(设备标识)不存在 或者 等于deviceIdentifier(本应用的UUID) , 则为第一次安装
     */
    if ( !deviceIdentifier || [deviceIdentifier isEqualToString:identifierForVendor]) {
        return YES;
    }else{
        return NO;
    }
}

+(NSString *)DeviceScreenrl
{
    CGSize size =[UIScreen mainScreen].bounds.size;
    NSString *Screenrl =[NSString stringWithFormat:@"%.0f*%.0f",2*size.height,2*size.width];
    [DeviceIdentifier isFirstInstall];
    return Screenrl;
}

+(NSString *)DeviceScreenpx
{
    CGSize size =[UIScreen mainScreen].bounds.size;
    NSString *Screenpx =[NSString stringWithFormat:@"%.0f",size.width];
    
    return Screenpx;
}

+(NSString *)DeviceBrand
{
    NSString *DeviceBrand = [UIDevice currentDevice].model;
    
    return DeviceBrand;
}

+(NSString *)DevicephoneModel
{
    NSString* phoneModel = [DeviceIdentifier deviceModelName];
    
    return phoneModel;
}

+ (NSString*)deviceModelName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone 系列
    if ([deviceModel isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceModel isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceModel isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7 (CDMA)";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7 (GSM)";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus (CDMA)";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus (GSM)";
    
    //iPod 系列
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    //iPad 系列
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([deviceModel isEqualToString:@"iPad4,4"]
        ||[deviceModel isEqualToString:@"iPad4,5"]
        ||[deviceModel isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    
    if ([deviceModel isEqualToString:@"iPad4,7"]
        ||[deviceModel isEqualToString:@"iPad4,8"]
        ||[deviceModel isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
    return deviceModel;
}

+(NSString *)DevicestrSysVersion
{
    
    NSString *strSysVersion = [[UIDevice currentDevice] systemVersion];
      
    return strSysVersion;
}

+(NSString *)AppstrAppVersion
{
    NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
    
    NSString *strAppVersion = [dicInfo objectForKey:@"CFBundleShortVersionString"];
    
    return strAppVersion;
    
}

+(NSString *)AppstrAppName
{
    NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
    
    NSString *strAppName = [dicInfo objectForKey:@"CFBundleDisplayName"];
    
    return strAppName;
}

+(NSString *)networkingStatesFromStatebar {
//    // 状态栏是由当前app控制的，首先获取当前app
//    UIApplication *app = [UIApplication sharedApplication];
//
//    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
//
//    int type = 0;
//    for (id child in children) {
//        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
//            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
//        }
//    }
//
//    NSString *stateString = @"";
//
//    switch (type) {
//        case 0:
//            stateString = @"notReachable";  // 没有网络
//            break;
//
//        case 1:
//            stateString = @"2G";
//            break;
//
//        case 2:
//            stateString = @"3G";
//            break;
//
//        case 3:
//            stateString = @"4G";
//            break;
//
//        case 4:
//            stateString = @"LTE";  // 比4G更快的蜂窝网
//            break;
//
//        case 5:
//            stateString = @"wifi";
//            break;
//
//    }
//
//    return stateString;
    return @"4G";
}

+(NSString *)hmac:(NSString *)plainText withKey:(NSString *)key
{
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [plainText cStringUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMACData = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    
    const unsigned char *buffer = (const unsigned char *)[HMACData bytes];
    NSString *HMAC = [NSMutableString stringWithCapacity:HMACData.length * 2];
    
    for (int i = 0; i < HMACData.length; ++i)
        HMAC = [HMAC stringByAppendingFormat:@"%02lx", (unsigned long)buffer[i]];
    
    return HMAC;
}

@end
