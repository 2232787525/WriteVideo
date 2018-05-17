//
//  KNavigationItem.h
//  PlamLive
//
//  Created by wangyadong on 2016/10/21.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KBarButtonItem;
@interface KNavigationItem : NSObject

@property (nonatomic, strong)   KBarButtonItem *leftBarButtonItem;
@property (nonatomic, strong)   KBarButtonItem *rightBarButtonItem;
@property (nonatomic, copy)     NSString        *title;
@property (nonatomic, strong)   UIFont          *font;
@property (nonatomic, strong)   UIView          *titleView;
@property (nonatomic ,strong)   UIColor         *titleColor;


@end
