//
//  PageBaseVC.h
//  Clanunity
//
//  Created by wangyadong on 2018/1/16.
//  Copyright © 2018年 zfy_srf. All rights reserved.
//

#import "PLBaseViewController.h"
UIKIT_EXTERN NSNotificationName const ChildScrollViewDidScrollNSNotification;
UIKIT_EXTERN NSNotificationName const ChildScrollViewRefreshStateNSNotification;


@interface PageBaseVC : PLBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,assign)CGFloat beginTopInset;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) CGPoint lastContentOffset;

@property (nonatomic, assign) BOOL isFirstViewLoaded;

@property (nonatomic, assign) BOOL refreshState;

/**
 table结束刷新发送通知
 */
-(void)tabEndRefreshing;

/**
 table开始刷新发送通知
 */
-(void)tabStartRefresh;

@end


