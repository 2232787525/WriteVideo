//
//  SwiftCommonHelp.swift
//  Clanunity
//
//  Created by wangyadong on 2017/10/19.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

import Foundation


func helpLoginAsd() -> String? {
    let loginManager = LoginUserManager.loginShare()
    if loginManager.loginGetSessionModel() != nil{
        let session = loginManager.loginGetSessionModel();
        if session?.session_asd != nil{
            return (session?.session_asd)!;
        }
    }
    return nil
}

func helpReturnValue(objc:Any?) -> String {
    if objc != nil  {
        return "\(objc!)"
    }
    return ""
}


/// 检测计时器
class WatchdogTimer: NSObject {
    static let shareTimer : WatchdogTimer = {
        let timer = WatchdogTimer()
        return timer;
    }()
    var timer : Timer?
    var timeInterval = 6*60//10分钟执行一次
    
    var watchdogCallBack : ((() -> Void)?)
    
    func startWatchdog() -> Void {
        self.stopWatchdog()
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.timeInterval), target: self, selector: #selector(self.repeatfunc), userInfo: nil, repeats: true)
        RunLoop.current.add(self.timer!, forMode: RunLoopMode.defaultRunLoopMode)
        
    }
    func stopWatchdog() -> Void {
        if self.timer != nil && (self.timer?.isValid)! {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    func repeatfunc() -> Void {
        if self.watchdogCallBack != nil {
            self.watchdogCallBack!()
        }
    }

}







