//
//  KNavigationItem.m
//  PlamLive
//
//  Created by wangyadong on 2016/10/21.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "KNavigationItem.h"
#import "KBarButtonItem.h"
#import "KNavigationBar.h"
#import "UIViewController+KNavigationConfig.h"

@interface KNavigationItem ()

@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, assign) UIViewController *kviewController;

@end


@implementation KNavigationItem

-(void)setFont:(UIFont *)font
{
    _font = font;
    
    if (!font) {
        _titleLabel.font = [UIFont PLFont16];
    }else
    {
        _titleLabel.font = _font;
    }
    
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    
    if (!title) {
        _titleLabel.text = @"";
        return;
    }
    
    if ([title isEqualToString:_titleLabel.text]) {
        return;
    }
    CGSize size = [PLGlobalClass sizeWithText:title font:[UIFont boldSystemFontOfSize:PLFONT_HUGE] width:MAXFLOAT height:MAXFLOAT];
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel sizeToFit];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:PLFONT_HUGE]];
        [_titleLabel setTextColor:[UIColor plNavTitleColor]];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;        
        [_kviewController.knavigationBar addSubview:_titleLabel];
        
         _titleView= _titleLabel;
    }
    _titleView.frame = CGRectMake(0, 0,size.width>(KScreenWidth - 100)?(KScreenWidth - 100):size.width , size.height);
    _titleView.centerX_sd =_kviewController.knavigationBar.width_sd/2.0;
    _titleView.centerY_sd = _kviewController.knavigationBar.height_sd/2.0+KStatusBarHeight / 2;
    
    _titleLabel.text = title;
}
- (void)setLeftBarButtonItem:(KBarButtonItem *)leftBarButtonItem {
    if (_kviewController) {
        [_leftBarButtonItem.customView removeFromSuperview];
        [_kviewController.knavigationBar addSubview:leftBarButtonItem.customView];
        leftBarButtonItem.customView.left_sd = 10;
        leftBarButtonItem.customView.centerY_sd =_kviewController.knavigationBar.height_sd/2.0+KStatusBarHeight / 2;
    }
    
    _leftBarButtonItem = leftBarButtonItem;
}
- (void)setRightBarButtonItem:(KBarButtonItem *)rightBarButtonItem {
    
    if (_kviewController) {
        [_rightBarButtonItem.customView removeFromSuperview];
        [_kviewController.knavigationBar addSubview:rightBarButtonItem.customView];
        rightBarButtonItem.customView.right_sd =_kviewController.knavigationBar.width_sd-10;
        rightBarButtonItem.customView.centerY_sd =_kviewController.knavigationBar.height_sd/2.0+KStatusBarHeight / 2;
    }
    
    _rightBarButtonItem = rightBarButtonItem;
}
- (void)setTitleView:(UIView *)titleView {
    [_titleLabel removeFromSuperview];
    _titleLabel = nil;
    _title = nil;
    CGSize size = titleView.frame.size;
    if (_kviewController) {
        [_kviewController.knavigationBar addSubview:titleView];
        titleView.centerY_sd =_kviewController.knavigationBar.height_sd/2.0+KStatusBarHeight / 2;
        titleView.size_sd = size;
        titleView.centerX_sd =_kviewController.knavigationBar.width_sd/2.0;
    }
    _titleView = titleView;
}

-(void)setTitleColor:(UIColor *)titleColor
{
    if (_titleLabel) {
        _titleLabel.textColor = titleColor;
    }
}

@end
