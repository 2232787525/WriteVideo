//
//  PLChatListVC.m
//  Clanunity
//
//  Created by bex on 2018/1/27.
//  Copyright © 2018年 zfy_srf. All rights reserved.
//

#import "ChatListVC.h"

@interface ChatListVC ()

@end

@implementation ChatListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.knavigationItem.leftBarButtonItem = nil;
    self.knavigationItem.title = @"聊天列表";
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
