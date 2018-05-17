//
//  PLNewsViewVC.h
//  PlamLive
//
//  Created by wangyadong on 2016/10/31.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "PageBaseVC.h"

UIKIT_EXTERN NSNotificationName const ChildScrollViewDidScrollNSNotification;
UIKIT_EXTERN NSNotificationName const ChildScrollViewRefreshStateNSNotification;



@interface PLNewsViewVC : PageBaseVC

@property(nonatomic,copy)void(^pulldownRefreshBlock)();

@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,assign)NSInteger catetype;
+(void)cacheFirstPageListWithDataArray:(NSArray*)list cateType:(NSInteger)type;

@end

