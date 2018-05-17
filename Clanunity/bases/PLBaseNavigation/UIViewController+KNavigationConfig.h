//
//  UIViewController+KNavigationConfig.h
//  PlamLive
//
//  Created by wangyadong on 2016/10/21.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "KNavigationItem.h"
#import "KBarButtonItem.h"
#import "KNavigationBar.h"

@interface UIViewController (KNavigationConfig)

/**
 *  导航栏上面的工具
 */
@property (nonatomic, strong) KNavigationItem *knavigationItem;
/**
 *  导航条
 */
@property (nonatomic, strong) KNavigationBar *knavigationBar;
/*
 *  导航条是否被隐藏
 */
@property(nonatomic, assign, getter = kisNavigationBarHidden) BOOL knavigationBarHidden;
/**
 *  是否是导航控制器的根控制器。(不用管这个属性)
 */
@property (nonatomic, assign) BOOL isRootVC;


/**
 *  设置导航条隐藏与否
 *
 *  @param hidden   是否隐藏
 *  @param animated 是否动画
 */
- (void)ksetNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;
/**
 *  在导航条上面加上加载数据的动画
 */
- (void)knaviBeginRefreshing;
- (void)knaviEndRefreshing;

- (KBarButtonItem *)kcreateBackItem;

/**
 *  返回触发的方法
 */
-(void)kBackBtnAction;




@end
