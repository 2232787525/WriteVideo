//
//  RecordVideoViewController.h
//  KZWeChatSmallVideo_OC
//
//  Created by wangyadong on 2017/8/18.
//  Copyright © 2017年 侯康柱. All rights reserved.
//

#import "PLBaseViewController.h"
@class KZVideoModel;
@interface RecordVideoViewController : PLBaseViewController

@property(nonatomic,copy)void(^finishVideoBlock)(KZVideoModel*model);

@end
