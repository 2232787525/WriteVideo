//
//  PLDetailsVC.h
//  PlamLive
//
//  Created by Mac on 16/11/3.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "PLBaseViewController.h"

@class NewsListModel;
@interface PLDetailsVC : PLBaseViewController

@property (nonatomic,strong)NewsListModel *detailsNewListmodel;
@property (nonatomic,assign)BOOL isHeadlines;


@end

