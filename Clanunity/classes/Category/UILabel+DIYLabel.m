//
//  UILabel+DIYLabel.m
//  yunbo2016
//
//  Created by Hanks on 16/1/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UILabel+DIYLabel.h"

@implementation UILabel (DIYLabel)

+(UILabel *)labelWithText:(NSString*)text andFont:(CGFloat)font andTextColor:(UIColor *)color andTextAlignment:(NSTextAlignment)textAlignment
{
    UILabel *lable = [[UILabel alloc]init];
    [lable sizeToFit];
    lable.text = text;
    lable.font = [UIFont systemFontOfSize:font];
    if (color) {
        lable.textColor = color;
    }else
    {
//        lable.textColor = MainTextGrayColor;
        lable.textColor = [UIColor blackColor];
    }
    
    if (textAlignment) {
        lable.textAlignment = textAlignment;
    }
    
    return lable;
}

+(UILabel *)labelWithFrame:(CGRect)frame text:(NSString*)text font:(CGFloat)font textColor:(UIColor *)color andTextAlignment:(NSTextAlignment)textAlignment{
    UILabel *lable = [[UILabel alloc]init];
    [lable sizeToFit];
    if (text) {
        lable.text = text;
    }
    lable.frame = frame;
    lable.font = [UIFont systemFontOfSize:font];
    if (color) {
        lable.textColor = color;
    }
    if (textAlignment) {
        lable.textAlignment = textAlignment;
    }
    return lable;
}

+(UILabel *)labelFrame:(CGRect)frame text:(NSString*)text PLfont:(UIFont*)font textPLColor:(UIColor *)color andTextAlignment:(NSTextAlignment)textAlignment{
    UILabel *lable = [[UILabel alloc]init];
    [lable sizeToFit];
    if (text) {
        lable.text = text;
    }
    lable.frame = frame;
    if (font != nil) {
        lable.font = font;
    }else{
        lable.font = [UIFont systemFontOfSize:15];
    }
    if (color) {
        lable.textColor = color;
    }
    if (textAlignment) {
        lable.textAlignment = textAlignment;
    }
    return lable;
}

@end
