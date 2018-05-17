//
//  NSObject+Common.m
//  Property
//
//  Created by 何伟东 on 16/2/16.
//  Copyright © 2016年 乐家园. All rights reserved.
//

#import "NSObject+Common.h"
#import <objc/runtime.h>
@implementation NSObject (Common)


/**
 *  字典转json
 *
 *  @return json字符串
 */
- (NSString *)JSONRepresentation{
    if ([self isKindOfClass:[NSMutableDictionary class]] || [self isKindOfClass:[NSDictionary class]] || [self isKindOfClass:[NSArray class]] || [self isKindOfClass:[NSMutableArray class]]) {
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
        if (parseError) {
            NSLog(@"字典解析成json失败：%@",parseError);
            return nil;
        }
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }else{
        NSLog(@"解析数据不是字典类型");
        return nil;
    }
}
/**
 *  把格式化的JSON格式的字符串转换成字典
 *
 *  @return 返回字典
 */
- (id)JSONValue{
    if ([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSMutableString class]]) {
        if (self == nil) {
            NSLog(@"Json解析成子字典传入空字符串，不能解析");
            return nil;
        }
        NSData *jsonData = [(NSString*)self dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        if(err) {
            NSLog(@"json解析成字典失败：%@",err);
            return nil;
        }
        return dic;
    }
    return nil;
}

//Model 到字典
- (NSDictionary *)keyValues
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}


@end
