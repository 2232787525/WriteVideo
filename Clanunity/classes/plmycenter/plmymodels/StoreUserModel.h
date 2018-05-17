//
//  StoreUserModel.h
//  PlamLive
//
//  Created by Mac on 16/12/9.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "PLBaseModel.h"

@interface StoreUserModel : PLBaseModel


/*
 address = "\U957f\U98ce\U753b\U5377";
 closetime = 1451656800000;
 flag = 1200;
 imgurl = "http://zfy.netminer.cn/ysjapp/serverimg/sellerimg/20161208/sellerimg1481183615321.png";
 introduction = "\U5403\Uff0c\U5403\Uff0c\U5403\U3002";
 lati = "37.81456";
 level = "<null>";
 logo = "http://zfy.netminer.cn/ysjapp/serverimg/shoplogo/20161208/shoplogo1481183615259.png";
 lon = "112.558599";
 opentime = 1451606400000;
 remark = "<null>";
 score = "<null>";
 sellername = "\U9a6c\U8bb0\U5c0f\U5403";
 tele = 15366668888;
 trans = "<null>";
 type = 2022;
 typeimg = "<null>";
 typename = "<null>";
 uuid = cd777575ab5b4a8688810c483d1957f0;
 */

//地址
@property(nonatomic,copy)NSString *address;
//营业结束时间
@property(nonatomic,copy)NSString *closetime;
//标记
@property(nonatomic,copy)NSString *flag;
//店铺地址
@property(nonatomic,copy)NSString *imgurl;
//商家介绍
@property(nonatomic,copy)NSString *introduction;
//经度
@property(nonatomic,copy)NSString *lati;
//纬度
@property(nonatomic,copy)NSString *lon;
//水平
@property(nonatomic,copy)NSString *level;
//店家logo照片
@property(nonatomic,copy)NSString *logo;
//营业开始时间
@property(nonatomic,copy)NSString *opentime;
//备注
@property(nonatomic,copy)NSString *remark;
//分数
@property(nonatomic,copy)NSString *score;
//电话
@property(nonatomic,copy)NSString *tele;
//反识
@property(nonatomic,copy)NSString *trans;
//类型
@property(nonatomic,copy)NSString *type;
//类型图片
@property(nonatomic,copy)NSString *typeimg;
//类型名字
@property(nonatomic,copy)NSString *typename;
//唯一标示
@property(nonatomic,copy)NSString *uuid;
//店铺名称
@property(nonatomic,copy)NSString *sellername;





@end

