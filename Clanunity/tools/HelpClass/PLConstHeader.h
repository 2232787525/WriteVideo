//
//  PLConstHeader.h
//  PlamLive
//
//  Created by wangyadong on 2016/11/10.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef  LocPLConstHeader_h
#define  LocPLConstHeader_h


UIKIT_EXTERN NSString * const  ShareDownLink;
///appstore下载地址
UIKIT_EXTERN NSString * const  AppStoreURL;
///应用宝下载地址
UIKIT_EXTERN NSString * const  MyApp_URL;


#pragma mark -  环信appKey
//UIKIT_EXTERN NSString * const  EaseMobAppKey;
UIKIT_EXTERN NSString * const  EaseMobCerName_DEV;
UIKIT_EXTERN NSString * const  EaseMobCerName_RELEASE;

#pragma mark - 友盟
UIKIT_EXTERN NSString * const  UMAppKey;

#pragma mark - 高德appkey
UIKIT_EXTERN NSString * const MAMapAppKey;
#pragma mark - 第三方 qq
UIKIT_EXTERN NSString * const ThirdQQAppId;
UIKIT_EXTERN NSString * const ThirdQQAppKey;

#pragma mark - 第三方 微信
UIKIT_EXTERN NSString * const ThirdWechatAppId;
UIKIT_EXTERN NSString * const ThirdWechatPartnerid;
UIKIT_EXTERN NSString * const ThirdWechatAppSecret;
#pragma mark - shareSDk短信
UIKIT_EXTERN NSString * const ThirdShareSMSSDKAppKey;
UIKIT_EXTERN NSString * const ThirdShareSMSSDKSecret;
#pragma mark - 科大讯飞

UIKIT_EXTERN NSString *const GuidePageStartKey;

#pragma mark - 加密的key
/**生成二维码加密的密钥 */
UIKIT_EXTERN NSString *const QRCodeSecretKey;
/**用户数据中的密码是服务端加密后的，客户端用这个key解密 */
UIKIT_EXTERN NSString *const EasePassworkSecretKey;


#pragma mark - 通知的key
//随手拍发布成功的通知key
UIKIT_EXTERN NSString * const NoticeDatingMomentsSuccess;
//登录成功通知
UIKIT_EXTERN NSString * const NoticeLoginSuccess;
//退出登录成功
UIKIT_EXTERN NSString * const NoticeLogOutSuccess;

//添加收货地址成功
UIKIT_EXTERN NSString * const NoticeAddArdessSuccess;
//修改收货地址成功
UIKIT_EXTERN NSString * const NoticeEditArdessSuccess;

//注册成功
UIKIT_EXTERN NSString * const NoticeRegistUserSuccess;

//刷新位置
UIKIT_EXTERN NSString * const NoticeRefreshLocation;
//签到成功
UIKIT_EXTERN NSString * const NoticeSignSuccess;

UIKIT_EXTERN NSString * const NoticePublishShareSuccess;

UIKIT_EXTERN NSString * const NoticeNetworkReachabilityStauts;

#pragma mark - 保存文件的文件夹名字
UIKIT_EXTERN NSString * const AudioFileFolder;

#pragma mark - 保存缓存文件的名字
//单次定位缓存的数据
UIKIT_EXTERN NSString * const LOCATION_SINGLE;
//获取保存小区名称
UIKIT_EXTERN NSString * const LOCATION_NEARBY_COMMUNITY;
//缓存话题列表
UIKIT_EXTERN NSString * const CACHE_TOPIC;

//首页 分类列表每个分类的前10条数据的缓存
UIKIT_EXTERN NSString * const CACHE_NEWSLIST_CATEGORY;

//用户登录之后 的数据key
UIKIT_EXTERN NSString * const LOGIN_USER_RESULT;
//用户登录保存的session数据
UIKIT_EXTERN NSString * const LOGIN_USER_SESSION;
//首页 分类缓存
UIKIT_EXTERN NSString * const CACHE_HOME_CATEGORY;

//首页 4个功能模块的缓存
UIKIT_EXTERN NSString * const CACHE_HOME_FUNCCATEGORY_KEY;
//分享 页面 功能模块的key
UIKIT_EXTERN NSString * const CACHE_SHARE_FUNCCATEGORY_KEY;

//社区 页面 功能模块的key
UIKIT_EXTERN NSString * const CACHE_SOCIAL_FUNCCATEGORY_KEY;

//共享发布的分类缓存key
UIKIT_EXTERN NSString * const CACHE_SHARE_PUBLISH_CATEGORY;

/**缓存的选择的社区的key */
UIKIT_EXTERN NSString * const CACHE_SELECTED_AREA_KEY;

/**缓存的选择的社区的所有信息 */
UIKIT_EXTERN NSString * const CACHE_SELECTED_AREA_alllnfo_KEY;

/**登录接口返回的数据 */
UIKIT_EXTERN NSString * const USER_LoginResultModel_DATA;

/**用户原始数据 */
UIKIT_EXTERN NSString * const USER_LoginUserModel_DATA;

/**用户utp数据 */
UIKIT_EXTERN NSString * const USER_utp_DATA;

/**用户邀请码数据 */
UIKIT_EXTERN NSString * const USER_sharecode_DATA;
/**用户邀请码-人名字数据 */
UIKIT_EXTERN NSString * const USER_shareName_DATA;

/**用户绑定数据 */
UIKIT_EXTERN NSString * const USER_binds_DATA;
/**用户角色数据 */
UIKIT_EXTERN NSString * const USER_roleids_DATA;


UIKIT_EXTERN NSString * const Home_News_BannerListData;

/**社区公告有新消息*/
UIKIT_EXTERN NSString * const CommunityPublicAnnouncement;


/**数据库 资源文件表名  */
UIKIT_EXTERN NSString *const ResureTableNameKey;

#pragma mark - 站位图名字
//头像的站位图
UIKIT_EXTERN NSString * const PLACE_HEADIMG;
//正方形站位图
UIKIT_EXTERN NSString * const PLACE_SQUAREIMG;
//长方形站位图
UIKIT_EXTERN NSString * const PLACE_SQUARENESSIMG;
//正方形站位图-社群头像
UIKIT_EXTERN NSString * const PLACE_NOPICTURE_GREY;

#pragma mark -token存储key
UIKIT_EXTERN NSString * const ZFYAPP_DEVICETOKEN;

#pragma mark - 未处理的加群消息本地存储FilePath Key
UIKIT_EXTERN NSString * const FP_SocialMessageUntreated;

#pragma MARK - 字体大小
/**12号字体 */
UIKIT_EXTERN CGFloat const FONT_SMALL;
/**14号字体 */
UIKIT_EXTERN CGFloat const FONT_MEDIUM;
/**16号字体 */
UIKIT_EXTERN CGFloat const FONT_BIG;
/**18号字体 */
UIKIT_EXTERN CGFloat const FONT_HUGE;


#pragma MARK - 字体大小
/**10号字体 */
UIKIT_EXTERN CGFloat const PLFONT_MIN;

/**11号字体 */
UIKIT_EXTERN CGFloat const PLFONT_LITTLE;

/**12号字体 */
UIKIT_EXTERN CGFloat const PLFONT_SMALL;
/**14号字体 */
UIKIT_EXTERN CGFloat const PLFONT_MEDIUM;
/**16号字体 */
UIKIT_EXTERN CGFloat const PLFONT_BIG;
/**18号字体 */
UIKIT_EXTERN CGFloat const PLFONT_HUGE;






#endif
