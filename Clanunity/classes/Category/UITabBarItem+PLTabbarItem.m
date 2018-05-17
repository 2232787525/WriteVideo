//
//  UITabBarItem+PLTabbarItem.m
//  Clanunity
//
//  Created by wangyadong on 2017/7/19.
//  Copyright © 2017年 duolaimi. All rights reserved.
//

#import "UITabBarItem+PLTabbarItem.h"

@implementation UITabBarItem (PLTabbarItem)

-(void)topStatus:(NSInteger)status{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:@(status) forKey:[NSString stringWithFormat:@"UITabBarItem%ld",self.tag]];
    [user synchronize];
    NSLog(@"%@",@(status));
    
    
}
-(NSInteger)topStatus{
     NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
   NSNumber *status = [user objectForKey:[NSString stringWithFormat:@"UITabBarItem%ld",self.tag]];
    return [status integerValue];
}
@end
