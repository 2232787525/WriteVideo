//
//  LoginResultModel.m
//  PlamLive
//
//  Created by wangyadong on 2016/11/15.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "LoginResultModel.h"

@implementation LoginResultModel
-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super initWithDic:dic];
    if (self) {
        id user = dic[@"user"];
        if ([user isKindOfClass:[NSDictionary class]]) {
            self.userModel = [[LoginUserModel alloc] initWithDic:user];
        }
        id seller = dic[@"seller"];
        if ([seller isKindOfClass:[NSDictionary class]]) {
            self.sellerModel = [[SellerModel alloc] initWithDic:seller];
        }

    }
    return self;
}


@end


@implementation LoginUserModel
-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super initWithDic:dic];
    if (self) {
    }
    return self;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self.realname = @"";
        self.idcard = @"";
        self.email = @"";
        self.headimg = @"";
        self.integral = 0;
        self.nickname = @"";
        self.signature = @"";
        self.username = @"";
        self.usertype = 0;
        self.password = @"";
        self.level = 0;
        self.address = @"";
        self.bgimg = @"";
        self.gender = @"";
        self.mobilephone = @"";
        self.uuid = @"";
        self.authtype = 0;
        self.age = 0;
        self.birthday = @"";
    }
    return self;
}

@end



@implementation LoginSessionModel

@end

@implementation SellerModel



@end

@implementation BindModel


@end



#define SET_COOKIE  @"Set-Cookie"

#define ASDKey      @"asd="

#define APPTokenKey @"apptoken="

#define AKYKey      @"aky="


@implementation ResponseHelp

//获取asd
+(NSDictionary*)getAsdApptokenCookeWithResponse:(NSHTTPURLResponse*)response{
    NSDictionary *allFileHeader = response.allHeaderFields;
    NSString *Set_Cookie = [allFileHeader objectForKey:SET_COOKIE];
    //分号切割
    NSCharacterSet *semicolonsPoint = [NSCharacterSet characterSetWithCharactersInString:@";"];
    //切割后的数组
    NSArray *resultArray = [Set_Cookie componentsSeparatedByCharactersInSet:semicolonsPoint];
    NSString *asdString = @"";
    NSString *apptokenString = @"";
    
    for (NSString *string in resultArray) {
        
        NSCharacterSet *commaPoint = [NSCharacterSet characterSetWithCharactersInString:@","];
        NSArray *commaArray = [string componentsSeparatedByCharactersInSet:commaPoint];
        for (NSString *commaString in commaArray) {
            NSRange asdRange = [commaString rangeOfString:ASDKey];
            NSRange apptokenRange = [commaString rangeOfString:APPTokenKey];
            if (asdRange.location ==NSNotFound) {
                //没有找到asd
            }else{
                asdString = [commaString substringFromIndex:(asdRange.length+asdRange.location)];
            }
            if (apptokenRange.location == NSNotFound) {
                //没有找到apptoken
            }else{
                apptokenString = [commaString substringFromIndex:(apptokenRange.length+apptokenRange.location)];
            }
        }
    }
    NSDictionary *dic= @{@"session_asd":asdString,@"session_apptoken":apptokenString};
    return dic;
}

//获取Cokies
+(NSString*)getAppkeyAkyStringWithResponse:(NSHTTPURLResponse*)response{
    
    NSDictionary *allFileHeader = response.allHeaderFields;
    NSString *Set_Cookie = [allFileHeader objectForKey:SET_COOKIE];
    //分号切割
    NSCharacterSet *semicolonsPoint = [NSCharacterSet characterSetWithCharactersInString:@";"];
    //切割后的数组
    NSArray *resultArray = [Set_Cookie componentsSeparatedByCharactersInSet:semicolonsPoint];
    NSString *akyString = @"";
    
    for (NSString *string in resultArray) {
        
        NSCharacterSet *commaPoint = [NSCharacterSet characterSetWithCharactersInString:@","];
        NSArray *commaArray = [string componentsSeparatedByCharactersInSet:commaPoint];
        for (NSString *commaString in commaArray) {
            NSRange asdRange = [commaString rangeOfString:AKYKey];
            if (asdRange.location ==NSNotFound) {
                //没有找到asd
            }else{
                akyString = [commaString substringFromIndex:(asdRange.length+asdRange.location)];
            }
        }
    }
    return akyString;
}

@end



