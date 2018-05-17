//
//  KZVideoListViewController.m
//  KZWeChatSmallVideo_OC
//
//  Created by HouKangzhu on 16/7/21.
//  Copyright © 2016年 侯康柱. All rights reserved.
//

#import "KZVideoListViewController.h"
#import "KZVideoSupport.h"
#import "KZVideoConfig.h"
@interface KZVideoListViewController () {
}


@property (nonatomic, assign) KZVideoViewShowType showType;

@end

static KZVideoListViewController *__currentListVC = nil;

@implementation KZVideoListViewController

- (void)showAnimationWithType:(KZVideoViewShowType)showType {
    _showType = showType;
    
   
    [self closeViewAction];

}

- (void)closeAnimation {

    if (self.didCloseBlock) {
        self.didCloseBlock();
    }

}






#pragma mark - Actions --
- (void)closeViewAction {
    [self closeAnimation];
}

@end
