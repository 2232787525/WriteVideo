//
//  UIView+WDKit.m
//  WDKit
//
//  Created by 何伟东 on 2016/10/10.
//  Copyright © 2016年 何伟东. All rights reserved.
//

#import "UIView+WDKit.h"

@implementation UIView (WDKit)

/**
 视图坐标
 */
-(CGPoint)origin_sd{
    return self.frame.origin;
}

/**
 设置origin
 */
-(void)setOrigin_sd:(CGPoint)origin_sd{
    CGRect newframe = self.frame;
    newframe.origin = origin_sd;
    self.frame = newframe;
}

/**
 视图大小
 */
-(CGSize)size_sd{
    return self.frame.size;
}

/**
 设置视图大小
 */
-(void)setSize_sd:(CGSize)size_sd{
    CGRect newframe = self.frame;
    newframe.size = size_sd;
    self.frame = newframe;
}

/**
 x坐标
 */
-(CGFloat)left_sd{
    return self.frame.origin.x;
}

/**
 设置x坐标
 */
-(void)setLeft_sd:(CGFloat)left_sd{
    
    if(isnan(left_sd)){      //isnan为系统函数
        //you code
        left_sd = 0.0;
    }
    else {
        CGRect tempFrame = self.frame;
        tempFrame.origin.x = left_sd;
        self.frame = tempFrame;
    }
}
/**
 y坐标
 */
-(CGFloat)top_sd{
    return self.frame.origin.y;
}

/**
 设置y坐标
 */
-(void)setTop_sd:(CGFloat)top_sd{
    
    if(isnan(top_sd)){      //isnan为系统函数
        //you code
        top_sd = 0.0;
    }
    else {
        
        CGRect tempFrame = self.frame;
        tempFrame.origin.y = top_sd;
        self.frame = tempFrame;
    }
}

/**
 宽度
 */
-(CGFloat)width_sd{
    return self.frame.size.width;
}

/**
 设置宽度
 */
-(void)setWidth_sd:(CGFloat)width_sd{

    if(isnan(width_sd)){      //isnan为系统函数
        //you code
        width_sd = 0.0;
    }
    else {
        
        CGRect tempFrame = self.frame;
        tempFrame.size.width = width_sd;
        self.frame = tempFrame;
    }
}

/**
 高度
 */
-(CGFloat)height_sd{
    return self.frame.size.height;
}

/**
 设置高度
 */
-(void)setHeight_sd:(CGFloat)height_sd{
    
    if (isnan(height_sd)) {
        height_sd = 0.0;
    }
    else
    {
    
      CGRect tempFrame = self.frame;
      tempFrame.size.height = height_sd;
      self.frame = tempFrame;
    }
}

/**
 右边x坐标
 */
-(CGFloat)right_sd{
    return self.frame.origin.x + self.frame.size.width;
}

/**
 设置右边x坐标
 */
-(void)setRight_sd:(CGFloat)right_sd{
    
    if (isnan(right_sd)) {
        right_sd = 0.0;
    }
    else
    {
       CGRect newframe = self.frame;
       newframe.origin.x = right_sd - newframe.size.width;
       self.frame = newframe;
    }
}

/**
 底部y坐标
 */
-(CGFloat)bottom_sd{
    return self.frame.origin.y + self.frame.size.height;
}

/**
 设置底部y坐标
 */
-(void)setBottom_sd:(CGFloat)bottom_sd{
    
    if (isnan(bottom_sd)) {
        
        bottom_sd = 0.0;
    }
    else
    {
       CGRect tempFrame = self.frame;
       tempFrame.origin.y = bottom_sd - tempFrame.size.height;
       self.frame = tempFrame;
    }
}

/**
 中心x坐标
 */
-(CGFloat)centerX_sd{
    return self.center.x;
}

/**
 设置中心x坐标
 */
-(void)setCenterX_sd:(CGFloat)centerX_sd{
    CGPoint newCenter = self.center;
    newCenter.x = centerX_sd;
    self.center = newCenter;
}

/**
 中心y坐标

 @return <#return value description#>
 */
-(CGFloat)centerY_sd{
    return self.center.y;
}

/**
 设置中心y坐标
 */
-(void)setCenterY_sd:(CGFloat)centerY_sd{
    CGPoint newCenter = self.center;
    newCenter.y = centerY_sd;
    self.center = newCenter;
}

/**
 *  通过响应者链找到view的viewController
 *
 *  @return <#return value description#>
 */
-(UIViewController *)viewController{
    UIResponder *next = self.nextResponder;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    }
    return nil;
}

- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        if ([child isKindOfClass:[UIImageView class]]) {
            ((UIImageView*)child).image = nil;
        }
        [child removeFromSuperview];
        child = nil;
    }
}


/**
 view截图
 
 @return <#return value description#>
 */
- (UIImage *)convertToScreenScaleImage{
    return [self convertToImageWithScale:[UIScreen mainScreen].scale];
}

/**
 view截图
 
 @return <#return value description#>
 */
- (UIImage *)convertToImageWithScale:(CGFloat)scale{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.width_sd, self.height_sd), NO,scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 设置边框
 
 @param width 宽度
 @param color 颜色
 */
- (void)setBorderWidth:(CGFloat)width color:(UIColor *)color{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

/**
 设置圆角
 
 @param cornerRadius 度数
 */
- (void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

@end
