//
//  KNavigationController.m
//  PlamLive
//
//  Created by wangyadong on 2016/10/21.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "KNavigationController.h"

#import "UIViewController+KNavigationConfig.h"
#import "KNavigationBar.h"
#import "KNavigationItem.h"

@interface KNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation KNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarHidden = YES;
    super.delegate = self;
    [self slideToBack];
    // Do any additional setup after loading the view.
}
//设置状态栏的颜色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)slideToBack{
    // 禁止系统原来的滑动返回手势，防止手势冲突
    self.interactivePopGestureRecognizer.enabled = YES;
}
-(void)handleNavigationTransition:(UIPanGestureRecognizer*)pan{

}
#pragma mark - 手势代理方法
// 是否开始触发手势，如果是根控制器就不触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 判断下当前控制器是否是根控制器
    return (self.topViewController != [self.viewControllers firstObject]);
}


#pragma mark - Push & Pop

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self configureNavigationBarForViewController:viewController];
    [super pushViewController:viewController animated:animated];
}
- (void)configureNavigationBarForViewController:(UIViewController *)viewController {
    
    if (!viewController.knavigationItem) {
        
        KNavigationItem *navigationItem = [[KNavigationItem alloc] init];
        [navigationItem setValue:viewController forKey:@"_kviewController"];
        viewController.knavigationItem = navigationItem;
    }
    
    if (!viewController.knavigationBar) {
        
        viewController.knavigationBar = [[KNavigationBar alloc] init];
    }
    
    if (!viewController.knavigationItem.leftBarButtonItem && !viewController.isRootVC) {
        viewController.knavigationItem.leftBarButtonItem = [viewController kcreateBackItem];
    }
}
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [viewController.view bringSubviewToFront:viewController.knavigationBar];
}
# pragma mark - Rotate
-(BOOL)shouldAutorotate {
    if ([self.topViewController respondsToSelector:@selector(shouldAutorotate)]) {
        return self.topViewController.shouldAutorotate;
    }
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([self.topViewController respondsToSelector:@selector(supportedInterfaceOrientations)]) {
        return self.topViewController.supportedInterfaceOrientations;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    if ([self.topViewController respondsToSelector:@selector(preferredInterfaceOrientationForPresentation)]) {
        return self.topViewController.preferredInterfaceOrientationForPresentation;
    }
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
