//
//  PLDetailsVC.m
//  PlamLive
//
//  Created by Mac on 16/11/3.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "PLDetailsVC.h"


@interface PLDetailsVC ()<UITableViewDelegate,UITableViewDataSource,WKUIDelegate,WKNavigationDelegate>{
    BOOL _removeObserver;
    UILabel *_title;
    BOOL _webShow;
}
/**
 推荐数据
 */
@property(nonatomic,strong)NSMutableArray * recommendDataArray;
@end

@implementation PLDetailsVC
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(void)kBackBtnAction{
    if([self ifPush]){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
