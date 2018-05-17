//
//  BaseRadarView.m
//  Property
//
//  Created by wangyadong on 16/8/5.
//  Copyright © 2016年 乐家园. All rights reserved.
//

#import "BaseRadarView.h"

@implementation BaseRadarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    
    if (view == nil) {
        CGPoint tempoint = [_btn convertPoint:point fromView:self];
        if (CGRectContainsPoint(_btn.bounds, tempoint))
        {
            view = _btn;
        }
    }
    return view;
}


@end
