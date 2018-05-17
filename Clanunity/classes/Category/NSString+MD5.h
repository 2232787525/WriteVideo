//
//  NSString+MD5.h
//  TZS
//
//  Created by yandi on 14/12/9.
//  Copyright (c) 2014年 NongFuSpring. All rights reserved.
//


@interface NSString (MD5)

+ (NSString *)md5:(NSString *)originalStr;  //14e1b600b1fd579f47433b88e8d85291

+ (NSString *)CurrentTime1970;

+ (NSString *)TimeToCurrentTime:(NSInteger)time;

+ (NSString *)CurrentTimeByStrHaveSecond:(BOOL)have;
/**
 *  当前剩余时间
 *
 *  剩余时间字符串(秒)
 *
 *  @return 返回剩余时间字符串
 */
+(NSString *)lessSecondToDay:(NSUInteger)seconds showSecond:(BOOL) show;

/**
 *  剩余多少秒
 *
 *  @param timeString1 到期时间
 *
 *  @return 到现在多少秒
 */
+ (NSInteger)intervalFromLastDate:(NSString *) timeString1  toTheDate:(NSString *) timeString2;
/**
 *  判断字符串是否是纯数字
 *
 *  @param string <#string description#>
 *
 *  @return <#return value description#>
 */
+(BOOL)isPureNumandCharacters:(NSString *)string;

/**
 字符串去首尾空格

 @param str 原始字符串

 @return 去掉首尾空格的字符串
 */
+(NSString*)trimString:(NSString*)str;


/**
 是否是中午
Valid
 @return 中文
 */
+(BOOL)isChinese;



@end