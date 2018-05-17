//
//  UIWindow+PLHierarchy.m
//  Clanunity
//
//  Created by wangyadong on 2017/4/12.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

#import "UIWindow+PLHierarchy.h"
#import <UIKit/UINavigationController.h>

@implementation UIWindow (PLHierarchy)

- (UIViewController*)topMostController
{
    UIViewController *topController = [self rootViewController];
    
    //  Getting topMost ViewController
    while ([topController presentedViewController])	topController = [topController presentedViewController];
    
    //  Returning topMost ViewController
    return topController;
}

- (UIViewController*)currentViewController;
{
    UIViewController *currentViewController = [self topMostController];
    
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    
    return currentViewController;
}

@end
