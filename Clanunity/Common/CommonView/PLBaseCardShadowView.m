//
//  PLBaseCardShadowView.m
//  Clanunity
//
//  Created by wangyadong on 2017/6/9.
//  Copyright © 2017年 duolaimi. All rights reserved.
//

#import "PLBaseCardShadowView.h"

@implementation PLBaseCardShadowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
//        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.1;
        self.layer.shadowRadius = 1.5f;
        self.layer.shadowOffset = CGSizeMake(0, 1.5);
        
    }
    return self;
}


@end
