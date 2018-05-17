//
//  PLURLConstHeader.m
//  Clanunity
//
//  Created by wangyadong on 2017/6/6.
//  Copyright © 2017年 duolaimi. All rights reserved.
//

#import "PLURLConstHeader.h"


/*
 接口命名规范
 举例  /zfy/news/hotcomment
 命名  1. URL_news_hotcomment  或者  2. URL_hotcomment
 建议尽量使用1比较容易使用
 */
const NSString * const  URL_news_hotcomment = @"/ysjapp/v0909/ceshi/news/hotcomment";

/**获取appkey */
const NSString * const  URL_authentication_appkey = @"/ysjapp/v0909/authentication/appkey";

/**首页公告展示接口 */
const NSString * const  URL_notice_getNewNotice = @"/ysjapp/v0909/notice/getNewNotice";

/**首页banner */
const NSString * const  URL_advertise_querybytype = @"/ysjapp/v0909/advertise/querybytype";

/**商家优惠banner */
const NSString * const  URL_shopproductdiscount_recommend = @"/ysjapp/v0909/shopproductdiscount/recommend";
/**新闻 */
const NSString * const  URL_news_newslist = @"/ysjapp/v0909/zfy/news/newslist";

/**资讯列表 */
const NSString * const  URL_news_listbycate = @"/ysjapp/v0909/news/listbycate";

/**登录接口 */
const NSString * const  URL_login_validate = @"/ysjapp/v0909/zfy/login/validate";

/**退出登录接口 */
const NSString * const  URL_logincommit_logout = @"/ysjapp/v0909/logincommit/logout";

/**第三方 微信 登录接口 */
const NSString * const  URL_zfy_wxlogin_thirdlogin = @"/ysjapp/v0909/zfy/wxlogin/thirdlogin";

/**地址 */
const NSString * const  URL_area_getarealist = @"/ysjapp/v0909/area/getarealist";

/**判断验证码 */
const NSString * const  URL_login_validatemscd = @"/ysjapp/v0909/login/validatemscd";

/**设置密码*/
const NSString * const  URL_login_resetpw = @"/ysjapp/v0909/login/resetpw";

/**注册新用户*/
const NSString * const  URL_login_messagelogin = @"/ysjapp/v0909/login/messagelogin";

/**第三方登录拿到openid，判断是否注册过*/
const NSString * const  URL_thirdlogin_validateOpenid = @"/ysjapp/v0909/thirdlogin/validateOpenid";

/**判断手机号 是否注册过掌方圆*/
const NSString * const  URL_login_isuserexist = @"/ysjapp/v0909/login/isuserexist";

/**这个接口做的事：1. 验证手机验证码是否正确 2. 判段手机是否绑定过其他帐号 3. 绑定手机号 */
const NSString * const  URL_thirdlogin_validateMscd = @"/ysjapp/v0909/thirdlogin/validateMscd";

/**这个接口做的事：注册手机号码，并绑定到第三方账号上 */
const NSString * const  URL_thirdlogin_registUserAndBind = @"/ysjapp/v0909/thirdlogin/registUserAndBind";

/**分类，类别*/
const NSString * const  URL_zfy_category_categorylist = @"/ysjapp/v0909/zfy/category/categorylist";

/**视频播放次数更新*/
const NSString * const  URL_zfy_news_updateviewnum = @"/ysjapp/v0909/news/updateviewnum";

/**获取好友申请记录列表*/
const NSString * const  URL_friendsapplyquery_getapplylist = @"/ysjapp/v0909/friendsapplyquery/getapplylist";

/**删除好友申请记录*/
const NSString * const  URL_friendsapplycommit_deleteapply = @"/ysjapp/v0909/friendsapplycommit/deleteapply";


/**好友申请状态修改*/
const NSString * const  URL_friendsapplycommit_updatestatus = @"/ysjapp/v0909/friendsapplycommit/updatestatus";

/**通过手机号码查询好友*/
const NSString * const  URL_friendsquery_searchfriendbyphone = @"/ysjapp/v0909/friendsquery/searchfriendbyphone";

/**好友申请添加接口*/
const NSString * const  URL_friendsapplycommit_apply = @"/ysjapp/v0909/friendsapplycommit/apply";

/**获取好友信息*/
const NSString * const  URL_friendsquery_friendInfo = @"/ysjapp/v0909/friendsquery/friendInfo";

/**获取用户信息*/
const NSString * const  URL_accountquery_userbyuid =@"/ysjapp/v0909/accountquery/userbyuid";

/**修改好友备注*/
const NSString * const  URL_friendscommit_updatefriendsremark = @"/ysjapp/v0909/friendscommit/updatefriendsremark";


/**获取好友列表*/
const NSString * const  URL_friendsquery_getmyfriends = @"/ysjapp/v0909/friendsquery/getmyfriends";

/**活动列表*/
const NSString * const  URL_socialgroupact_acthomelist = @"/ysjapp/v0909/socialgroupact/acthomelist";

/**我的活动列表*/
const NSString * const  URL_socialgroupact_myappact = @"/ysjapp/v0909/socialgroupact/myappact";

/**活动详情*/
const NSString * const  URL_socialgroupact_detail = @"/ysjapp/v0909/socialgroupact/detail";

/**广告*/
const NSString * const  URL_advertise_newsad = @"/ysjapp/v0909/advertise/newsad";

/**解除绑定*/
const NSString * const  URL_zfy_account_unbind = @"/ysjapp/v0909/zfy/account/unbind";
/**绑定第三方*/
const NSString * const  URL_zfy_account_bind = @"/ysjapp/v0909/zfy/account/bind";

/**判断用户是否报名*/
const NSString * const  URL_socialgroupact_issignup = @"/ysjapp/v0909/socialgroupact/issignup";


/**活动报名*/
const NSString * const  URL_socialgroupact_signup = @"/ysjapp/v0909/socialgroupact/signup";

/**取消报名*/
const NSString * const  URL_socialgroupact_calsignup = @"/ysjapp/v0909/socialgroupact/calsignup";


/**获取社区列表*/
const NSString * const  URL_area_getcommunitylist = @"/ysjapp/v0909/area/getcommunitylist";

/**获取小区列表*/
const NSString * const  URL_area_getupdownlist = @"/ysjapp/v0909/area/getupdownlist";

/**更新常驻地址*/
const NSString * const  URL_account_updateaddress = @"/ysjapp/v0909/account/updateaddress";

/**获取我的积分历史记录*/
const NSString * const  URL_integral_myintegralhis = @"/ysjapp/v0909/integral/myintegralhis";

/**动态列表*/
const NSString * const  URL_publishpic_pubpiclistnew = @"/ysjapp/v0909/publishpic/pubpiclistnew";

/**爆料列表 */
const NSString * const  URL_publishpic_pubpiclist = @"/ysjapp/v0909/publishpic/pubpiclist";

/**我的爆料列表 */
const NSString * const  URL_publishpic_mypubpiclist = @"/ysjapp/v0909/publishpic/mypubpiclist";

/**删除我发布的爆料 */
const NSString * const  URL_pubpiccommit_delete = @"/ysjapp/v0909/pubpiccommit/delete";

/**获取签到消息记录*/
const NSString * const  URL_integral_getIntegralMessage = @"/ysjapp/v0909/integral/getIntegralMessage";

/**获取月签到消息记录*/
const NSString * const  URL_integral_getOneMonthSignUpRecord = @"/ysjapp/v0909/integral/getOneMonthSignUpRecord";

/**发布爆料*/
const NSString * const  URL_pubpiccommit_pubpic = @"/ysjapp/v0909/pubpiccommit/pubpic";


/**爆料详情*/
const NSString * const  URL_publishpic_pubpicbyuid = @"/ysjapp/v0909/publishpic/pubpicbyuid";

/**爆料 点赞*/
const NSString * const  URL_pubpiccommit_praise = @"/ysjapp/v0909/pubpiccommit/praise";

/**评论*/
const NSString * const  URL_zfy_news_commentlist = @"/ysjapp/v0909/zfy/news/commentlist";

/*根据社区ID查询社区社群*/
const NSString * const  URL_socialgroup_comgrouplistbycomid = @"/ysjapp/v0909/socialgroup/comgrouplistbycomid";

/*根据社区ID查询社区社群*/
const NSString * const  URL_friendsquery_isMyFriend = @"/ysjapp/v0909/zfy/friendsquery/isMyFriend";

/*获取短信验证码*/
const NSString * const  URL_shortMessage_sendShortMessage = @"/ysjapp/v0909/shortMessage/sendShortMessage";

/*根据社区ID查询小区*/
const NSString * const  URL_socialgroup_uptowngrouplistbycomid = @"/ysjapp/v0909/socialgroup/uptowngrouplistbycomid";

/*获取我加入的社区社群列表*/
const NSString * const  URL_socialgroup_mycomgrouplist = @"/ysjapp/v0909/socialgroup/mycomgrouplist";

/*获取我加入的小区群列表*/
const NSString * const  URL_socialgroup_myuptgrouplist = @"/ysjapp/v0909/socialgroup/myuptgrouplist";

/*申请加入社群*/
const NSString * const  URL_socialgroupapply_create = @"/ysjapp/v0909/socialgroupapply/create";

/*社群详情*/
const NSString * const  URL_socialgroup_detail = @"/ysjapp/v0909/socialgroup/detail";

/*修改社群描述*/
const NSString * const  URL_socialgroup_updateintroduce = @"/ysjapp/v0909/socialgroup/updateintroduce";

/*修改社群头像*/
const NSString * const  URL_socialgroup_updateheadimg = @"/ysjapp/v0909/socialgroup/updateheadimg";

/*修改用户在社群的昵称*/
const NSString * const  URL_socialgroup_updateremark = @"/ysjapp/v0909/socialgroup/updateremark";

/*退出社群*/
const NSString * const  URL_socialgroup_out = @"/ysjapp/v0909/socialgroup/out";

/*解散社群*/
const NSString * const  URL_socialgroup_dismiss = @"/ysjapp/v0909/socialgroup/dismiss";

/*我创建的社群申请列表*/
const NSString * const  URL_socialgroupapply_getmyapplylist = @"/ysjapp/v0909/socialgroupapply/getmyapplylist";

/*修改社区申请状态 创建社群的人可以修改*/
const NSString * const  URL_socialgroupapply_updatestatus =
@"/ysjapp/v0909/socialgroupapply/updatestatus";

/*删除社群申请记录*/
const NSString * const  URL_socialgroupapply_deleteapply =
@"/ysjapp/v0909/socialgroupapply/deleteapply";


/*社群活动列表*/
const NSString * const  URL_socialgroupact_groupactlist = @"/ysjapp/v0909/socialgroupact/groupactlist";

/*发布活动*/
const NSString * const  URL_socialgroupact_create =@"/ysjapp/v0909/socialgroupact/create";

/*社群发布广告*/
const NSString * const  URL_socialgroupad_create =@"/ysjapp/v0909/socialgroupad/create";

/*社群广告列表*/
const NSString * const  URL_socialgroupad_list =@"/ysjapp/v0909/socialgroupad/list";

/*广告详情*/
const NSString * const  URL_socialgroupad_detail =@"/ysjapp/v0909/socialgroupad/detail";


/*获取登录用户所在社群中的身份*/
const NSString * const  URL_socialgroup_identity = @"/ysjapp/v0909/socialgroup/identity";

/*设置社群免打扰*/
const NSString * const  URL_socialgroup_block = @"/ysjapp/v0909/socialgroup/block";

/*最新通知消息（9/11 没有调用）*/
const NSString * const  URL_notice_lastListNotice =@"/ysjapp/v0909/notice/lastListNotice";

/*系统消息*/
const NSString * const  URL_message_getMessage=@"/ysjapp/v0909/message/getMessage";

/*热点头条*/
const NSString * const  URL_news_gethotnews =@"/ysjapp/v0909/news/gethotnews";



/*社区小区 公告列表*/
const NSString * const  URL_communitynotice_list =@"/ysjapp/v0909/communitynotice/list";

/*社区小区 公告 详情*/
const NSString * const  URL_communitynotice_detail =@"/ysjapp/v0909/communitynotice/detail";

/*社区小区 老年活动列表*/
const NSString * const  URL_communityoldactivity_list =@"/ysjapp/v0909/communityoldactivity/list";
/*社区小区 老年活动 详情*/
const NSString * const  URL_communityoldactivity_detail =@"/ysjapp/v0909/communityoldactivity/detail";

/*社区小区 老年餐厅列表*/
const NSString * const  URL_communityolddinner_list =@"/ysjapp/v0909/communityolddinner/list";
/*社区小区 老年餐厅  详情*/
const NSString * const  URL_communityolddinner_detail =@"/ysjapp/v0909/communityolddinner/detail";


/*社区小区 社区公益列表*/
const NSString * const  URL_communitywelfare_list =@"/ysjapp/v0909/communitywelfare/list";

/*社区小区 社区公益 详情*/
const NSString * const  URL_communitywelfare_detail =@"/ysjapp/v0909/communitywelfare/detail";

/*社区小区 办事流程列表*/
const NSString * const  URL_communityworkflow_list =@"/ysjapp/v0909/communityworkflow/list";
/*社区小区 办事流程 详情*/
const NSString * const  URL_communityworkflow_detail =@"/ysjapp/v0909/communityworkflow/detail";


/*生活  商品列表*/
const NSString * const  URL_product_list=@"/ysjapp/v0909/product/list";

/*生活  商品详情*/
const NSString * const  URL_product_detail=@"/ysjapp/v0909/product/detail";

/*生活  收货地址*/
const NSString * const  URL_shippingaddress_list=@"/ysjapp/v0909/shippingaddress/list";

//获取子分类下的全部分类内容 pid, Integer, 分类父id
const NSString * const  URL_category_allcategorylist=   @"/ysjapp/v0909/category/allcategorylist";

/*生活  提交订单*/
const NSString * const  URL_order_create=@"/ysjapp/v0909/order/create";

/*引导页广告*/
const NSString * const  URL_advertise_startup=@"/ysjapp/v0909/advertise/startup";

/*积分商品列表*/
const NSString * const  URL_product_integralproductlist=@"/ysjapp/v0909/product/integralproductlist";

/*修改收货地址*/
const NSString * const  URL_shippingaddress_update=@"/ysjapp/v0909/shippingaddress/update";

/*添加收货地址*/
const NSString * const  URL_shippingaddress_create=@"/ysjapp/v0909/shippingaddress/create";

/*设置默认收货地址*/
const NSString * const  URL_shippingaddress_setdefaultaddress=@"/ysjapp/v0909/shippingaddress/setdefaultaddress";

/*删除收货地址*/
const NSString * const  URL_shippingaddress_delete=@"/ysjapp/v0909/shippingaddress/delete";
/*删除好友*/
const NSString * const  URL_friendscommit_deletefriends=@"/ysjapp/v0909/friendscommit/deletefriends";

/*添加好友*/
const NSString * const  URL_friendscommit_addfriends=@"/ysjapp/v0909/friendscommit/addfriends";

/*查看我参与的共享*/
const NSString * const  URL_publishingnew_showMyPartPublishingList=@"/ysjapp/v0909/publishingnew/showMyPartPublishingList";

/*查看我的共享*/
const NSString * const  URL_publishingnew_showMyPublishingList=@"/ysjapp/v0909/publishingnew/showMyPublishingList";

/*获取我的订单*/
const NSString * const  URL_order_myorderlist=@"/ysjapp/v0909/order/myorderlist";

/*获取订单详情*/
const NSString * const  URL_order_myorderdetail=@"/ysjapp/v0909/order/myorderdetail";

/*取消订单*/
const NSString * const  URL_order_cancel=@"/ysjapp/v0909/order/cancel";

/*删除订单*/
const NSString * const  URL_order_delete=@"/ysjapp/v0909/order/delete";

/*共享列表数据*/
const NSString * const  URL_publishingnew_showPublishingList=@"/ysjapp/v0909/publishingnew/showPublishingList";

/*共享详情数据*/
const NSString * const  URL_publishingnew_showPublishingInfo=@"/ysjapp/v0909/publishingnew/showPublishingInfo";

/*共享详情数据*/
const NSString * const  URL_publishingnewcommit_deletePublishingNew=@"/ysjapp/v0909/publishingnewcommit/deletePublishingNew";


/*删除活动*/
const NSString * const  URL_socialgroupact_delete=@"/ysjapp/v0909/socialgroupact/delete";

/*禁言社群成员*/
const NSString * const  URL_socialgroup_mute=@"/ysjapp/v0909/socialgroup/mute";

/*踢出社群成员*/
const NSString * const  URL_socialgroup_kickout=@"/ysjapp/v0909/socialgroup/kickout";

/**首页搜索 */
const NSString * const  URL_news_searchbykeywords=@"/ysjapp/v0909/news/searchbykeywords";

/**首页搜索 */
const NSString * const  URL_search_list=@"/ysjapp/v0909/search/list";

/**热门搜索关键词*/
const NSString * const  URL_search_hotsearch=@"/ysjapp/v0909/search/hotsearch";

/**相关推荐*/
const NSString * const  URL_zfy_news_relatednews=@"/ysjapp/v0909/zfy/news/relatednews";

/**爆料推荐*/
const NSString * const  URL_publishpic_relatedpic=@"/ysjapp/v0909/publishpic/relatedpic";

/**填写好友邀请码*/
const NSString * const  URL_invitation_commitsharecode=@"/ysjapp/v0909/invitation/commitsharecode";

/**掌币兑换*/
const NSString * const  URL_paymentrecord_addPaymentRecord=@"/ysjapp/v0909/paymentrecord/addPaymentRecord";

/**掌币兑换新接口*/
const NSString * const  URL_paymentrecord_exchange=@"/ysjapp/v0909/paymentrecord/exchange";

/**商家优惠列表*/
const NSString * const  URL_shopproductdiscount_list=@"/ysjapp/v0909/shopproductdiscount/list";

/**商家优惠详情*/
const NSString * const  URL_shopproductdiscount_detail=@"/ysjapp/v0909/shopproductdiscount/detail";

/**创建群*/
const NSString * const  URL_socialgroup_create = @"/ysjapp/v0909/socialgroup/create";

/**获取邀请人信息*/
const NSString * const  URL_invitation_getinvitationpersoninfo = @"/ysjapp/v0909/invitation/getinvitationpersoninfo";

/**获取我的任务列表*/
const NSString * const  URL_task_querytasklist = @"/ysjapp/v0909/task/querytasklist";

/**获取我的任务列表*/
const NSString * const  URL_api_getNewsList = @"/api/main/getNewsList";


