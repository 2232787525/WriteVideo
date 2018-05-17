//
//  FuncItemsView.h
//  PlamLive
//
//  Created by wangyadong on 2017/2/23.
//  Copyright © 2017年 wangyadong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLFuncModel.h"
#import "PLFuncItemView.h"

@interface FuncItemsView : UIScrollView

@property(nonatomic,strong)NSArray<PLFuncModel*> * dataArray;

@property(nonatomic,assign)CGFloat viewHieght;

@property(nonatomic,copy)void(^itemClickedBlock)(PLFuncModel*model);

@end
