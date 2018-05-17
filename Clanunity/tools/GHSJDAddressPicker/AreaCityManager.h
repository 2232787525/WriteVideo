//
//  AreaCityManager.h
//  Clanunity
//
//  Created by wangyadong on 2017/8/11.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Area_City_Model;
@interface AreaCityManager : NSObject

+(instancetype)shareAreaManager;

@property(nonatomic,strong)NSArray<Area_City_Model*> * cityList;


@end


@interface Area_City_Model : PLBaseModel

@property(nonatomic,copy)NSString * code;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,strong)NSArray<Area_City_Model*> * children;

@end
