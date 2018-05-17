//
//  PLBaseModel.h
//  PlamLive
//
//  Created by wangyadong on 2016/10/20.
//  Copyright © 2016年 wangyadong. All rights reserved.
//
/*
 
 + (NSString *)mainKey{
 return @"ID";
 }
 
 +(NSArray *)transients{
 return nil;
 }
 
 -(NSString *)mainKey{
 return @"ID";
 }
 
 
 */

#import <Foundation/Foundation.h>

@interface PLBaseModel : NSObject

-(instancetype)initWithDic:(NSDictionary*)dic;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
