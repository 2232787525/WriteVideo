//
//  PLBaseViewController.h
//  Clanunity
//
//  Created by zfy_srf on 2017/4/1.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

#import "UIViewController+KNavigationConfig.h"
#import "JCF_ModelManager.h"
#import <WebKit/WebKit.h>
@interface PLBaseViewController : UIViewController
@property (nonatomic,strong)UIView * bageView;//小红点 消息提醒

/**
 *  设置导航左边的按钮。（实际上可以设置控制器的 viewController.sc_navigationItem.leftBarButtonItem 属性）
 */
@property (nonatomic, strong) KBarButtonItem *leftBarButtonItem;
/**
 *  设置导航右边的按钮。（实际上可以设置控制器的 viewController.sc_navigationItem.rightBarButtonItem 属性）
 */
@property (nonatomic, strong) KBarButtonItem *rightBarButtonItem;



/**
 *  用法(block传值)
 *	self.rightBarButtonItem = [[YHBarButtonItem alloc] initWithTitle:@"发布" style:YHBarButtonItemStylePlain handler:^(id sender) {
 *		[self doSomeThing];//
 *	}];
 *	[self.rightBarButtonItem.button setTitleColor:WColorMain forState:UIControlStateNormal];
 *	self.sc_navigationItem.rightBarButtonItem = self.rightBarButtonItem;
 *
 *	也可以直接
 *	self.yh_navigationItem.rightBarButtonItem = [[YHBarButtonItem alloc] initWithTitle:@"发布" style:YHBarButtonItemStylePlain handler:^(id sender) {
 *		[self doSomeThing];//
 *	}];
 */

/**
 增加frame

 @param frame frame
 @return self
 */
-(instancetype)initWithFrame:(CGRect)frame;

@property(nonatomic,assign)CGRect frame;

@property(nonatomic,weak)PLBaseViewController * fatherSuperVC;
@property (nonatomic,strong)JCF_ModelManager *sqlManager;

-(BOOL)ifPush;

-(void)showGifView;

-(void)hiddenGifView;

-(void)loginSuccessNotification;

-(void)loginOutSuccessNotification;

-(void)registSuccessNotification;
//网络状态的改变
-(void)networkReachabilityStatus:(NSInteger)status;

-(void)popView:(NSString*)msg;


@end
