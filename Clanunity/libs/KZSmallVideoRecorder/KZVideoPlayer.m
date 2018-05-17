//
//  KZVideoPlayer.m
//  KZWeChatSmallVideo_OC
//
//  Created by HouKangzhu on 16/7/21.
//  Copyright © 2016年 侯康柱. All rights reserved.
//

#import "KZVideoPlayer.h"
#import <AVFoundation/AVFoundation.h>

@implementation KZVideoPlayer {
    AVPlayer *_player;
    
    UIView *_ctrlView;
    CALayer *_playStatus;
    
}

- (instancetype)initWithFrame:(CGRect)frame videoUrl:(NSURL *)videoUrl{
    if (self = [super initWithFrame:frame]) {
        _autoReplay = YES;
        _videoUrl = videoUrl;
        [self setupSubViews];
    }
    return self;
}

- (void)play {
    if (self.isPlaying) {
        return;
    }
    [self tapAction];
}

- (void)stop {
    if (self.isPlaying) {
        [self tapAction];
    }
}


- (void)setupSubViews {
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:_videoUrl];
    _player = [AVPlayer playerWithPlayerItem:playerItem];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    playerLayer.frame = self.bounds;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.layer addSublayer:playerLayer];
    
    _ctrlView = [[UIView alloc] initWithFrame:self.bounds];
    _ctrlView.backgroundColor = [UIColor clearColor];
    [self addSubview:_ctrlView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playerTapAction)];
    [_ctrlView addGestureRecognizer:tap];
    [self setupStatusView];
    [self tapAction];
}
-(void)playerTapAction{
    if (self.playerTapActionBlock) {
        self.playerTapActionBlock();
    }
}

- (void)setupStatusView {
    CGPoint selfCent = CGPointMake(self.bounds.size.width/2+10, self.bounds.size.height/2);
    CGFloat width = 40;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, selfCent.x - width/2, selfCent.y - width/2);
    CGPathAddLineToPoint(path, nil, selfCent.x - width/2, selfCent.y + width/2);
    CGPathAddLineToPoint(path, nil, selfCent.x + width/2 - 4, selfCent.y);
    CGPathAddLineToPoint(path, nil, selfCent.x - width/2, selfCent.y - width/2);
    
    CGColorRef color = [UIColor colorWithRed: 1.0 green: 1.0 blue: 1.0 alpha: 0.5].CGColor;
    
    CAShapeLayer *trackLayer = [CAShapeLayer layer];
    trackLayer.frame = self.bounds;
    trackLayer.strokeColor = [UIColor clearColor].CGColor;
    trackLayer.fillColor = color;
    trackLayer.opacity = 1.0;
    trackLayer.lineCap = kCALineCapRound;
    trackLayer.lineWidth = 1.0;
    trackLayer.path = path;
    [_ctrlView.layer addSublayer:trackLayer];
    _playStatus = trackLayer;
    
    CGPathRelease(path);
}

- (void)tapAction {
    if (self.isPlaying) {
        [_player pause];
    }
    else {
        [_player play];
    }
    _isPlaying = !self.isPlaying;
    _playStatus.hidden = !_playStatus.hidden;
}

- (void)playEnd {
    
    if (!_autoReplay) {
        return;
    }
    [_player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        [_player play];
    }];
}

- (void)removeFromSuperview {
    [_player.currentItem cancelPendingSeeks];
    [_player.currentItem.asset cancelLoading];
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
    [super removeFromSuperview];
}

- (void)dealloc {
//    NSLog(@"player dalloc");
}
@end
