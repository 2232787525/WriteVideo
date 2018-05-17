//
//  HomeNaviBarView.h
//  PlamLive
//
//  Created by wangyadong on 2016/11/1.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "BaseRadarView.h"
typedef void(^AddressChooseBlock)();

typedef void(^BarButtonClicked)();

@interface HomeNaviBarView : BaseRadarView

@property(nonatomic,strong)UIView * firstAlphView;
@property(nonatomic,strong)UIView * secondAlphView;

@property(nonatomic,strong)UIView * rightFirst;

@property(nonatomic,strong)UIView * rightSecond;


/**
 导航栏 左按钮 地址名字
 */
@property(nonatomic,copy)NSString * leftAddressName;
/**
 导航栏 左按钮 地址显示切换

 @param addressB 点击地址到 地址列表
 @return view
 */
+(HomeNaviBarView*)homeNavLeftAddressWithClicked:(AddressChooseBlock)addressB;


#pragma mark - 导航栏 右按钮 两个按钮设置
/**
 导航栏 右边的按钮 2个按钮的设置   【firstBtn】【secondBtn】
 
 @param firstName 靠左的按钮 图片的名字
 @param firstB 靠左按钮触发事件
 @param secondName 靠右的按钮的图片名字
 @param secondB 靠右按钮触发事件
 @return view
 */
+(HomeNaviBarView*)navRightTwobarFirstImgName:(NSString*)firstName firstClicked:(BarButtonClicked)firstB secondImgName:(NSString*)secondName secondClicked:(BarButtonClicked)secondB;


@end
