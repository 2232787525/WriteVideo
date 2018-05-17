//
//  PLVideoShootVC.m
//  Clanunity
//
//  Created by wangyadong on 2017/8/24.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

#import "PLVideoShootVC.h"
#import "YHShootView.h"

@interface PLVideoShootVC ()
@property (nonatomic,strong)YHShootView *shootView;

@end

@implementation PLVideoShootVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = YES;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.knavigationBar.hidden = YES;
    //拍摄View
    WeakSelf
    _shootView = [[YHShootView alloc] initWithFrame:self.view.bounds];
    [_shootView onBackHandler:^{
        [weakSelf kBackBtnAction];
    }];
    [_shootView chooseHandler:^(ShootType type, id obj, id thumimg) {
        NSLog(@"选择的类型是%d,回调对象:%@",type,obj);

    }];
    [self.view addSubview:_shootView];
    // Do any additional setup after loading the view.
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
