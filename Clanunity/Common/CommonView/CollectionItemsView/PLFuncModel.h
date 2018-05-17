//
//  PLFuncModel.h
//  PlamLive
//
//  Created by wangyadong on 2017/2/23.
//  Copyright © 2017年 wangyadong. All rights reserved.
//

#import "PLBaseModel.h"
#import "JCF_ModelProtocol.h"

@interface PLFuncModel : PLBaseModel<JCF_ModelProtocol>
@property(nonatomic,copy)NSString * code;

/**
 本地图片名字
 */
@property(nonatomic,copy)NSString * imgurl;
@property(nonatomic,copy)NSString * imgUrl_Seleted;

@property(nonatomic,copy)NSString * name;

@property(nonatomic,copy)NSString * itemUuid;

@property(nonatomic,assign)NSInteger type;

@property(nonatomic,copy)NSString * url;

@property(nonatomic,assign)NSInteger id;

@property(nonatomic,strong)NSMutableArray * dataArray;
//兑换所需的掌币
@property(nonatomic,assign)NSInteger remark;
@end
