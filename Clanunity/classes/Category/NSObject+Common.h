//
//  NSObject+Common.h
//  Property
//
//  Created by 何伟东 on 16/2/16.
//  Copyright © 2016年 乐家园. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Common)
/**
 *  字典转json
 *
 *  @return json字符串
 */
- (NSString *)JSONRepresentation;
/**
 *  把格式化的JSON格式的字符串转换成字典
 *
 *  @return 返回字典
 */
- (id)JSONValue;

/**
 model 转 字典

 @return 字典
 */
- (NSDictionary *)keyValues;

@end
