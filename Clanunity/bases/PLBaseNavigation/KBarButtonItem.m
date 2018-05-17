//
//  KBarButtonItem.m
//  PlamLive
//
//  Created by wangyadong on 2016/10/21.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "KBarButtonItem.h"


@interface KBarButtonItem ()

@property(nonatomic, strong) UIImage *buttonImage;
@property (nonatomic, copy) void (^actionBlock)(id);



@end


@implementation KBarButtonItem



- (instancetype)initWithCustomView:(UIView *)view
{
    if (self = [super init]) {
        
        
        view.height_sd = KNavigationBarHeight;
        _button = (UIButton *)view;
        _customView = view;
        view.height_sd = view.height_sd>KNavigationBarHeight?KNavigationBarHeight:view.height_sd;;

        view.centerY_sd = KStatusBarHeight + KNavigationBarHeight / 2.0;
        
        view.width_sd = view.width_sd;
    }
    
    return self;
}


-(instancetype)initWithTitle:(NSString *)title style:(KBarButtonItemStyle)style handler:(void(^)(id send)) action
{
    if (self = [super init]) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button sizeToFit];
        button.centerY_sd = KStatusBarHeight + KNavigationBarHeight / 2.0;
        _button = button;
        _customView = button;
        if (style == KBarButtonItemStyleBordered) {
            button.layer.cornerRadius = 4.0f;
            button.layer.borderColor = [UIColor whiteColor].CGColor;
            button.layer.borderWidth = 0.5f;
            button.layer.masksToBounds = YES;
        }else if (style == KBarButtonItemStylePlain){
            
            
        }else if (style == KBarButtonItemStyleDone){
            
            
        }else if (style == KBarButtonItemStyleLeft){
            
            
        }else if (style == KBarButtonItemStyleRight){
            [button setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        }else{
            
        }
        
        _actionBlock = action;
        
        [button addTarget:self action:@selector(handleTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(handleTouchDown:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(handleTouchUp:) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchUpOutside|UIControlEventTouchDragOutside];
        button.height_sd = 44;
        CGSize size = [PLGlobalClass sizeWithText:title font:[UIFont systemFontOfSize:13] width:MAXFLOAT height:44];
        button.width_sd = 44;
        if (size.width>44) {
            button.width_sd = size.width;
        }

        
    }
    
    return self;
}


-(instancetype)initWithImage:(UIImage *)image  style:(KBarButtonItemStyle)style handler:(void(^)(id send)) action
{
    if (self = [super init]) {
        
        _buttonImage = image ;
        
        UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:image forState:UIControlStateHighlighted];
        [button sizeToFit];
        button.centerY_sd = KStatusBarHeight + KNavigationBarHeight / 2.0;
        _button = button;
        _customView = button;
        _actionBlock = action;
        if (style == KBarButtonItemStyleBordered) {
            button.layer.cornerRadius = 4.0f;
            button.layer.borderColor = [UIColor whiteColor].CGColor;
            button.layer.borderWidth = 0.5f;
            button.layer.masksToBounds = YES;
        }else if (style == KBarButtonItemStylePlain){
            
            
        }else if (style == KBarButtonItemStyleDone){
            
            
        }else if (style == KBarButtonItemStyleLeft){
            [button setContentEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
        }else if (style == KBarButtonItemStyleRight){
            [button setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -5)];
        }else{
            
        }
        
        [button addTarget:self action:@selector(handleTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(handleTouchDown:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(handleTouchUp:) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchUpOutside|UIControlEventTouchDragOutside];
        button.height_sd = 44;
        button.width_sd = 44;
        if (image.size.width>44) {
            button.width_sd = image.size.width;
        }

        
    }
    
    return self;
}








#pragma mark - Private Methods

- (void)handleTouchUpInside:(UIButton *)button {
    if (_actionBlock) {
        _actionBlock(button);
    }
    [UIView animateWithDuration:0.2 animations:^{
        button.alpha = 1.0;
    }];
    
}

- (void)handleTouchDown:(UIButton *)button {
    
    button.alpha = 0.3;
    
}

- (void)handleTouchUp:(UIButton *)button {
    
    [UIView animateWithDuration:0.3 animations:^{
        button.alpha = 1.0;
    }];
    
}


- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    
    if (enabled) {
        _customView.userInteractionEnabled = YES;
        _customView.alpha = 1.0;
    } else {
        _customView.userInteractionEnabled = NO;
        _customView.alpha = 0.3;
    }
    
}




@end
