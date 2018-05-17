//
//  UIWindow+PLHierarchy.h
//  Clanunity
//
//  Created by wangyadong on 2017/4/12.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIViewController;
@interface UIWindow (PLHierarchy)

/**
 Returns the current Top Most ViewController in hierarchy.
 */
@property (nullable, nonatomic, readonly, strong) UIViewController *topMostController;

/**
 Returns the topViewController in stack of topMostController.
 */
@property (nullable, nonatomic, readonly, strong) UIViewController *currentViewController;

@end
