//
//  PLDetailsVideoViewController.m
//  Clanunity
//
//  Created by wangyadong on 2017/5/12.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

#import "PLDetailsVideoViewController.h"

#import <MediaPlayer/MediaPlayer.h>

@interface PLDetailsVideoViewController ()

@end

@implementation PLDetailsVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSURL *videoUrl=[NSURL URLWithString:@"http://zfy.netminer.cn/ysjapp/serverimg/video/20170509/20170509014123.mp4"];
    MPMoviePlayerViewController *movieVc=[[MPMoviePlayerViewController alloc]initWithContentURL:videoUrl];
        //弹出播放器
    [self presentMoviePlayerViewControllerAnimated:movieVc];
    
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
