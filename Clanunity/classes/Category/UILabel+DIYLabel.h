//
//  UILabel+DIYLabel.h
//  yunbo2016
//
//  Created by Hanks on 16/1/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (DIYLabel)

+(UILabel * _Nonnull)labelWithText:(NSString * _Nullable)text andFont:(CGFloat)font andTextColor:(UIColor * _Nullable)color andTextAlignment:(NSTextAlignment)textAlignment;

+(UILabel *_Nonnull)labelWithFrame:(CGRect)frame text:(NSString*_Nullable)text font:(CGFloat)font textColor:(UIColor *_Nullable)color andTextAlignment:(NSTextAlignment)textAlignment;

+(UILabel *_Nonnull)labelFrame:(CGRect)frame text:(NSString*_Nullable)text PLfont:(UIFont*_Nullable)font textPLColor:(UIColor *_Nullable)color andTextAlignment:(NSTextAlignment)textAlignment;


@end
