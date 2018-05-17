//
//  KZVideoPlayer.h
//  KZWeChatSmallVideo_OC
//
//  Created by HouKangzhu on 16/7/21.
//  Copyright © 2016年 侯康柱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KZVideoPlayer : UIView

- (instancetype)initWithFrame:(CGRect)frame videoUrl:(NSURL *)videoUrl;

@property (nonatomic, strong, readonly) NSURL *videoUrl;

@property (nonatomic,assign) BOOL autoReplay; // 默认 YES

@property(nonatomic,copy)void(^playerTapActionBlock)();

@property(nonatomic,assign,readonly)BOOL isPlaying;

- (void)play;

- (void)stop;

- (void)tapAction;

@end
