//
//  main.m
//  Clanunity
//
//  Created by zfy_srf on 2017/4/1.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
CFAbsoluteTime StartTime;
int main(int argc, char * argv[]) {
    @autoreleasepool {
        StartTime = CFAbsoluteTimeGetCurrent();
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
    }
}
