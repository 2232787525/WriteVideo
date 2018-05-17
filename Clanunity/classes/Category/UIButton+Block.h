//
//  NrButton.h
//  chezhidao
//
//  Created by dxd on 14-3-31.
//  Copyright (c) 2014年 niuche.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void (^ActionBlock)();

@interface UIButton(Block)
@property (readonly) NSMutableDictionary *event;

- (void) handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock)action;
//默认用的最多的事件
- (void)handleEventTouchUpInsideWithBlock:(ActionBlock)block;

@end
