//
//  NavigationBarView.h
//  Hero -LOL
//
//  Created by wyd on 16/1/21.
//  Copyright © 2016年 wyd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationBarView : UIView
/**顶部分割线，底部分割线，默认是clearclolor */
@property(nonatomic,strong)UIColor * topLineColor;
@property(nonatomic,strong)UIColor * bottomLineColor;
@property(nonatomic,strong)UIColor * sliderColor;
@property (nonatomic,strong) UIScrollView *barScroll;  //顶部ScrollView
//点击按钮 改变mainScroll的偏移量回调
@property (nonatomic,copy) void(^changeMainBlock)(NSInteger);
@property (nonatomic,copy) void(^changeClickedBlock)(NSInteger fromIndex,NSInteger toIndex);

@property (nonatomic,assign) NSInteger curruntNum;//记录当前点击的按钮

@property(nonatomic,strong)NSArray * segmentArray;

-(void)changeSelectedIndex:(NSInteger)index;

- (instancetype)initWithFrame:(CGRect)frame withSegmentArray:(NSArray*)segmentArr;

@end

