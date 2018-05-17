//
//  PLHelp.h
//  PlamLive
//
//  Created by wangyadong on 2016/11/4.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLPhotoAssets.h"
//响应成功的回调
typedef void(^SuccessSure) (UITextField *textField);

typedef enum : NSUInteger {
    kFormaterAll,
    kFormaterYearMonth,
} kFormater;


typedef enum : NSUInteger {
    kIphonePlus,//6p,6sp,7p
    kIphoneLittle,//4,4s,5,5s,5e,se
    kIphoneMiddle,//6,6s,7,
    kIphoneX,
} kIphone;


@interface PLHelp : NSObject

/**table
 cellForRow方法中调用 - 对应在selectedIndex方法中调用cellForRowSelectedIndex
 */
+(void)tabCellForRowCell:(UITableViewCell*)cell;

/**
 selectedIndex 方法中调用
 */
+(void)tabCellForRowSelectedIndex:(NSIndexPath*)indexPath forTableView:(UITableView*)tableView;
//view切圆角
+(void)cornerRadius:(CGFloat)radius forView:(UIView*)view;


/**
 时间戳转 yyyy-MM-dd 格式的时间
 @param timestamp 时间戳字符串
 */
+(NSString*)dateTimeFromTimestamp:(NSString*)timestamp;



/**
 调整imgView的内容显示模式，使充满
 */
+(void)imageAspectFillForImageView:(UIImageView*)imgVIew;


/**
 时间戳转换

 @param timestamp 时间戳
 @param type      格式

 @return 时间
 */
+(NSString *)timestampToConversion:(NSString *)timestamp type:(kFormater)type;

//创建文件夹
+(NSString*)createFolderPathWithFolderName:(NSString*)foldername;
//删除文件夹
+(BOOL)deleteFolderWithFolderName:(NSString*)folderName;
//获取该文件夹下所有文件
+(NSArray*)getAllFileOfFolderName:(NSString*)folderName;
//缓存图片
+(NSString*)cacheImgePathForFolderName:(NSString*)folderName withUIImage:(UIImage*)img imgName:(NSString*)imgName;
//图片地址
+(NSString*)cacheImgePathForFolderName:(NSString*)folderName imgName:(NSString*)imgName;

/**
 根据屏幕宽获取宽
 */
+(kIphone)kIphoneType;


+(void)addPhotoCameraCount:(NSInteger)maxCount haveshowArray:(NSArray*)showArray SelectedVC:(UIViewController*)superVC backData:(void(^)(NSArray<ZLPhotoAssets*>*))block;

+(void)publishPhotoSubView:(UIView *)fatherView
                    addBtn:(UIButton*)addbtn
                  maxCount:(NSInteger)maxCount
                 WithArray:(NSArray<ZLPhotoAssets *> *)photoAssets
                addClicked:(void (^)())addSelected
             picBtnclicked:(void (^)(UIButton *))senderBlock
                finishBack:(void (^)(UIView*))frameblock;


/**
 掌方圆 用户输入的密码 经过2次MD5加密

 @param psd 用户原始输入的text

 @return 加密之后的text
 */
+(NSString*)psdMD5WithPsd:(NSString*)psd;


/**
 截屏

 @param view 被截的view

 @return 图片
 */
+(UIImage *)shootScreenWithView:(UIView*)view;


/**
 毛玻璃效果view，拿到这个之后添加到需要显示毛玻璃的view上
 @param frame fame
 @param style 类型，黑的，亮的
 @return view
 */
+(UIVisualEffectView*)effectViewWithframe:(CGRect)frame blurStyle:(UIBlurEffectStyle)style;


/**
 把美国日期时间转成date
 
 @param timeString ->《Jan 9, 2016 8:20:00 AM》这样的格式的日期
 
 @return nsdate
 */
+(NSDate*)dateFromUSFormatString:(NSString*)timeString;
/**
 日期转时间
 
 @param date 日期
 
 @return yyyy-MM-dd HH:mm
 */
+(NSString*)timeStringWithDate:(NSDate*)date;

//TODO:NSDate->yyyyMd
+(NSString*)timeyyyyMdWithDate:(NSDate*)date;

/**
 日期转月/日
 
 @param date 日期
 
 @return M-d
 */
+(NSString*)timeStringWithDate_MD:(NSDate*)date;

/**
 日期转日
 
 @param date 日期
 
 @return d
 */
+(NSString*)timeStringWithDate_D:(NSDate*)date;

/**
 NSDate 转时间戳

 @param date
 @return 时间戳
 */
+(NSString*)timestampWithDate:(NSDate*)date;

/**
 给view设置阴影

 @param view    view
 @param opacity 阴影值 0~1
 @param Offset  CGSizeMake(0, 0)   / (-1,-1)
 @param Color   阴影颜色
 */

/**
 给view设置阴影

 @param view    view
 @param opacity 阴影值 0~1
 @param Offset  CGSizeMake(0, 0)   / (-1,-1)
 @param Color   阴影颜色
 @param radius  圆角
 */
+(void)shadowView:(UIView*)view Opacity:(CGFloat)opacity Offset:(CGSize)Offset Color:(UIColor*)Color Radius:(CGFloat)radius;
/**
 年月日
 @param time 时间戳，要么是字符串，要么是数字（13位的）
 @return 时间
 */

/**yyyy-MM-dd*/
+(NSString*)timestampYMD:(NSString*)time;
/**2013.12.12 23:23:23 */
+(NSString*)timestampYMDHMS:(NSString*)time;

/**2017年7月6日 11:32 */
+(NSString*)timestampYMDHM_Chinese:(NSString*)time;

/**2017/7/6*/
+(NSString*)timestampY_M_D:(NSString*)time;

/**2017年7月6日*/
+(NSString*)timestampYMD_Chinese:(NSString*)time;
/**2017.7.6*/
+(NSString*)timestampPointYMD:(NSString*)time;
/**
 月-日

 @param time 时间
 @return 时间
 */
+(NSString*)timestampMD:(NSString*)time;


/**
 自定义时间显示

 @param format 时间格式 yyyy-MM-dd
 @param time 时间
 @return 时间
 */
+(NSString*)timestampformat:(NSString*)format time:(NSString*)time;

/**
 时间 时分

 @param time 时间戳

 @return 返回时间
 */
+(NSString*)timestampHHMM:(NSString*)time;

/**04.22 12：30 */
+(NSString*)timestampMDHM:(NSString*)time;

/**04-22 12：30 */
+(NSString*)timestampMD_HM:(NSString*)time;

/**2016-04-22 12：30 */
+(NSString*)timestampYMDHM:(NSString*)time;


/**
 当前时间转换为周几
 @param currentStr yyyy-MM-dd
 @return @"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"
 */
+ (NSString*)timestampWeekDayWithYMD:(NSString*)currentStr;

/**
 时间转换 刚刚，几分钟前，今天，昨天，3月2日，2015-12-21
 @param dateString 时间戳字符串
 @return 刚刚，几分钟前，今天，昨天，3月2日，2015-12-21
 */
+(NSString*)timestampConversion:(NSString*)dateString;

//几年几月几天几日几时几分几秒
+ (NSString *)timestampCountYMDconversion:(NSString *)timestamp;
/**当前时间之后intrval秒，+之后，-之前 */
+(NSString*)timestampSinceNow:(NSInteger)intrval;

+(NSAttributedString*)attributedStringCombinationFirstPartString:(NSString*)FString withFontSize:(CGFloat)fsize AndAnotherString:(NSString*)SecStr withFontSize:(CGFloat)Ssize;

/**
 *  数据排序 按字母安排（ABCD... 最后一个#号）
 *
 *  @param array 需要排序的数组
 *
 *  @return 返回排序好的数组
 */
+ (NSArray *)dataArrayUsingComparator:(NSArray *)array;
/**把_cut_small切割字符串*/
+(NSString*)imageUrlReplacing_cut_smallForImgUrl:(NSString*)img;

//给UILabel设置行间距和字间距
+(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font;
//计算UILabel的高度(带有行间距的情况)
+(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


/**
 距离显示 1000内显示具体多少米，1000以外显示多少公里，保留2位小数

 @param distance 数字
 @return 显示
 */
+(NSString*)distanceKilometreChange:(double)distance;


/**
 13位的时间戳
 @return 时间戳字符串
 */
+(NSString *)timestamp;

/**
 生成签名 的方法 时间戳主要要给的一致
 @param appkey appkey
 @param ts 时间戳
 @return 签名
 */
+(NSString*)appsignGenerateWithAppkey:(NSString*)appkey timestamp:(NSString*)ts;

/**
 关键操作先获取appkey
 网络获取 appkey
 @param block 回调 带appkey
 */
+(void)appkeyRequestReturn:(void(^)(NSString *appkey))block;

/**手机号隐藏中间四位 */
+(NSString *)mobileSuitScanf:(NSString*)number;
/**身份证号隐藏中间四位 */
+(NSString *)mobileCertification:(NSString*)number;

+(void)navimapShowVC:(UIViewController *)backVC lon:(NSString * )lon lai:(NSString * )lai endAddress:(NSString*)endS;


//TODO:渐变色加载到layer上
/**
 渐变色加载到layer上
 
 @param frame 渐变大小位置
 @param startC 开始颜色
 @param startP 结束颜色
 @param endC 开始变动点
 @param endP 结束点
 @return layer
 */
+(CALayer *)gradualChangeColorWithFrame:(CGRect)frame startColor:(UIColor*)startC startPoint:(CGPoint)startP endColor:(UIColor*)endC endPoint:(CGPoint)endP;
+(NSString *)StateTo:(NSString *)status;
// url特殊字符编码
+ (NSString *)encodeToPercentEscapeString: (NSString *) input;

//TODO:验证网址是否可用
/**
 验证网址是否可用

 @param url NSURL
 @param returnBlock YES 网址可用 NO 网址无效
 */
+(void)validateUrl: (NSURL *) url returnBlock:(void(^)(BOOL statue))returnBlock;


//TODO:将字典、数组、字符串、NSDate等七种可存储数据对象写入沙盒
/**
 将字典、数组、字符串、NSDate等七种可存储数据对象写入沙盒

 @param objcid 要存储的数据对象
 @param plistName 要存储到的plist文件名称
 */
+(void)write:(id )objcid address:(NSString *)plistName;


//TODO:将字典、数组、字符串、NSDate等七种可存储数据对象写入沙盒
/**
 将字典、数组、字符串、NSDate等七种可存储数据对象写入沙盒
 
 @param objcid 要存储的数据对象
 @param plistName 要存储到的plist文件名称
 */
+(void)writeToFile:(NSString *)plistName withKey:(NSString *)key value:(id )objcid;

+(id)getValueFromFile:(NSString *)plistName withKey:(NSString *)key;

//TODO:删除plist文件
+(void)delegateFile:(NSString *)plistName;

/**压缩图片,可以传图片的nsdata，或者Uiimage */
+ (NSData *)compressImage:(id)img toByte:(NSUInteger)maxLength;

/*获取当前日期所在的一周日期，从周一至周日*/
+(NSMutableArray *)weekArrayWithNowData;

/*获取NSDate的农历表示 eg：初二、初三、十五*/
+ (NSString *)subtitleForDate:(NSDate *)date;
//颜色转图片
+ (UIImage *)imageWithColor:(UIColor *)color;

//TODO:（相册、相机弹框和跳转）单选一张图片 参数allowsEditing,YES时切成正方形 NO时不处理图片
//选出的图片切割成方形PrincessCut
+(void)UploadphotosIfAllowsEditing:(BOOL)allowsEditing;

//TODO:判断字符串含不含表情
+ (BOOL)isContainsTwoEmoji:(NSString *)string;

//TODO: 判断是不是九宫格
+(BOOL)isNineKeyBoard:(NSString *)string;

//TODO:从沙盒取图片 取不到直接取Assets.xcassets
+(UIImage *)getImageFormBox:(NSString *)imgStr;

//TODO:返回荣誉等级对应的大图标
+(UIImage *)getImageFormBoxWithLevel:(NSInteger)honorlevel;

//TODO:设置图片的image 先从沙盒取 取不到直接取Assets.xcassets
+(void)setImageWithUIImageView:(UIImageView *)imageView imageStr:(NSString *)imgStr;

//TODO:荣誉等级头像小图标设置
+(void)sethonorLevel:(NSInteger)honorlevel imageView:(UIImageView *)imageView honoriconBtn:(UIButton *)honorBtn;

//TODO:检查日期是否是当月
+(BOOL)checkIfIsCurrentMonth:(NSDate *)thedate;

//TODO:检查日期是不是本月 和今天的关系 -1今天以前 1今天以后 0今天 2不是本月
+(int)compeartheDateWithToday:(NSDate *)thedate;

//TODO: 得到这个月的第一天和最后一天
+(NSArray *)getDayOfThisMonth;

/*获取某一个日期所在的一周日期，从周一至周日*/
+(NSMutableArray *)weekArrayWithData:(NSDate *)date;

//得到整个月的日期 包括月前月后的整周
+(void)getDayOfThisMonthcallBack:(void(^)(NSArray * previousMonth,NSArray *nextMonth,NSArray *thisMonth,NSArray *wholeArray))completion;

/**
 把日期时间转成date
 @param timeString yyyyMd
 @return nsdate
 */
+(NSDate*)dateFromStringyyyyMd:(NSString *)timeString;
@end
