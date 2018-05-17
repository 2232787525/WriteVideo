//
//  PLUIButton.m
//  PlamLive
//
//  Created by wangyadong on 2017/2/23.
//  Copyright © 2017年 wangyadong. All rights reserved.
//

#import "PLUIButton.h"

@implementation PLUIButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    /** 修改 title 的 frame */
    // 1.获取 titleLabel 的 frame
    CGRect titleLabelFrame = self.titleLabel.frame;
    // 2.修改 titleLabel 的 frame
    titleLabelFrame.origin.x = 0;
    // 3.重新赋值
    self.titleLabel.frame = titleLabelFrame;
    
    /** 修改 imageView 的 frame */
    // 1.获取 imageView 的 frame
    CGRect imageViewFrame = self.imageView.frame;
    // 2.修改 imageView 的 frame
    imageViewFrame.origin.x = titleLabelFrame.size.width;
    // 3.重新赋值
    self.imageView.frame = imageViewFrame;
    CGFloat w = self.titleLabel.size_sd.width+self.imageView.size_sd.width;
    titleLabelFrame.origin.x = (self.width_sd-w)/2.0;
    self.titleLabel.frame = titleLabelFrame;
    imageViewFrame.origin.x = titleLabelFrame.origin.x+titleLabelFrame.size.width;
    self.imageView.frame = imageViewFrame;
}

@end
