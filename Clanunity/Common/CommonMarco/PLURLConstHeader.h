//
//  PLURLConstHeader.h
//  Clanunity
//
//  Created by wangyadong on 2017/6/6.
//  Copyright © 2017年 duolaimi. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef  LocPLURLConstHeader_h
#define  LocPLURLConstHeader_h

//这个宏定义已经不使用了，如修改编译环境直接修改URLGlobalSwiftHeader中的
/*
 
 //如果调试切换内网外网测试，只需要修改URL_TEST_STATUS
 //case Dev = 1内网
 //case Release = 2外网
 //case Bug = 3bug
 
 
//#warning 当你修改环境状态的时候把URLGlobalSwiftHeader中相应改了
//#define URL_TEST_STATUS  2 //再次提醒你改了吗？
//
//
//#if (URL_TEST_STATUS == 2)
////外网
//#define URL_header  @"http://47.95.167.77/ysjapp/v0904"
//#define URL_H5_header  @"http://47.95.167.77"
//#define EaseMobAppKey  @"1192170227115326#zhangfangyuan"
//#else
//
//#if (URL_TEST_STATUS == 1)
////内网
//#define URL_header  @"http://192.168.1.192:8080/ysjapp/v0904"
//#define URL_H5_header  @"http://192.168.1.192:8080"
//#define EaseMobAppKey  @"1192170227115326#zhangfangyuan1"
//
//#else  //URL_TEST_STATUS == 3
////测试
//#define URL_header  @"http://192.168.1.147:8080/ysjapp/v0904"
//
//#define URL_H5_header  @"http://192.168.1.192:8080"
//#define EaseMobAppKey  @"1192170227115326#zhangfangyuan1"
//
//
//#endif
//
//#endif

 */




/*
 接口命名规范
 举例  /ceshi/news/hotcomment
 命名  1. URL_news_hotcomment  或者  2. URL_hotcomment
 建议尽量使用1种
 */
UIKIT_EXTERN NSString * const URL_news_hotcomment;


/**获取appkey : 关键操作*/
UIKIT_EXTERN NSString * const URL_authentication_appkey;

/**首页公告展示接口 */
UIKIT_EXTERN NSString * const URL_notice_getNewNotice;

/**首页banner */
UIKIT_EXTERN NSString * const URL_advertise_querybytype;

/**商家优惠banner */
UIKIT_EXTERN NSString * const  URL_shopproductdiscount_recommend;

/**新闻 */
UIKIT_EXTERN NSString * const URL_news_newslist;

/**资讯列表 */
UIKIT_EXTERN NSString * const  URL_news_listbycate;

/**登录接口/zfy/login/validate */
UIKIT_EXTERN NSString * const URL_login_validate;

/**退出登录接口/logincommit/logout */
UIKIT_EXTERN NSString * const URL_logincommit_logout;

/**第三方 微信 登录接口 */
UIKIT_EXTERN NSString * const URL_zfy_wxlogin_thirdlogin;

/**地址 */
UIKIT_EXTERN NSString * const URL_area_getarealist;

/**判断验证码 */
UIKIT_EXTERN NSString * const URL_login_validatemscd;

/**设置密码*/
UIKIT_EXTERN NSString * const URL_login_resetpw;
/**注册新用户*/
UIKIT_EXTERN NSString * const URL_login_messagelogin;


/**第三方登录拿到openid，判断是否注册过*/
UIKIT_EXTERN NSString * const URL_thirdlogin_validateOpenid;

/**判断手机号 是否注册过掌方圆*/
UIKIT_EXTERN NSString * const  URL_login_isuserexist;

/**这个借接口做的事：1. 验证手机验证码是否正确 2. 判段手机是否绑定过其他帐号 3. 绑定手机号 */
UIKIT_EXTERN NSString * const  URL_thirdlogin_validateMscd;


/**这个借接口做的事：注册手机号码，并绑定到第三方账号上 */
UIKIT_EXTERN NSString * const  URL_thirdlogin_registUserAndBind;
/**分类，类别*/
UIKIT_EXTERN NSString * const  URL_zfy_category_categorylist;

/**视频播放次数更新*/
UIKIT_EXTERN NSString * const  URL_zfy_news_updateviewnum;

/**获取好友申请记录列表*/
UIKIT_EXTERN NSString * const  URL_friendsapplyquery_getapplylist;

/**删除好友申请记录*/
UIKIT_EXTERN NSString * const  URL_friendsapplycommit_deleteapply;

/**删除好友申请记录*/
UIKIT_EXTERN NSString * const  URL_friendsapplycommit_updatestatus;

/**通过手机号码查询好友*/
UIKIT_EXTERN NSString * const  URL_friendsquery_searchfriendbyphone;

/**好友申请添加接口*/
UIKIT_EXTERN NSString * const  URL_friendsapplycommit_apply;

/**获取好友信息*/
UIKIT_EXTERN NSString * const  URL_friendsquery_friendInfo;

/**获取用户信息*/
UIKIT_EXTERN NSString * const  URL_accountquery_userbyuid;

/**修改好友备注*/
UIKIT_EXTERN NSString * const  URL_friendscommit_updatefriendsremark;

/**活动列表*/
UIKIT_EXTERN NSString * const  URL_socialgroupact_acthomelist;

/**我的活动列表*/
UIKIT_EXTERN NSString * const  URL_socialgroupact_myappact;

/**活动详情*/
UIKIT_EXTERN NSString * const  URL_socialgroupact_detail;

/**广告*/
UIKIT_EXTERN NSString * const  URL_advertise_newsad;

/**解除绑定*/
UIKIT_EXTERN NSString * const  URL_zfy_account_unbind;
/**绑定第三方*/
UIKIT_EXTERN NSString * const  URL_zfy_account_bind;

/**判断用户是否报名*/
UIKIT_EXTERN NSString * const  URL_socialgroupact_issignup;

/**活动报名*/
UIKIT_EXTERN NSString * const  URL_socialgroupact_signup;

/**取消报名*/
UIKIT_EXTERN NSString * const  URL_socialgroupact_calsignup;

/**获取社区列表*/
UIKIT_EXTERN NSString * const  URL_area_getcommunitylist;

/*根据社区ID查询社区社群*/
UIKIT_EXTERN NSString * const  URL_socialgroup_comgrouplistbycomid;

//判断是否跟我是好友
UIKIT_EXTERN NSString * const  URL_friendsquery_isMyFriend;

/*获取短信验证码*/
UIKIT_EXTERN NSString * const  URL_shortMessage_sendShortMessage;

/*根据社区ID查询小区*/
UIKIT_EXTERN NSString * const  URL_socialgroup_uptowngrouplistbycomid;

/*获取我加入的社区社群列表*/
UIKIT_EXTERN NSString * const  URL_socialgroup_mycomgrouplist;

/*获取我加入的小区群列表*/
UIKIT_EXTERN NSString * const  URL_socialgroup_myuptgrouplist;

/*申请加入社群*/
UIKIT_EXTERN NSString * const  URL_socialgroupapply_create;

/*社群详情*/
UIKIT_EXTERN NSString * const  URL_socialgroup_detail;

/*修改社群描述*/
UIKIT_EXTERN NSString * const  URL_socialgroup_updateintroduce;

/*修改社群头像*/
UIKIT_EXTERN NSString * const  URL_socialgroup_updateheadimg;

/*修改用户在社群的昵称*/
UIKIT_EXTERN NSString * const  URL_socialgroup_updateremark;

/*退出社群*/
UIKIT_EXTERN NSString * const  URL_socialgroup_out;

/*解散社群*/
UIKIT_EXTERN NSString * const  URL_socialgroup_dismiss;

/*我创建的社群申请列表*/
UIKIT_EXTERN NSString * const  URL_socialgroupapply_getmyapplylist;
///socialgroupapply/getmyapplylist

/*修改社区申请状态 创建社群的人可以修改*/
UIKIT_EXTERN NSString * const  URL_socialgroupapply_updatestatus;

/*删除社群申请记录*/
UIKIT_EXTERN NSString * const  URL_socialgroupapply_deleteapply;

/**获取小区列表*/
UIKIT_EXTERN NSString * const  URL_area_getupdownlist;

/*社群活动列表*/
UIKIT_EXTERN NSString * const  URL_socialgroupact_groupactlist;

/*发布活动*/
UIKIT_EXTERN NSString * const  URL_socialgroupact_create;

/*社群发布广告*/
UIKIT_EXTERN NSString * const  URL_socialgroupad_create;

/*社群广告列表*/
UIKIT_EXTERN NSString * const  URL_socialgroupad_list;

/*广告详情*/
UIKIT_EXTERN NSString * const  URL_socialgroupad_detail;

/*获取登录用户所在社群中的身份*/
UIKIT_EXTERN NSString * const  URL_socialgroup_identity;

/*设置社群免打扰*/
UIKIT_EXTERN NSString * const  URL_socialgroup_block;

/**更新常驻地址*/
UIKIT_EXTERN NSString * const  URL_account_updateaddress;

/**获取我的积分历史纪录*/
UIKIT_EXTERN NSString * const  URL_integral_myintegralhis;

/**动态列表*/
UIKIT_EXTERN NSString * const  URL_publishpic_pubpiclistnew;

/**爆料列表 */
UIKIT_EXTERN NSString * const  URL_publishpic_pubpiclist;

/**我的爆料列表 */
UIKIT_EXTERN NSString * const  URL_publishpic_mypubpiclist;

/**删除我发布的爆料 */
UIKIT_EXTERN NSString * const  URL_pubpiccommit_delete;

/**获取签到消息记录*/
UIKIT_EXTERN NSString * const  URL_integral_getIntegralMessage;

/**获取月签到消息记录*/
UIKIT_EXTERN NSString * const  URL_integral_getOneMonthSignUpRecord;

/**发布爆料*/
UIKIT_EXTERN NSString * const  URL_pubpiccommit_pubpic;


/**爆料详情*/
UIKIT_EXTERN NSString * const  URL_publishpic_pubpicbyuid;


/**爆料 点赞*/
UIKIT_EXTERN NSString * const  URL_pubpiccommit_praise;

/**评论 评论列表      uid, String, 资讯唯一标识     pnu, int, 每页评论数     pno, int, 页数        flag, int, 标记，0 : 评论按热度排序，1 : 按时间排序 */
UIKIT_EXTERN NSString * const  URL_zfy_news_commentlist;

/*最新通知消息（9/11 没有调用）*/
UIKIT_EXTERN NSString * const  URL_notice_lastListNotice;

/*系统消息*/
UIKIT_EXTERN NSString * const  URL_message_getMessage;

/*热点头条*/
UIKIT_EXTERN NSString * const  URL_news_gethotnews;

/*社区小区 公告列表*/
UIKIT_EXTERN NSString * const  URL_communitynotice_list;
/*社区小区 公告 详情*/
UIKIT_EXTERN NSString * const  URL_communitynotice_detail;

/*社区小区 老年活动列表*/
UIKIT_EXTERN NSString * const  URL_communityoldactivity_list;
/*社区小区 老年活动 详情*/
UIKIT_EXTERN NSString * const  URL_communityoldactivity_detail;


/*社区小区 老年餐厅列表*/
UIKIT_EXTERN NSString * const  URL_communityolddinner_list;
/*社区小区 老年餐厅  详情*/
UIKIT_EXTERN NSString * const  URL_communityolddinner_detail;


/*社区小区 社区公益列表*/
UIKIT_EXTERN NSString * const  URL_communitywelfare_list;
/*社区小区 社区公益 详情*/
UIKIT_EXTERN NSString * const  URL_communitywelfare_detail;

/*社区小区 办事流程列表*/
UIKIT_EXTERN NSString * const  URL_communityworkflow_list;
/*社区小区 办事流程 详情*/
UIKIT_EXTERN NSString * const  URL_communityworkflow_detail;

/*社区小区 老年餐厅详情*/
UIKIT_EXTERN NSString * const  URL_communityolddinner_detail;

/*生活  商品列表*/
UIKIT_EXTERN NSString * const  URL_product_list;

/*生活  商品详情*/
UIKIT_EXTERN NSString * const  URL_product_detail;

/*UIKIT_EXTERN  收货地址*/
UIKIT_EXTERN NSString * const  URL_shippingaddress_list;

//获取子分类下的全部分类内容 pid, Integer, 分类父id
UIKIT_EXTERN NSString * const  URL_category_allcategorylist;

/*生活  提交订单*/
UIKIT_EXTERN NSString * const  URL_order_create;

/*引导页广告*/
UIKIT_EXTERN NSString * const  URL_advertise_startup;

/*积分商品列表*/
UIKIT_EXTERN NSString * const  URL_product_integralproductlist;

/*修改收货地址*/
UIKIT_EXTERN NSString * const  URL_shippingaddress_update;

/*添加收货地址*/
UIKIT_EXTERN NSString * const  URL_shippingaddress_create;

/*设置默认收货地址*/
UIKIT_EXTERN NSString * const  URL_shippingaddress_setdefaultaddress;

/*删除收货地址*/
UIKIT_EXTERN NSString * const  URL_shippingaddress_delete;

/*获取我的好友*/
UIKIT_EXTERN NSString * const  URL_friendsquery_getmyfriends;

/*删除好友*/
UIKIT_EXTERN NSString * const  URL_friendscommit_deletefriends;

/*添加好友*/
UIKIT_EXTERN NSString * const  URL_friendscommit_addfriends;

/*查看我参与的共享*/
UIKIT_EXTERN NSString * const  URL_publishingnew_showMyPartPublishingList;

/*查看我的共享*/
UIKIT_EXTERN NSString * const  URL_publishingnew_showMyPublishingList;

/*获取我的订单*/
UIKIT_EXTERN NSString * const  URL_order_myorderlist;

/*获取订单详情*/
UIKIT_EXTERN NSString * const  URL_order_myorderdetail;

/*取消订单*/
UIKIT_EXTERN NSString * const  URL_order_cancel;

/*删除订单*/
UIKIT_EXTERN NSString * const  URL_order_delete;

/*共享列表数据*/
UIKIT_EXTERN NSString * const  URL_publishingnew_showPublishingList;

/*共享详情数据*/
UIKIT_EXTERN NSString * const  URL_publishingnew_showPublishingInfo;

/*删除共享*/
UIKIT_EXTERN NSString * const  URL_publishingnewcommit_deletePublishingNew;

/*删除活动*/
UIKIT_EXTERN NSString * const  URL_socialgroupact_delete;

/*禁言社群成员*/
UIKIT_EXTERN NSString * const  URL_socialgroup_mute;

/*踢出社群成员*/
UIKIT_EXTERN NSString * const  URL_socialgroup_kickout;
/**首页搜索 */
UIKIT_EXTERN NSString * const  URL_news_searchbykeywords;

/**首页搜索（新闻资讯和商家优惠） */
UIKIT_EXTERN NSString * const  URL_search_list;

/**热门搜索关键词*/
UIKIT_EXTERN NSString * const  URL_search_hotsearch;

/**相关推荐*/
UIKIT_EXTERN NSString * const  URL_zfy_news_relatednews;

/**爆料推荐*/
UIKIT_EXTERN NSString * const  URL_publishpic_relatedpic;

/**填写好友邀请码*/
UIKIT_EXTERN NSString * const  URL_invitation_commitsharecode;

/**掌币兑换*/
UIKIT_EXTERN NSString * const   URL_paymentrecord_addPaymentRecord;

/**掌币兑换新接口*/
UIKIT_EXTERN NSString * const  URL_paymentrecord_exchange;

/**商家优惠列表*/
UIKIT_EXTERN NSString * const  URL_shopproductdiscount_list;

/**商家优惠详情*/
UIKIT_EXTERN NSString * const  URL_shopproductdiscount_detail;

/**创建群*/
UIKIT_EXTERN NSString * const  URL_socialgroup_create;

/**获取邀请人信息*/
UIKIT_EXTERN NSString * const  URL_invitation_getinvitationpersoninfo;

/**获取我的任务列表*/
UIKIT_EXTERN NSString * const  URL_task_querytasklist;


/**获取我的任务列表*/
UIKIT_EXTERN NSString * const  URL_api_getNewsList;

#endif








