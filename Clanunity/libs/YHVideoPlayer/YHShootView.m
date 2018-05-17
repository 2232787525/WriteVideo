//
//  YHShootView.m
//  YHChat
//
//  Created by samuelandkevin on 2017/4/25.
//  Copyright © 2017年 samuelandkevin. All rights reserved.
//

#import "YHShootView.h"
#import "YHVideoHelper.h"

@interface YHShootView()
@property (nonatomic,strong) YHShootBotView *viewBot;//底部view
@property (nonatomic,copy) void(^onBackBlock)();
@property (nonatomic,copy) void(^chooseBlock)(ShootType type,id obj,id thumImg);
@property (nonatomic,strong) UIImageView *imgvFocusCursor;//聚焦光标
@end

@implementation YHShootView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //视频层
        [[YHVideoHelper shareInstanced] setVideoView:self];
        
        //返回按钮
        UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(5, 20, 44, 44)];
        [btnBack setImage:[UIImage imageNamed:@"left_back_icon"] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(onBack:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnBack];
        
        //切换摄像头
        UIButton *btnChangeScene = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth-85, 30, 80, 40)];
//        [btnChangeScene setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5]];
//        [btnChangeScene setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [btnChangeScene setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
//        btnChangeScene.layer.cornerRadius  = 5;
//        btnChangeScene.layer.masksToBounds = YES;
//        btnChangeScene.titleLabel.font = [UIFont systemFontOfSize:13.0];
//        [btnChangeScene setTitle:@"后置摄像头" forState:UIControlStateNormal];
//        [btnChangeScene setTitle:@"前置摄像头" forState:UIControlStateSelected];
        [btnChangeScene setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [btnChangeScene setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        [btnChangeScene addTarget:self action:@selector(onChange:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnChangeScene];
        
        //shoot按钮层
        __weak typeof(self)weakSelf = self;

        _viewBot  = [[YHShootBotView alloc] init];
        _viewBot.superView  = self;
        [_viewBot stopShooting:^{
            btnChangeScene.hidden = YES;
        }];
        [_viewBot chooseHandler:^(ShootType type, id obj, id thumImg) {
            weakSelf.chooseBlock(type, obj, thumImg);
        }];

        [_viewBot cancelShooting:^{
            btnChangeScene.hidden = NO;
        }];
        [self addSubview:_viewBot];
        
        UITapGestureRecognizer *tapGesture= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureOnScreen:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

#pragma mark -  Action
- (void)onBack:(id)sender{
    [[YHVideoHelper shareInstanced] exit];
    [_viewBot cancelShooting:^{
        
    }];
    if (_onBackBlock) {
        _onBackBlock();
    }
}

- (void)onChange:(UIButton *)sender{
//    sender.selected = !sender.selected;
    [[YHVideoHelper shareInstanced] changeCameraDevicePosition];
}

#pragma mark - Gesture
//点击屏幕
- (void)gestureOnScreen:(UIGestureRecognizer *)aGes{
    CGPoint point = [aGes locationInView:self.superview];
    [[YHVideoHelper shareInstanced] setFoucsWithPoint:point];
}

//设置聚焦光标位置
-(void)_setFocusCursorWithPoint:(CGPoint)point{
    self.imgvFocusCursor.center = point;
    self.imgvFocusCursor.transform = CGAffineTransformMakeScale(1.5, 1.5);
    self.imgvFocusCursor.alpha = 1.0;
    [UIView animateWithDuration:1.0 animations:^{
        self.imgvFocusCursor.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.imgvFocusCursor.alpha = 0;
    }];
}

#pragma mark - Public Method
- (void)onBackHandler:(void (^)())handler{
    _onBackBlock = handler;
}

//选择回调
- (void)chooseHandler:(void(^)(ShootType type,id obj,id thumimg))complete;{
    _chooseBlock = complete;

}

#pragma mark - Life
- (void)dealloc{
    NSLog(@"%s is deallco",__func__);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
