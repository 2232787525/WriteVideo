//
//  PLConstHeader.m
//  PlamLive
//
//  Created by wangyadong on 2016/11/10.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "PLConstHeader.h"

const NSString * const  ShareDownLink = @"http://www.zhangfangyuan.com/zhangfangyuan/invitationquery.html";
///appstore下载地址
const NSString * const  AppStoreURL = @"https://itunes.apple.com/cn/app/id1182854538?mt=8";
///应用宝下载地址
const NSString * const  MyApp_URL = @"http://a.app.qq.com/o/simple.jsp?pkgname=com.Clanunity";


#pragma mark -  环信appKey
//const NSString * const  EaseMobAppKey = @"1192170227115326#zhangfangyuan";
const NSString * const  EaseMobCerName_DEV = @"Clanunity_dev825";
const NSString * const  EaseMobCerName_RELEASE = @"Clanunity_release825";

#pragma mark - 友盟
const NSString * const  UMAppKey = @"58eb4311c62dca4bab0017c7";
#pragma mark - 高德appkey
const NSString * const MAMapAppKey = @"e9981deafbcc8f917fa1d6702e996369";
#pragma mark - 第三方 qq
//const NSString * const ThirdQQAppId = @"1105839114";
//const NSString * const ThirdQQAppKey = @"mPWt7flUaMcRlvIV";
const NSString * const ThirdQQAppId = @"1105941612";
const NSString * const ThirdQQAppKey = @"zkqUhNgQdSjY4tID";
#pragma mark - 第三方 微信
const NSString * const ThirdWechatAppId = @"wx1ffe4d2f525456b1";
const NSString * const ThirdWechatAppSecret = @"c4bd2912903dd45d1bd135486269f478";
const NSString *const  ThirdWechatPartnerid = @"1440253102";
#pragma mark - shareSDk短信
const NSString * const ThirdShareSMSSDKAppKey = @"1659bb8602003";
const NSString * const ThirdShareSMSSDKSecret = @"e2c1617de2551a3f54271c8a3c36e683";



#pragma mark - 引导页
NSString *const GuidePageStartKey = @"GuidePageStartKey";

#pragma mark - 加密的key
/**生成二维码加密的密钥，个人二维码，群二维码加密解密的key */
NSString *const QRCodeSecretKey = @"QR201710";
/**用户数据中的密码是服务端加密后的，客户端用这个key解密 */
NSString *const EasePassworkSecretKey = @"ZFY12345";

#pragma mark - 通知的key
//随手拍发布成功的通知key
const NSString * const NoticeDatingMomentsSuccess = @"NoticeDatingMomentsSuccess";
//登陆成功
const NSString * const NoticeLoginSuccess = @"NoticeLoginSuccess";
//退出登录
const NSString * const NoticeLogOutSuccess = @"NoticeLogOutSuccess";

//添加收货地址成功
const NSString * const NoticeAddArdessSuccess = @"NoticeAddArdessSuccess";
//修改收货地址成功
const NSString * const NoticeEditArdessSuccess = @"NoticeEditArdessSuccess";

//注册成功
const NSString *const NoticeRegistUserSuccess = @"NoticeRegistUserSuccess";

const NSString * const NoticeRefreshLocation = @"NoticeRefreshLocation";

const NSString * const NoticeNetworkReachabilityStauts = @"NoticeNetworkReachabilityStauts";

//维修提交成功的通知
const NSString * const NoticeSignSuccess = @"NoticeSignSuccess";
//发布分享成功
const NSString * const NoticePublishShareSuccess = @"NoticePublishShareSuccess";



#pragma mark - 保存文件的文件夹名字
const NSString * const AudioFileFolder = @"AudioFileFolder";


#pragma mark - 保存缓存文件的名字
//单次定位缓存的数据
const NSString * const LOCATION_SINGLE = @"LOCATION_SINGLE";
//获取保存小区名称
const NSString * const LOCATION_NEARBY_COMMUNITY = @"LOCATION_NEARBY_COMMUNITY";

//用户登录之后 的数据key
const NSString * const LOGIN_USER_RESULT = @"LOGIN_USER_RESULT";
//用户登录保存的session数据
const NSString * const LOGIN_USER_SESSION = @"LOGIN_USER_SESSION";

const NSString * const CACHE_TOPIC = @"CACHE_TOPIC";

//咨询列表类别的缓存名字
const NSString * const CACHE_NEWSLIST_CATEGORY = @"CACHE_NEWSLIST_CATEGORY_";

//首页 分类缓存
const NSString * const CACHE_HOME_CATEGORY = @"CACHE_HOME_CATEGORY";
//共享发布的分类缓存key
const NSString * const CACHE_SHARE_PUBLISH_CATEGORY = @"CACHE_SHARE_PUBLISH_CATEGORY";

/**缓存的选择的社区的key */
const NSString * const CACHE_SELECTED_AREA_KEY = @"CACHE_SELECTED_AREA_KEY";

/**缓存的选择的社区的所有信息 */
const NSString * const CACHE_SELECTED_AREA_alllnfo_KEY = @"CACHE_SELECTED_AREA_allInfo_KEY";

//首页 4个功能模块的缓存
const NSString * const CACHE_HOME_FUNCCATEGORY_KEY = @"CACHE_HOME_FUNCCATEGORY_KEY";
//分享 页面 功能模块的key
const NSString * const CACHE_SHARE_FUNCCATEGORY_KEY = @"CACHE_SHARE_FUNCCATEGORY_KEY";

//社区 页面 功能模块的key
const NSString * const CACHE_SOCIAL_FUNCCATEGORY_KEY = @"CACHE_SOCIAL_FUNCCATEGORY_KEY";


#pragma mark - 站位图名字
const NSString * const PLACE_HEADIMG = @"placeheadTheme";
const NSString * const PLACE_SQUAREIMG = @"placesquare";
const NSString * const PLACE_SQUARENESSIMG = @"placesquareness";
const NSString * const PLACE_NOPICTURE_GREY = @"nopicture_grey";

#pragma mark -token存储key
const NSString * const ZFYAPP_DEVICETOKEN = @"zhangfangyuanapp_devicetoken";

#pragma mark - 未处理的加群消息本地存储FilePath Key
const NSString * const FP_SocialMessageUntreated = @"social_message_Untreated";


/**数据库 资源文件表名  */
NSString *const ResureTableNameKey = @"ResureTable";


/**登录接口返回的数据 */
const NSString * const USER_LoginResultModel_DATA = @"USER_LoginResultModel_DATA";

/**用户原始数据 */
const NSString * const USER_LoginUserModel_DATA = @"USER_LoginUserModel_DATA";
/**用户utp数据 */
const NSString * const USER_utp_DATA = @"USER_utp_DATA";
/**用户邀请码数据 */
const NSString * const USER_sharecode_DATA = @"USER_sharecode_DATA";
/**用户邀请码-人名字数据 */
const NSString * const USER_shareName_DATA = @"USER_shareName_DATA";

/**用户绑定数据 */
const NSString * const USER_binds_DATA = @"USER_binds_DATA";
/**用户角色数据 */
const NSString * const USER_roleids_DATA = @"USER_roleids_DATA";


/**首页广告轮播图*/
const NSString * const Home_News_BannerListData = @"Home_News_BannerListData";

/**社区公告有新消息*/
const NSString * const CommunityPublicAnnouncement = @"CommunityPublicAnnouncement";



#pragma MARK - 字体大小
CGFloat const PLFONT_MIN = 10.0;

CGFloat const PLFONT_LITTLE = 11.0;
CGFloat const PLFONT_SMALL = 12.0;
CGFloat const PLFONT_MEDIUM = 14.0;
CGFloat const PLFONT_BIG = 15.0;
CGFloat const PLFONT_HUGE = 16.0;


