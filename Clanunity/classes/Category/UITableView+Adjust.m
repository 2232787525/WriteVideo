//
//  UITableView+Adjust.m
//  Clanunity
//
//  Created by wangyadong on 2017/10/11.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

#import "UITableView+Adjust.h"

@implementation UITableView (Adjust)

-(void)adjustEstimatedHeight{
    
    if (@available(iOS 11.0, *)) {
        self.estimatedRowHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
    }
}


@end
