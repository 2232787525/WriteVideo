//
//  UIView+WDKit.h
//  WDKit
//
//  Created by 何伟东 on 2016/10/10.
//  Copyright © 2016年 何伟东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WDKit)


/**
 视图坐标
 */
@property CGPoint origin_sd;

/**
 视图大小
 */
@property CGSize size_sd;

/**
 y坐标
 */
@property (nonatomic) CGFloat left_sd;

/**
 x坐标
 */
@property (nonatomic) CGFloat top_sd;


/**
 宽度
 */
@property CGFloat width_sd;

/**
 高度
 */
@property CGFloat height_sd;

/**
 右边x坐标
 */
@property CGFloat right_sd;

/**
 底部y坐标
 */
@property CGFloat bottom_sd;

/**
 中心x坐标
 */
@property (nonatomic) CGFloat centerX_sd;

/**
 中心y坐标
 */
@property (nonatomic) CGFloat centerY_sd;

/**
 *  通过响应者链找到view的viewController
 *
 *  @return <#return value description#>
 */
-(UIViewController *)viewController;
//删除图片,view
- (void)removeAllSubviews;


/**
 view截图
 
 @return <#return value description#>
 */
- (UIImage *)convertToScreenScaleImage;

/**
 view截图
 
 @return <#return value description#>
 */
- (UIImage *)convertToImageWithScale:(CGFloat)scale;
/**
 设置边框

 @param width 宽度
 @param color 颜色
 */
- (void)setBorderWidth:(CGFloat)width color:(UIColor *)color;

/**
 设置圆角

 @param cornerRadius 度数
 */
- (void)setCornerRadius:(CGFloat)cornerRadius;

@end
