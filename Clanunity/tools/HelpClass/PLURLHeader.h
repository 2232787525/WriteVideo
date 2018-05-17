//
//  PLURLHeader.h
//  PlamLive
//
//  Created by wangyadong on 2016/10/20.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#ifndef PLURLHeader_h
#define PLURLHeader_h




/***************************************************************************************/

#pragma mark --Vote

//#define VoteWeb     @"http://192.168.0.172/vote/vote.html"

#define VoteWeb     @"http://zfy.netminer.cn/vote/vote.html"



//我的圈子列表
#define  api_mycirclelist     @"/ysjapp/v0909/circlescommit/myCircleList"

//获取圈子最新一条动态
#define  api_circles_dynamic  @"/ysjapp/v0909/circles/dynamic"

#pragma mark --资讯接口

//正文内容      uid, String, 资讯唯一标识
#define News_content        @"/ysjapp/v0909/zfy/news/content"

//最热评论      uid, String, 资讯唯一标识     hnu, int, 热点评论条数
#define News_hotcomment     @"/ysjapp/v0909/zfy/news/hotcomment"

//相关推荐      uid, String, 资讯唯一标识     rnu, int, 相关资讯条数
#define News_relatednews    @"/ysjapp/v0909/zfy/news/relatednews"



//新闻列表      catdi, int, 新闻分类id      pnu, int, 每页新闻数     pno, int, 新闻页数      tgdis, String, 标签id集合，用,隔开      tgnms, String, 标签名称集合，用,隔开      anm, String, 城区名称
#define News_newslist       @"/ysjapp/v0909/zfy/news/newslist"



//最热专题最新新闻      catdi, int, 新闻分类id
#define News_hottopiclist   @"/ysjapp/v0909/zfy/news/hottopiclist"
//某个专题下新闻列表     uid, String, 专题唯一标识     pnu, int, 每页新闻数     pno, int, 新闻页数
#define News_topicnewslist  @"/ysjapp/v0909/zfy/news/topicnewslist"

#define Myfollow_authorlist @"/ysjapp/v0909/myfollow/authorlist"

//资讯  关注列表  asd, String, sessionid  pno, int, 资讯页数  pnu, int, 每页显示资讯条数
#define Comment_follownews  @"/ysjapp/v0909/comment/follownews"

//获取首页可以关注的作者列表（未登录)    pno, int, 页数    pnu, int, 每页显示的条数
#define Comment_authorlist  @"/ysjapp/v0909/myfollow/authorlist"

//获取可以关注的作者列表（已登录）  asd, String, sessionid  pno, int, 页数    pnu, int, 每页显示的条数
#define Comment_unfollowlist    @"/ysjapp/v0909/myfollowcommit/unfollowlist"

//获取我关注的作者集合    asd, String, sessionid
#define Comment_followusers     @"/ysjapp/v0909/logincommit/followusers"


#pragma mark --Post请求

//发评论       cntuid, String, 资讯唯一标识      cmtuid, String, 回复的评论唯一标识       ct, String, 评论内容
#define News_submit         @"/ysjapp/v0909/zfy/comment/submit"

//文章点赞      cntuid, String, 资讯唯一标识
#define News_contentpraise  @"/ysjapp/v0909/zfy/news/contentpraise"

//评论点赞      cmtuid, String, 评论唯一标识
#define News_commentpraise  @"/ysjapp/v0909/zfy/news/commentpraise"
//登录

//关注作者  asd, String, sessionid     authuid, String, 要关注作者的uuid
#define Myinfo_follow   @"/ysjapp/v0909/myinfo/follow"

//取消关注作者    asd, String, sessionid   authuid, String, 要关注作者的uuid
#define Myinfo_cancel   @"/ysjapp/v0909/myinfo/cancel"


#pragma mark --设置
//修改昵称  nnm, String, 昵称 asd, String, sessionid
#define Account_nnameupdate     @"/ysjapp/v0909/account/nnameupdate"

//更新个性签名    psin, String, 个性签名  asd, String, sessionid
#define Account_signupdate      @"/ysjapp/v0909/account/signupdate"

//更新手机号     unm, String, 手机号    mscd, String, 手机验证码 asd, String, sessionid
#define Account_unameupdate     @"/ysjapp/v0909/account/unameupdate"

//更改密码      oldag, String, 旧密码  ggag, String, 新密码   mscd, String, 短信验证码 asd, String, sessionid
#define Account_pwdupdate       @"/ysjapp/v0909/account/pwdupdate"

//更改头像      imgfile, File, 头像图片文件      asd, String, sessionid
#define Account_headimgupdate   @"/ysjapp/v0909/account/headimgupdate"

//获取登录用户信息      asd, String, sessionid
#define Accout_userbyid         @"/ysjapp/v0909/account/userbyid"

//修改性别  gender, String, 性别
#define Accout_updategender      @"/ysjapp/v0909/account/updategender"


//更新用户背景图片  imgfile, File, 头像图片文件
#define Accout_bgimgupdate        @"/ysjapp/v0909/account/bgimgupdate"

//添加意见建议
#define Suggest_submit          @"/ysjapp/v0909/suggest/submit"

//获取我的积分历史纪录    asd, String, sessionid  pno, int, 页数    pnu, int, 每页显示的条数
#define integral_myintegralhis      @"/ysjapp/v0909/integral/myintegralhis"


#define Login_Url @"/ysjapp/v0909/zfy/login/validate"
//退出登录
#define Logout_Url @"/ysjapp/v0909/logincommit/logout"

//绑定第三方账户
#define BindAccount_Url @"/ysjapp/v0909/zfy/account/bind"

//解绑第三方账户
#define UnBindAccount_Url @"/ysjapp/v0909/zfy/account/unbind"

//第三方账户绑定手机
#define BindmobileAccount_Url @"/ysjapp/v0909/account/bindmobile"


#pragma mark --我的店铺接口
/*
 uuid, String, 商铺唯一标识
 type, int, 商铺类型
 sellername, String, 商铺名称
 address, String, 地址
 tele, String, 电话
 lati, Double, 维度
 lon, String, 经度
 opents, String, 开业时间
 closets, String, 结业时间
 introduction, String, 简介
 asd, String, sessionid
 logo, file, 商铺logo
 imgfile, file, 商铺实景图片
 */

//创建我的店铺 POST
#define Sellercommit_submit     @"/ysjapp/v0909/sellercommit/submit"

/*
 uuid, String, 产品uuid
 seuid, String, 商家uuid
 productname, String, 产品名称
 price, double, 产品价格
 attributes, String, 产品规格
 introduction, String, 产品说明
 brand, String, 品牌
 asd, String, sessionid
 flag, int, 0-创建；1-发布
 imgfile, file, 产品图片
 */

//添加产品
#define sellercommit_saveproduct    @"/ysjapp/v0909/sellercommit/saveproduct"

//商家歇业/重开/删除    uid, String, 商家uuid asd, String, sessionid  lag, int, 操作标记（0-歇业；1-再开业；2-删除）
#define Sellercommit_sellerupdate   @"/ysjapp/v0909/sellercommit/sellerupdate"

//产品下架/上架/删除    uid, String, 产品uuid asd, String, sessionid  flag, int, 操作标记（0-下架；1-上架；2-删除）
#define Sellercommit_productupdate  @"/ysjapp/v0909/sellercommit/productupdate"

//店铺认领  asd, String, sessionid  seuid, String, 商铺uid    POST {"status":"OK"} {"status":"401"}表示当前用户名下已经存在商铺或存在正在审核的商铺
#define Sellercommit_claim          @"/ysjapp/v0909/sellercommit/claim"

//根据字典类型获取字典信息      dtdi, int, 字典类型id 5
#define Dict_listbytype             @"/ysjapp/v0909/dict/listbytype"

//根据唯一标识获取商家        uid, String, 商家唯一标识
#define Seller_sellerbyuid          @"/ysjapp/v0909/seller/sellerbyuid"

//获取商家的产品列表 seuid, String, 商家的uuid  pno, int, 页数    pnu, int, 每页显示的条数
#define Seller_productlist          @"/ysjapp/v0909/seller/productlist"

//获取我的商家的商品列表 seuid, String, 商家唯一标识 pno, int, 页数    pnu, int, 每页显示条数
#define Seller_myproductlist        @"/ysjapp/v0909/seller/myproductlist"

//收藏商家  asd, String, sessionid  seuid, String, 商家唯一标识       POST
#define Myinfo_collect              @"/ysjapp/v0909/myinfo/collect"

//取消收藏商家    asd, String, sessionid  seuid, String, 商家唯一标识
#define Myinfo_uncollect            @"/ysjapp/v0909/myinfo/uncollect"


//随手拍列表     pno, int, 页数     pnu, int, 每页条数
#define publishpic_pubpiclist       @"/ysjapp/v0909/publishpic/pubpiclist"
//随手拍点赞     pubpicuid, String, 随手拍唯一标识      POST
#define publishpic_praise           @"/ysjapp/v0909/publishpic/praise"

#pragma mark --认证接口
/*
 用户认证物业、商家提交信息
 imgfile, file, 证件照片
 asd, String, sessionid
 rn, String, 真实姓名
 phe, String, 手机号
 idcard, String, 证件号码
 type, int, 认证类型
 POST
 */
#define userauthcommit_submit      @"/ysjapp/v0909/userauthcommit/submit"
/*
 商家认证上传营业执照
 asd, String, sessionid
 seuid, String, 商家uid
 idfrontimg, file, 身份证正面照片
 idbackimg, file, 身份证背面照片
 licenseimg, file, 营业执照照片
 POST
 
 */
#define sellercommit_sellerauth     @"/ysjapp/v0909/sellercommit/sellerauth"
/*
 个人实名认证提交信息
 idfrontimg, file, 身份证正面照片
 idbackimg, file, 身份证背面照片
 personimg, file, 个人手持身份证照片
 asd, String, sessionid
 realname, String, 真实姓名
 idcard, String, 身份证号
 POST
 */
#define userauthcommit_personalauth     @"/ysjapp/v0909/userauthcommit/personalauth"
/*
 获取我的实名认证信息
 asd, String, sessionid
 */
#define userauthcommit_mypersonalauth   @"/ysjapp/v0909/userauthcommit/mypersonalauth"
/*
 获取用户的认证信息（商家、物业）
 asd, String, sessionid
 */
#define userauth_userauthbyuid          @"/ysjapp/v0909/userauth/userauthbyuid"


#pragma mark --发布接口
/*
 发布顺风车
 sd, String, 出发地
 ed, String, 目的地
 stt, String, 开始时间时间戳
 hf, float, 花费
 stc, int, 座位数
 meo, String, 顺风车备注
 edt, String, 结束时间时间戳
 rg, int, 分享范围
 msg, String, 活动标题
 asd, String, sessionid
 ciruid, String, 圈子唯一标识
 lati, double, 纬度
 lon, double, 经度
 poinfo, String, 地址
 POST
 */
#define activitysubmit_freeride     @"/ysjapp/v0909/activitysubmit/freeride"
/*
 发布二手物
 imgfiles, file[], 二手物照片
 tl, String, 标题
 decp, String, 描述
 price, double, 价格
 tel, String, 电话
 poinfo, String, 地址
 lati, double, 纬度
 lon, double, 经度
 asd, String, sessionid
 ciruid, String, 圈子唯一标识
 POST
 */
#define pubsechandcommit_pubsechand @"/ysjapp/v0909/pubsechandcommit/pubsechand"
/*
 发布技能
 imgfiles, file[], 资源图片
 decp, String, 资源描述
 price, String, 资源价格描述
 tel, String, 联系电话
 restype, int, 资源类型
 poinfo, String, 发布资源地址
 lati, double, 维度
 lon, double, 经度
 asd, string, sessionid
 ciruid, String, 圈子唯一标识 POST
 */
#define pubrescommit_pubres     @"/ysjapp/v0909/pubrescommit/pubres"


//获取子分类下的全部分类内容 pid, Integer, 分类父id
#define category_allcategorylist    @"/ysjapp/v0909/category/allcategorylist"

//发布内容的新增接口

#define publishingnewcommit_addPublishInfo  @"/ysjapp/v0909/publishingnewcommit/addPublishInfo"



#define circlescommit_addCircleInfo         @"/ysjapp/v0909/circlescommit/addCircleInfo"



#endif /* PLURLHeader_h */
