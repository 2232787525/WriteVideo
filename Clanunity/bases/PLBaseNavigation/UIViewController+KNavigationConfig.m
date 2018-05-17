//
//  UIViewController+KNavigationConfig.m
//  PlamLive
//
//  Created by wangyadong on 2016/10/21.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "UIViewController+KNavigationConfig.h"
#import <objc/runtime.h>



static char const * const kNaviHidden  = "kSPNaviHidden";
static char const * const kNaviBarItem = "kSPNaviBar";
static char const * const kNaviBarView = "kNaviBarView";
static char const * const kRootVC      = "isRootVC";

@implementation UIViewController (KNavigationConfig)


#pragma mark - 导航条是否被隐藏
-(BOOL)kisNavigationBarHidden
{
    return [objc_getAssociatedObject(self, kNaviHidden) boolValue];
}
-(void)setKnavigationBarHidden:(BOOL)knavigationBarHidden
{
    objc_setAssociatedObject(self, kNaviHidden, @(knavigationBarHidden), OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark - 是否是导航控制器的根控制器

-(void)setIsRootVC:(BOOL)isRootVC
{
    objc_setAssociatedObject(self, kRootVC, @(isRootVC), OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)isRootVC
{
    return  [objc_getAssociatedObject(self, kRootVC) boolValue];
}

#pragma mark - 导航栏上面的工具

-(void)setKnavigationItem:(KNavigationItem *)knavigationItem{
    objc_setAssociatedObject(self, kNaviBarItem, knavigationItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (KNavigationItem *)knavigationItem {
    return objc_getAssociatedObject(self, kNaviBarItem);
}


#pragma mark - 导航条
-(void)setKnavigationBar:(KNavigationBar *)knavigationBar{
    objc_setAssociatedObject(self, kNaviBarView, knavigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(KNavigationBar *)knavigationBar{
    return objc_getAssociatedObject(self, kNaviBarView);
}


#pragma mark - 导航条是否被隐藏
// 设置导航条隐藏与否
-(void)ksetNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;
{
    if (hidden) {

        if (animated) {
            [UIView animateWithDuration:0.25 * 2 animations:^{
                self.knavigationBar.top_sd = -KTopHeight;
                [self.knavigationBar layoutIfNeeded];
                for (UIView *view in self.knavigationBar.subviews) {
                    view.alpha = 0.0;
                }
            } completion:^(BOOL finished) {
                self.knavigationBarHidden = YES;
            }];
        }else {
            [self.knavigationBar layoutIfNeeded];
            self.knavigationBarHidden = YES;
            self.knavigationBar.top_sd = -KTopHeight;
        }
    } else {
        
        if (animated) {
            
            [UIView animateWithDuration:0.25 * 2 animations:^{
                self.knavigationBar.top_sd = 0;
                [self.knavigationBar layoutIfNeeded];
                for (UIView *view in self.knavigationBar.subviews) {
                    view.alpha = 1.0;
                }
            } completion:^(BOOL finished) {
                self.knavigationBarHidden = NO;
            }];
        }else {
            [self.knavigationBar layoutIfNeeded];
            self.knavigationBarHidden = NO;
            self.knavigationBar.top_sd = 0;
        }
    }

}

#pragma mark - 在导航条上面加上加载数据的动画
//开始
- (void)knaviBeginRefreshing {
    
    NSInteger WActivityViewWidth = 35;
    
    UIActivityIndicatorView *activityView;
    for (UIView *view in self.knavigationBar.subviews) {
        if ([view isKindOfClass:[UIActivityIndicatorView class]]) {
            activityView = (UIActivityIndicatorView *)view;
        }
        if ([view isEqual:self.knavigationItem.rightBarButtonItem.customView]) {
            [view removeFromSuperview];
        }
    }
    
    if (!activityView) {
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView setColor:[UIColor blackColor]];
        [self.knavigationBar addSubview:activityView];
        activityView.size_sd = CGSizeMake(WActivityViewWidth, WActivityViewWidth);
        activityView.top_sd =KStatusBarHeight + (KNavigationBarHeight - WActivityViewWidth) / 2;
        activityView.right_sd =KScreenWidth-16;

    }
    
    [activityView startAnimating];
    
}
//结束
- (void)knaviEndRefreshing {
    
    UIActivityIndicatorView *activityView;
    for (UIView *view in self.knavigationBar.subviews) {
        if ([view isKindOfClass:[UIActivityIndicatorView class]]) {
            activityView = (UIActivityIndicatorView *)view;
        }
    }
    if (self.knavigationItem.rightBarButtonItem) {
        [self.knavigationBar addSubview:self.knavigationItem.rightBarButtonItem.customView];
    }
    [activityView stopAnimating];
}


#pragma mark - 创建左返回按钮
- (KBarButtonItem *)kcreateBackItem {
    
    __weak typeof(self) typeSelf = self;
    KBarButtonItem *left =[[KBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"left_back_icon"] style:KBarButtonItemStyleLeft handler:^(id sender) {
        [typeSelf kBackBtnAction];
    }];
    [left.button setContentEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];

    return left;
    
}

-(void)kBackBtnAction
{
    if (![self.navigationController popViewControllerAnimated:YES]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
