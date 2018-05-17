//
//  ICAVPlayer.m
//  YHChat
//
//  Created by samuelandkevin on 17/4/24.
//  Copyright © 2017年 samuelandkevin All rights reserved.
//

#import "YHAVPlayer.h"
//#import "YYKit.h"
#import "UIView+WDKit.h"

@interface YHAVPlayer ()
@property (nonatomic, weak) UIView *fromView;
@property (nonatomic, weak) UIView *toContainerView;
@property (nonatomic, assign) BOOL fromNavigationBarHidden;

@end
@implementation YHAVPlayer
- (instancetype)initWithFrame:(CGRect)frame playerURL:(NSURL *)URL {
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor blackColor];
        
        //设置player的参数
        self.currentItem = [AVPlayerItem playerItemWithURL:URL];
        self.player = [AVPlayer playerWithPlayerItem:self.currentItem];
        self.player.usesExternalPlaybackWhileExternalScreenIsActive=YES;
        //AVPlayerLayer
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        
        self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.playerLayer.frame = self.bounds;
        [self.layer addSublayer:self.playerLayer];
        [self.player play];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActionClicked)];
        [self addGestureRecognizer:tap];
        // 循环播放
        _player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(playerItemDidPlayToEndTimeNotification:)
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:nil];
    }
    return self;
}
-(void)tapActionClicked{
    [self dismissAnimated:YES completion:nil];

}

- (void)dismissAnimated:(BOOL)animated completion:(void (^)(void))completion {
    [UIView setAnimationsEnabled:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:_fromNavigationBarHidden withAnimation:animated ? UIStatusBarAnimationFade : UIStatusBarAnimationNone];
    if ([self.delegate respondsToSelector:@selector(closePlayerViewAction)]) {
        [self.delegate closePlayerViewAction];
    }
    float oneTime = animated ? 0.5 : 0;
    
    [UIView animateWithDuration:oneTime delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self releasePlayer];
        if (completion) completion();
    }];
    
}

- (void)presentFromVideoView:(UIView *)fromView
                 toContainer:(UIView *)toContainer
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion{
    _toContainerView = toContainer == nil ? [UIApplication sharedApplication].keyWindow.rootViewController.view : toContainer;
    
    _fromView = fromView;
    
    [_toContainerView addSubview:self];
    
    CGFloat height = fromView.height_sd * KScreenWidth / fromView.width_sd;
    
    
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    
    self.alpha = 0;
    
    float oneTime = animated ? 0.5 : 0;
    
    [UIView animateWithDuration:oneTime animations:^{
        self.playerLayer.frame = CGRectMake(0, KScreenHeight / 2 - height / 2, KScreenWidth, height);
        self.alpha = 1;
    }];
    _fromNavigationBarHidden = [UIApplication sharedApplication].statusBarHidden;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:animated ? UIStatusBarAnimationFade : UIStatusBarAnimationNone];
    if (completion) completion();
}



- (void)playerItemDidPlayToEndTimeNotification:(NSNotification *)sender {
    [self.player seekToTime:kCMTimeZero]; // seek to zero
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self releasePlayer];
}

- (void)releasePlayer {
    [self.player.currentItem cancelPendingSeeks];
    [self.player.currentItem.asset cancelLoading];
    [self.player pause];
    [self removeFromSuperview];
    [self.playerLayer removeFromSuperlayer];
    [self.player replaceCurrentItemWithPlayerItem:nil];
    self.player = nil;
    self.currentItem = nil;
    self.playerLayer = nil;
}

@end
