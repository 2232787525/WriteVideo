//
//  AreaCityManager.m
//  Clanunity
//
//  Created by wangyadong on 2017/8/11.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

#import "AreaCityManager.h"


static AreaCityManager  * manager = nil;

@implementation AreaCityManager

+(instancetype)shareAreaManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AreaCityManager alloc] init];
    });
    return manager;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        NSString* path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
        if(path.length <= 0) {
            return nil;
        }
        
        NSData* data = [NSData dataWithContentsOfFile:path];
        NSArray * JsonObjectArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.cityList = [Area_City_Model mj_objectArrayWithKeyValuesArray:JsonObjectArray];
        for (Area_City_Model *model in self.cityList) {
            if (model.children.count>0) {
                NSLog(@"%@",model.children);
            }
        }
    }
    return self;
}

@end



@implementation Area_City_Model
+(NSDictionary*)mj_objectClassInArray{
    return @{@"children":[Area_City_Model class]};
}
@end
