//
//  PlEnumHeader.h
//  Clanunity
//
//  Created by wangyadong on 2017/4/7.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

#ifndef PlEnumHeader_h
#define PlEnumHeader_h

/**
 *  发布类型
 */
typedef NS_ENUM(NSUInteger, PublishStyle) {
    /**
     *  动态 = 0
     */
    PublishStyleDynamic = 0,
    
    /**
     *  爆料 = 1
     */
    PublishStyleBaoLiao ,
    /**我自己发布的 */
    PublishStyleMySelf,
};




/**
 *  屏蔽
 */
typedef NS_ENUM(NSUInteger, ShieldAction) {
    /**
     *  默认屏蔽
     */
    ShieldActionDefault = 0,
    
    /**
     *  屏蔽了 - 需要取消屏蔽(屏蔽打开)
     */
    ShieldActionUnwrap ,
};


/**
 *  登录类型
 */
typedef NS_ENUM(NSUInteger, LoginType) {
    /**微信 */
    LoginTypeWechat = 0,
    /**微博 */
    LoginTypeWeibo = 1,
    /**qq */
    LoginTypeQQ = 2,
    /**账号密码登录 */
    LoginTypeAccount = 3,
};




//评论类型
typedef enum : NSUInteger {
    ///未知
    CommentSubmitUnKnow = 0,
    ///资讯评论
    CommentSubmitNEWS1401 = 1401,
    ///话题评论
    CommentSubmitTOPIC1402 = 1402,
    ///商家评论
    CommentSubmitSELLER1403 = 1403,
    ///动态,随手拍-
    CommentSubmitPUBLISHPIC1404 = 1404,
    ///分享评论类型
    CommentSubmitPUBLISHINGNEW1405 = 1405,
    ///社区通知
    CommentSubmitCommunityNotice1406 = 1406,
    ///老年活动
    CommentSubmitCommunityOldActivity1407 = 1407,
    ///社区公益
    CommentSubmitCommunityWelfare1408 = 1408,
    ///办事流程
    CommentSubmitCommunityWorkflow1409 = 1409,
    ///老年餐厅
    CommentSubmitCommunityOldDinning1410 = 1410,
    ///系统消息
    CommentSubmitSystemMessage1411 = 1411,
    ///公共评论点赞
    CommentSubmitCOMMENT1501 = 1501,
} CommentSubmit;




//关系类型
typedef enum : NSUInteger {
    PLRelationshipUnknown = 0,//未知情况
    PLRelationshipNormal = 100,//陌生人
    PLRelationshipFriend = 200,//好友
    PLRelationshipBlacklist = 201,//黑名单
} PLRelationship;

//圈子中的权限身份
typedef enum : NSUInteger {
    PLCircleIdentityAuthorityUnknown = 0,//未知
    PLCircleIdentityAuthorityNormal = 100,//普通人
    PLCircleIdentityAuthorityManager = 200,//管理员
    PLCircleIdentityAuthorityMaster = 300,//群主
} PLCircleIdentityAuthority;

//职称
typedef enum : NSUInteger {
    PLTechnicalIdentityUnknown = 0,//未知职称
    PLTechnicalIdentityPropertyManager = 118,//物业经理
    PLTechnicalIdentityPipeliner = 119,      //管道工
    PLTechnicalIdentityElectrician = 120,    //电工
    PLTechnicalIdentityRepairman = 121,      //修理工
    PLTechnicalIdentityGuards = 122,         //保安
    PLTechnicalIdentityCleaner = 123,        //保洁
} PLTechnicalIdentity;

typedef enum : NSUInteger {
    PLAuthenticationStatusUnknow = 0,
    PLAuthenticationStatusPersonal = 5001,//个人认证
    PLAuthenticationStatusEnterprise = 5002,//	企业认证,
    PLAuthenticationStatusRealname = 5011,//	实名
    PLAuthenticationStatusBusiness = 5012,//	商家,
    PLAuthenticationStatusProperty = 5013,//	物业	,
    PLAuthenticationStatusPersonalING = 5014,//	个人认证中,
    PLAuthenticationStatusEnterpriseING = 5015,//	企业认证中
    PLAuthenticationStatusError =5016,//认证失败
} PLAuthenticationStatus;


//发消息类型
typedef enum : NSUInteger {
    PushMessageTypeCIRCLETYPE = 1,//以注册的用户加入圈子时的消息类别
    PushMessageTypeCIRCLERESULTTYPE = 2,//圈子加入后的结果消息类别
    PushMessageTypeFRIENDTYPE = 3,//申请加好友的消息类别
    PushMessageTypeFRIENDPASSTYPE = 4,//加好友的结果消息类别
    PushMessageTypeAUTHNOPASSTYPE = 5,//认证未通过的消息类别
    PushMessageTypeAUTHPASSTYPE = 6,//认证通过的消息类别
    PushMessageTypePAIDANTYPE = 7,//派单的消息类别
    PushMessageTypePAIDANCHULITYPE = 8,//处理派单
    PushMessageTypeFRIENDADDCIRCLE = 9,//邀请好友加入圈子
    PushMessageTypeSYSTYPE = 10,//系统消息类别
    PushMessageTypeINVITATIONFRI = 11,//邀请没注册的用户加好友
    PushMessageTypeINVITATIONCIR = 12,//邀请没注册的用户加圈子
    PushMessageTypeUPGRADE = 13,//用户升级
} PushMessageType;


typedef enum : NSUInteger {
    PLCircleTypeNormal = 0,//普通圈子
    PLCircleTypeProperty = 1064,//物业圈子
    PLCircleTypeCommunity =1061, //社区圈子 朋友圈
    PLCircleTypeLive = 1062, //生活圈子  商家圈
    PLCircleTypePrivateChat = 1063,  //私聊圈子
    PLCircleTypeOther,   //其他圈子
} PLCircleType;



typedef enum : NSUInteger {
    ShareThirdTypeWechat,
    ShareThirdTypeWechatCircle,
    ShareThirdTypeQQ,
    ShareThirdTypeQQZone,
} ShareThirdType;


#endif /* PlEnumHeader_h */
