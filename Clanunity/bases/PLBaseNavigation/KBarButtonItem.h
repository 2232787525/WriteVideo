//
//  KBarButtonItem.h
//  PlamLive
//
//  Created by wangyadong on 2016/10/21.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, KBarButtonItemStyle){
    
    KBarButtonItemStyleDone,
    KBarButtonItemStylePlain,
    KBarButtonItemStyleBordered,
    KBarButtonItemStyleRight,
    KBarButtonItemStyleLeft,
    
};

@interface KBarButtonItem : NSObject
@property(nonatomic, strong) UIView   *customView;
@property(nonatomic, strong) UIButton *button;
@property(nonatomic, assign, getter = isEnabled) BOOL enabled;

-(instancetype)initWithTitle:(NSString *)title style:(KBarButtonItemStyle)style  handler:(void(^)(id send)) action;


-(instancetype)initWithImage:(UIImage *)image  style:(KBarButtonItemStyle)style handler:(void(^)(id send)) action;
- (instancetype)initWithCustomView:(UIView *)view;

@end
