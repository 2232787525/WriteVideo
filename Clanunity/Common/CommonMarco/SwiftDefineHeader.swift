//
//  SwiftDefineHeader.swift
//  Clanunity
//
//  Created by wangyadong on 2017/9/7.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

import Foundation
//引入AFnet
import AFNetworking

/// 系统
///
/// - IOS9:
/// - IOS10:
/// - IOS11:
@objc enum IOSSystem:Int {
    case IOS9 = 9
    case IOS10 = 10
    case IOS11 = 11
}

/// 设备型号
///
enum IPhoneType : String{
    case IPhone4 =      "iPhone 4"
    case IPhone4s =     "iphone 4s"
    case IPhone5 =      "iPhone 5"
    case IPhone5s =     "iPhone 5s"
    case IPhone5c =     "iPhone 5c"
    case IPhone6 =      "iPhone 6"
    case IPhone6p =     "iPhone 6 Plus"
    case IPhone6s =     "iPhone 6s"
    case IPhone6sp =    "iPhone 6s Plus"
    case IPhoneSE =     "iPhone SE"
    case IPhone7 =      "iPhone 7"
    case IPhone7p =     "iPhone 7 Plus"
    case IPhone8 =      "iPhone 8"
    case IPhone8p =     "iPhone 8 Plus"
    case IPhoneX =      "iPhone X"
    
    case Simulator = "Simulator"
    case UnKnow = "UnKnow"
}

/// 判断系统
///
/// - Parameter system: 系统参数
/// - Returns: 是否
func IOS(system:IOSSystem) -> Bool {
    
    if Double(UIDevice.current.systemVersion)! >= Double(system.rawValue) {
        return true
    }
    return false
}


/// 获取设备类型
///
/// - Returns: 手机型号iphone4，5，6，7,8,X
func IPhoneDevice () -> IPhoneType? {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
    switch identifier {
    case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return IPhoneType.IPhone4
    case "iPhone4,1":                               return IPhoneType.IPhone4s
    case "iPhone5,1", "iPhone5,2":                  return IPhoneType.IPhone5
    case "iPhone5,3", "iPhone5,4":                  return IPhoneType.IPhone5c
    case "iPhone6,1", "iPhone6,2":                  return IPhoneType.IPhone5s
    case "iPhone7,2":                               return IPhoneType.IPhone6
    case "iPhone7,1":                               return IPhoneType.IPhone6p
    case "iPhone8,1":                               return IPhoneType.IPhone6s
    case "iPhone8,2":                               return IPhoneType.IPhone6sp
    case "iPhone8,4":                               return IPhoneType.IPhoneSE
    case "iPhone9,1", "iPhone9,3":                  return IPhoneType.IPhone7
    case "iPhone9,2", "iPhone9,4":                  return IPhoneType.IPhone7p
    case "iPhone10,1","iPhone10,4":                 return IPhoneType.IPhone8
    case "iPhone10,2","iPhone10,5":                 return IPhoneType.IPhone8p
    case "iPhone10,3","iPhone10,6":                 return IPhoneType.IPhoneX
        
    case "i386", "x86_64":                          return IPhoneType.Simulator
    default:                                        return IPhoneType.UnKnow
    }
}

/// 是否是iphone4，5，6，7，8，X
///
/// - Parameter name: 手机名字
/// - Returns: bool
func IPhoneTrue(name:IPhoneType) -> Bool {
    if IPhoneDevice() == name {
        return true
    }
    return false
}

/// appdelegate
let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate

/// 屏幕高
let KScreenHeight = UIScreen.main.bounds.size.height

/// 屏幕宽
let KScreenWidth = UIScreen.main.bounds.size.width

let IS_IPHONE_X = (KScreenHeight == 812 ? true : false)

/// 生成二维码加密的密钥
let QRCodeSecretKey = "QR201710"

func F_I6(place:CGFloat) -> CGFloat {
    return (KScreenWidth * place / 375.0)
}


let  kScreenScale = KScreenWidth / 375.0
let  KNavigationBarHeight = CGFloat(44.0)
let  KStatusBarHeight = (IS_IPHONE_X ? CGFloat(44.0) : CGFloat(20.0))
let  KTopHeight = (KNavigationBarHeight + KStatusBarHeight)
let  KTabBarHeight = CGFloat(49.0)
let  KBottomStatusH = (IS_IPHONE_X ? CGFloat(34.0) : CGFloat(0.0))
let  KBottomHeight = (KTabBarHeight + KBottomStatusH)


//#pragma mark - 站位图名字
let Place_HEADIMG = "placeheadTheme"
let Place_SQUAREIMG = "placesquare"
let Place_SQUARENESSIMG = "placesquareness"
let Place_NOPICTURE_GREY = "nopicture_grey"

//#pragma mark - 未处理的加群消息本地存储文件名
let FP_SocialMessageUntreated = "social_message_Untreated"




