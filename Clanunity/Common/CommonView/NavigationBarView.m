//
//  NavigationBarView.m
//  Hero -LOL
//
//  Created by wyd on 16/1/21.
//  Copyright © 2016年 wyd. All rights reserved.
//

#import "NavigationBarView.h"

#define BtnNormalFONT 16
#define BtnSelectedFONT (18)
#define BtnFlagTag 12306
@interface NavigationBarView (){
    UIView*_topL;
    UIView*_bottomL;
}
@property(nonatomic,strong)UIScrollView * bottomScroll;
@property(nonatomic,strong)UIView * sliderLine;
@property(nonatomic,assign)NSInteger fromIndex;

@end


@implementation NavigationBarView

#pragma mark -- 重写initWithFrame
- (instancetype)initWithFrame:(CGRect)frame withSegmentArray:(NSArray*)segmentArr{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *topl = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 0.5)];
        topl.backgroundColor = [UIColor clearColor];
        [self addSubview:topl];
        _topL = topl;
        
        UIView *bottoml = [[UIView alloc] initWithFrame:CGRectMake(0, self.height_sd-0.5, KScreenWidth, 0.5)];
        bottoml.backgroundColor = [UIColor clearColor];
        [self addSubview:bottoml];
        _bottomL = bottoml;
        
        self.barScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(5,0.5, KScreenWidth-10, self.height_sd-2)];
        self.barScroll.showsVerticalScrollIndicator = NO;
        self.barScroll.showsHorizontalScrollIndicator = NO;
        self.barScroll.pagingEnabled = NO;
        self.barScroll.bounces = YES;
        [self addSubview:self.barScroll];

        self.bottomScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(self.barScroll.left_sd, 0, self.barScroll.width_sd, 2)];
        self.bottomScroll.bottom_sd = self.height_sd-0.5;
        self.bottomScroll.backgroundColor = [UIColor clearColor];
        self.bottomScroll.showsVerticalScrollIndicator = NO;
        self.bottomScroll.showsHorizontalScrollIndicator = NO;
        self.bottomScroll.pagingEnabled = NO;
        self.bottomScroll.bounces = YES;
        [self addSubview:self.bottomScroll];
        self.sliderLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, self.bottomScroll.height_sd)];
        [self.bottomScroll addSubview:self.sliderLine];
        self.sliderLine.backgroundColor = [UIColor clearColor];
        
        self.segmentArray = segmentArr;
    }
    return self;
}
-(void)setTopLineColor:(UIColor *)topLineColor{
    _topLineColor = topLineColor;
    _topL.backgroundColor = topLineColor;
}
-(void)setBottomLineColor:(UIColor *)bottomLineColor{
    _bottomLineColor = bottomLineColor;
    _bottomL.backgroundColor = bottomLineColor;
}
-(void)setSliderColor:(UIColor *)sliderColor{
    _sliderColor = sliderColor;
    self.sliderLine.backgroundColor = sliderColor;
}
-(void)setSegmentArray:(NSArray *)segmentArray{
    _segmentArray = segmentArray;
    [self createButtons];    
}
#pragma mark -- 创建按钮
- (void)createButtons{
    [self.barScroll removeAllSubviews];
    CGFloat btnWidth = KScreenWidth/self.segmentArray.count;
    CGFloat btnRight = 0;
    __weak typeof(self)weakSelf = self;
    for (NSInteger idx = 0; idx < self.segmentArray.count; idx++) {
        NSString *obj = self.segmentArray[idx];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //(K_Screen_W-34)/5.0 按钮的宽度
        btn.frame = CGRectMake(btnRight, 0, btnWidth,weakSelf.barScroll.height_sd);
        btn.tag = BtnFlagTag+idx;
        //设置标题
        [btn setTitle:obj forState:UIControlStateNormal];
        //设置正常状态下标题的颜色
        [btn setTitleColor:[UIColor PLColor666666] forState:UIControlStateNormal];
        //设置选中状态下标题的颜色
        [btn setTitleColor:[UIColor PLColor12B06B_Theme] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:BtnNormalFONT];
        
        CGSize size = [PLGlobalClass sizeWithText:obj font:btn.titleLabel.font width:MAXFLOAT height:20];
        if (size.height+10 > btnWidth) {
            btn.width_sd = size.width+10;
        }
        btnRight =  btn.right_sd;
        if (btn.right_sd > self.barScroll.width_sd) {
            self.barScroll.contentSize = CGSizeMake(btn.right_sd, self.barScroll.height_sd);
        }
        //注册点击事件 点击btn切换界面
        [btn addTarget:self action:@selector(clickSubBtn:) forControlEvents:UIControlEventTouchUpInside];
        //把按钮添加到barScroll上
        [self.barScroll addSubview:btn];
        if (idx == 0) {
            self.fromIndex = 0;
            [self changeSelectedIndex:idx];
        }
        
        
    }
}
#pragma mark -- 滚动视图内按钮的点击事件
- (void)clickSubBtn:(UIButton *)btn{
    [self changeSelectedIndex:btn.tag-BtnFlagTag];
}
-(void)changeSelectedIndex:(NSInteger)index{
    
    UIButton *lastBtn = (UIButton*)[self.barScroll viewWithTag:self.curruntNum+BtnFlagTag];
    if (lastBtn) {
        lastBtn.selected = NO;
        lastBtn.titleLabel.font = [UIFont systemFontOfSize:BtnNormalFONT];
    }
    UIButton *currentBtn = (UIButton*)[self.barScroll viewWithTag:index+BtnFlagTag];
    if (currentBtn) {
        self.curruntNum = index;
        currentBtn.selected = YES;
        currentBtn.titleLabel.font = [UIFont boldSystemFontOfSize:BtnSelectedFONT];
        
        [UIView animateWithDuration:0.15 animations:^{
            self.sliderLine.width_sd = [PLGlobalClass sizeWithText:currentBtn.titleLabel.text font:currentBtn.titleLabel.font width:MAXFLOAT height:20].width+10;
            self.sliderLine.centerX_sd = currentBtn.centerX_sd;

        }];
    }
    
    if (self.changeClickedBlock) {
        self.changeClickedBlock(self.fromIndex, index);
        
    }
    self.fromIndex = index;
    //2.大的滚动视图的偏移量发生改变
    if (self.changeMainBlock) {
        self.changeMainBlock((index));
    }
    
}



@end


