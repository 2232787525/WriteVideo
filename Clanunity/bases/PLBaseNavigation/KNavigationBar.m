//
//  KNavigationBar.m
//  PlamLive
//
//  Created by wangyadong on 2016/10/21.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "KNavigationBar.h"

@implementation KNavigationBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.layer addSublayer: [PLHelp gradualChangeColorWithFrame:self.bounds startColor:[UIColor PLColorChangeStart12B06B] startPoint:CGPointMake(0, 1) endColor:[UIColor PLColorChangeStop3BA839] endPoint:CGPointMake(1, 1)]];
        self.tintColor   = [UIColor PLColorFFFFFF_white];
       
    }
    return self;
}

- (instancetype)init {
    
    return [self initWithFrame:CGRectMake(0, 0, KScreenWidth, KTopHeight)];
}



@end
