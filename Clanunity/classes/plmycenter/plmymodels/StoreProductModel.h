//
//  StoreProductModel.h
//  PlamLive
//
//  Created by Mac on 16/12/12.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "PLBaseModel.h"

@interface StoreProductModel : PLBaseModel

//产品标识
@property(nonatomic,copy)NSString *uuid;
//产品名称
@property(nonatomic,copy)NSString *productname;
//价格
@property(nonatomic,copy)NSString *price;
//属性
@property(nonatomic,copy)NSString *attributes;
//店铺图片地址
@property(nonatomic,copy)NSString *productimgurl;
//发布 创建
@property(nonatomic,copy)NSString *flag;
//品牌
@property(nonatomic,copy)NSString *brand;





@end
