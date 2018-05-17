//
//  ThirdResultUserModel.h
//  PlamLive
//
//  Created by wangyadong on 2016/11/24.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "PLBaseModel.h"

@interface ThirdResultUserModel : PLBaseModel

@end


@interface ThirdResultQQModel : ThirdResultUserModel

@property(nonatomic,copy)NSString * yellow_vip_level;
@property(nonatomic,copy)NSString * vip;
@property(nonatomic,copy)NSString * ret;
@property(nonatomic,copy)NSString * province;
@property(nonatomic,copy)NSString * nickname;
@property(nonatomic,copy)NSString * msg;
@property(nonatomic,copy)NSString * level;
@property(nonatomic,copy)NSString * is_yellow_year_vip;
@property(nonatomic,copy)NSString * is_yellow_vip;
@property(nonatomic,copy)NSString * is_lost;
@property(nonatomic,copy)NSString * gender;
@property(nonatomic,copy)NSString * figureurl_qq_2;
@property(nonatomic,copy)NSString * figureurl_qq_1;
@property(nonatomic,copy)NSString * figureurl_2;
@property(nonatomic,copy)NSString * figureurl_1;
@property(nonatomic,copy)NSString * figureurl;
@property(nonatomic,copy)NSString * city;

@end

@interface ThirdResultWeChatModel : ThirdResultUserModel
@property(nonatomic,copy)NSString * city;
@property(nonatomic,copy)NSString * country;
@property(nonatomic,copy)NSString * headimgurl;
@property(nonatomic,copy)NSString * language;
@property(nonatomic,copy)NSString * nickname;
@property(nonatomic,copy)NSString * openid;
@property(nonatomic,strong)NSArray * privilege;
@property(nonatomic,copy)NSString * province;
@property(nonatomic,assign)NSInteger sex;
@property(nonatomic,copy)NSString * unionid;

@end
