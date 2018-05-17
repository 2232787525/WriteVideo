//
//  PLFuncItemView.m
//  PlamLive
//
//  Created by wangyadong on 2017/2/23.
//  Copyright © 2017年 wangyadong. All rights reserved.
//

#import "PLFuncItemView.h"
#import "PLFuncModel.h"
@implementation PLFuncItemView

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
        self.itemImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,5*kScreenScale,60*kScreenScale,60*kScreenScale)];
        [self addSubview:self.itemImg];
        self.itemImg.centerX_sd = self.width_sd/2.0;
        self.itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.itemImg.bottom_sd+5*kScreenScale, self.width_sd,20*kScreenScale)];
        self.itemLabel.textColor = [UIColor PLColorBlack];
        self.itemLabel.font = [UIFont PLFont14];
        [self addSubview:self.itemLabel];
        self.itemLabel.textAlignment = NSTextAlignmentCenter;
        
        self.height_sd = self.itemLabel.bottom_sd+10*kScreenScale;
        self.itemBtn = [[UIButton alloc] initWithFrame:self.bounds];
        [self addSubview:self.itemBtn];
        __weak typeof(self)weakSelf = self;
        [self.itemBtn handleEventTouchUpInsideWithBlock:^{
            if (weakSelf.itemClickedBlock) {
                weakSelf.itemClickedBlock(weakSelf.model);
            }
        }];
    }
    return self;
}

-(void)setModel:(PLFuncModel *)model{
    _model = model;
    
    if ([model.imgurl hasPrefix:@"http"]) {
        
        [self.itemImg sd_setImageWithURL:[NSURL URLWithString:model.imgurl] placeholderImage:[UIImage imageNamed:PLACE_SQUAREIMG]];        
    } else {
        UIImage *image = [UIImage imageNamed:model.imgurl];
        if (!image) {
            [UIImage imageWithContentsOfFile:model.imgurl];
        }
        self.itemImg.image = image;
    }
    self.itemLabel.text = model.name;
}


@end
