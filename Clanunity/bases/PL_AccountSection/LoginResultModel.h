//
//  LoginResultModel.h
//  PlamLive
//
//  Created by wangyadong on 2016/11/15.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "PLBaseModel.h"
@class LoginUserModel,SellerModel,BindModel;
@interface LoginResultModel : PLBaseModel
/**返回数据标记 */
@property(nonatomic,copy)NSString * result;
/** */
@property(nonatomic,strong)NSArray * list;
/**用户数据model */
@property(nonatomic,strong)LoginUserModel * userModel;
/**用户数据 */
@property(nonatomic,strong)NSDictionary * user;

@property(nonatomic,strong)NSArray * roleids;
/**商铺 */
@property(nonatomic,strong)SellerModel * sellerModel;
@property(nonatomic,strong)NSDictionary * seller;
//绑定账号，绑定第三方信息
/*
 @{@"openid":@"",@"nickname":@"",@"bindType":@""}
 bindType 0-微信，1-新浪微博，2-qq , 3-账户密码登录
 */
@property (nonatomic,strong)NSArray *binds;
//@property(nonatomic,strong)NSArray<BindModel*> * bindModels;
/**登录账户类型 0-微信，1-新浪微博，2-qq , 3-账户密码登录 */
@property (nonatomic,assign) NSInteger utp;
//我的邀请人code
@property (nonatomic,copy)NSString *sharecode;
//我的邀请人name
@property (nonatomic,copy)NSString *sharename;


@end


@interface LoginUserModel : PLBaseModel
//认证名字
@property(nonatomic,copy)NSString * realname;
//认证身份证号
@property(nonatomic,copy)NSString * idcard;

@property(nonatomic,copy)NSString * email;

@property(nonatomic,copy)NSString * headimg;
//掌币
@property(nonatomic,assign)NSInteger integral;

@property(nonatomic,copy)NSString * nickname;
//个性签名
@property(nonatomic,copy)NSString * signature;

@property(nonatomic,copy)NSString * username;

@property(nonatomic,assign)NSInteger usertype;

@property(nonatomic,copy)NSString * password;

@property(nonatomic,assign)NSInteger level;
//用户荣誉等级
@property(nonatomic,assign)NSInteger honorlevel;
//地址
@property (nonatomic,copy)NSString *address;
//背景图片
@property (nonatomic,copy)NSString *bgimg;
//性别
@property (nonatomic,copy)NSString *gender;
//用户手机号
@property(nonatomic,copy)NSString * mobilephone;
/**用户userUid */
@property(nonatomic,copy)NSString * uuid;
//是否实名认证
@property(nonatomic,assign)NSInteger  authtype;

@property (nonatomic,assign)NSInteger age;

@property (nonatomic,copy)NSString * birthday;

@end

@interface LoginSessionModel : PLBaseModel

@property(nonatomic,copy)NSString * session_asd;

@property(nonatomic,copy)NSString * session_apptoken;

@end


@interface  SellerModel: PLBaseModel

@property(nonatomic,assign)double level;
@property(nonatomic,assign)NSInteger score;
@property(nonatomic,copy)NSString *uuid;
@end


@interface BindModel : PLBaseModel

@property(nonatomic,copy)NSString * openid;
@property(nonatomic,copy)NSString * nickname;
@property(nonatomic,copy)NSString * bindType;

@end


@interface ResponseHelp : NSObject
+(NSDictionary*)getAsdApptokenCookeWithResponse:(NSHTTPURLResponse*)response;
+(NSString*)getAppkeyAkyStringWithResponse:(NSHTTPURLResponse*)response;


@end

