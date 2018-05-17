//
//  PageBaseVC.m
//  Clanunity
//
//  Created by wangyadong on 2018/1/16.
//  Copyright © 2018年 zfy_srf. All rights reserved.
//

#import "PageBaseVC.h"
#import <MJRefresh/MJRefresh.h>

NSNotificationName const ChildScrollViewDidScrollNSNotification = @"ChildScrollViewDidScrollNSNotification";
NSNotificationName const ChildScrollViewRefreshStateNSNotification = @"ChildScrollViewRefreshStateNSNotification";

@interface PageBaseVC ()

@end

@implementation PageBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.height_sd = KScreenHeight-KTopHeight-KBottomHeight;
    [self.view addSubview:self.tableView];
    self.scrollView = self.tableView;
    self.view.backgroundColor = [UIColor purpleColor];
    
}
-(void)tabEndRefreshing{
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
    [[NSNotificationCenter defaultCenter] postNotificationName:ChildScrollViewRefreshStateNSNotification object:nil userInfo:@{@"isRefreshing":@(NO)}];
}
-(void)tabStartRefresh{
    [[NSNotificationCenter defaultCenter] postNotificationName:ChildScrollViewRefreshStateNSNotification object:nil userInfo:@{@"isRefreshing":@(YES)}];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //方向,大于0是向上滑动，小于0是向下滑动；
    CGFloat offsetDifference = scrollView.contentOffset.y - self.lastContentOffset.y;
    if (offsetDifference>0) {//向上滑动
    }else{//向下滑下
    }
    // 滚动时发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:ChildScrollViewDidScrollNSNotification object:nil userInfo:@{@"scrollingScrollView":scrollView,@"offsetDifference":@(offsetDifference)}];
    self.lastContentOffset = scrollView.contentOffset;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, KScreenWidth,KScreenHeight-KTopHeight-KBottomHeight) style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(self.beginTopInset, 0, 0, 0);
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(self.beginTopInset, 0, 0, 0);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        if (@available(iOS 11.0, *)) {
            NSLog(@"iOS 11.0");
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        }
        _tableView.backgroundColor = [UIColor PLColorGlobalBack];
        _tableView.separatorStyle = NO;
//        _tableView.separatorColor = [UIColor PLColorSeparateLine];
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        //ios8
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        
    }
    return _tableView;
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


