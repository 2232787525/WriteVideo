//
//  PLLoginViewController.h
//  Clanunity
//
//  Created by zfy_srf on 2017/4/5.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

#import "PLBaseViewController.h"

@interface PLLoginViewController : PLBaseViewController
@property(nonatomic,copy)void(^loginSuccessBlock)(BOOL loginSuccess);
@end
