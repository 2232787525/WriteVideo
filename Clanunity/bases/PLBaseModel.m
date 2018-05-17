//
//  PLBaseModel.m
//  PlamLive
//
//  Created by wangyadong on 2016/10/20.
//  Copyright © 2016年 wangyadong. All rights reserved.
//



#import "PLBaseModel.h"

@implementation PLBaseModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    self =[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
-(void)setNilValueForKey:(NSString *)key{
    NSLog(@"%@",key);
}




@end
