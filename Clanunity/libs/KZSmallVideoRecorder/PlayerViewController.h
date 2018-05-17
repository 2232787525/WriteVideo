//
//  PlayerViewController.h
//  KZWeChatSmallVideo_OC
//
//  Created by wangyadong on 2017/8/17.
//  Copyright © 2017年 侯康柱. All rights reserved.
//

#import "PLBaseViewController.h"
#import "KZVideoConfig.h"

@class KZVideoModel;
@interface PlayerViewController : PLBaseViewController
/**默认是NO，可以删除视频， */
@property(nonatomic,assign)BOOL onlyShow;
@property(nonatomic,strong)KZVideoModel * netModel;
@property(nonatomic,strong)KZVideoModel * model;
@property(nonatomic,copy)void(^deleteVideoBlock)();

@end


@interface  PlayerHeaderToor: UIView
@property(nonatomic,weak)UIButton * deleteButton;
@property(nonatomic,assign)CGFloat top;

@property(nonatomic,copy)void(^deleteClicked)();
@property(nonatomic,copy)void(^backClicked)();
-(void)showAnmition;
-(void)hiddenAnmition;
@end
