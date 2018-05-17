//
//  PLFuncItemView.h
//  PlamLive
//
//  Created by wangyadong on 2017/2/23.
//  Copyright © 2017年 wangyadong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLFuncModel;

@interface PLFuncItemView : UIView
@property(nonatomic,strong)UIImageView * itemImg;

@property(nonatomic,strong)UILabel * itemLabel;

@property(nonatomic,strong)UIButton * itemBtn;
@property(nonatomic,strong)PLFuncModel * model;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,copy)void(^itemClickedBlock)(PLFuncModel*model);
@end
