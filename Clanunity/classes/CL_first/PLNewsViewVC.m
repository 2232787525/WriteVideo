//
//  PLNewsViewVC.m
//  PlamLive
//
//  Created by wangyadong on 2016/10/31.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "PLNewsViewVC.h"
#import "PLDetailsVC.h"
#import "MJRefresh.h"
#import "XLVideoPlayer.h"

@interface PLNewsViewVC ()
{
    XLVideoPlayer *_player;
}
@end

@implementation PLNewsViewVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor PLColorGlobalBack];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self playerDestroy];
}

-(void)playerDestroy{
    if (_player) {
        [_player destroyPlayer];
        _player=nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

