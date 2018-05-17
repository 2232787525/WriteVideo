//
//  PLHelp.m
//  PlamLive
//
//  Created by wangyadong on 2016/11/4.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "PLHelp.h"
#import "ZLPhotoPickerViewController.h"
#import "ZLCameraViewController.h"
#import "EaseChineseToPinyin.h"
#import <AVFoundation/AVFoundation.h>

#define ImageH   (KScreenWidth - 60)/4
#define ImageW   ImageH
#define PhotoBtnTag  10086
#define MaxCount  4

#define UILABEL_LINE_SPACE 3
#define HEIGHT [ [ UIScreen mainScreen ] bounds ].size.height

@import MapKit;
@import CoreLocation;

@implementation PLHelp
//tablecellForRow方法中调用 - 对应在selectedIndex方法中调用cellForRowSelectedIndex
+(void)tabCellForRowCell:(UITableViewCell *)cell{

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}
// selectedIndex 方法中调用
+(void)tabCellForRowSelectedIndex:(NSIndexPath*)indexPath forTableView:(UITableView*)tableView{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//view切圆角
+(void)cornerRadius:(CGFloat)radius forView:(UIView*)view{
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
}

+(NSString*)dateTimeFromTimestamp:(NSString*)timestamp{
    
    if ([PLHelp isPureNumandCharacters:timestamp]) {
        long long tampNum = [timestamp longLongValue];
        long timesp = (long)tampNum/1000; //Unix 时间戳
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timesp];
        NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"MM-dd HH:mm"];
        NSString* timeStr=[dateFormat stringFromDate:date];
        return timeStr;
    }
    return @"";
}

/**
 判断字符串是否是纯数字

 @param string 判断的含数字的字符串
 */
+(BOOL)isPureNumandCharacters:(NSString *)string
{
   string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}

+(void)imageAspectFillForImageView:(UIImageView*)imgVIew{
    imgVIew.contentMode=UIViewContentModeScaleAspectFill;
    imgVIew.clipsToBounds=YES;
    [imgVIew setContentScaleFactor:[[UIScreen mainScreen] scale]];
}

+(NSString *)timestampToConversion:(NSString *)timestamp type:(kFormater)type{
    
    long long tampNum = [timestamp longLongValue];
    long long timesp = tampNum/1000; //Unix 时间戳
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timesp];
    
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString* timeStr=[dateFormat stringFromDate:date];
    //结束时间
    NSDate *lastDate = [dateFormat dateFromString:timeStr];
    //当前时间  格林尼治时间  相差了8个小时
    NSDate *nowDate = [NSDate date];
    //timeIntervalSinceDate两个时间的时间差 单位是秒
    NSTimeInterval inter = [nowDate timeIntervalSinceDate:lastDate];
    
    //剩余时间
    //天
    int day =inter/86400;
    //小时
    int hour = inter/3600;
    //分
    int mini = (inter - hour*3600)/60;
    //日期
    
    NSString *dateStr = [NSString stringWithFormat:@"%d",hour];
    
    NSString *dateStr1 = [NSString stringWithFormat:@"%d",mini];
    
    NSString *dateStr2 = [NSString stringWithFormat:@"%d",day];
    
    if (day<=3 && day>0)
    {
        return [NSString stringWithFormat:@"%@天前",dateStr2];
        
        
    }else if (day>3)
    {
        
        if (type == kFormaterYearMonth) {
            
            NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
            [dateFormat setDateFormat:@"MM月dd日"];
            NSString* timeStr1=[dateFormat stringFromDate:date];
            
            return timeStr1;
            
        }else
        {
            return timeStr;
        }
        
    }else
    {
        if (hour >0)
        {
            return [NSString stringWithFormat:@"%@小时前",dateStr];
            
        }else
        {
            if (mini>0)
            {
                return [NSString stringWithFormat:@"%@分钟前",dateStr1];
                
            }else
            {
                NSString *str =@"刚刚";
                return str;
            }
        }
        
    }
}

+(NSString*)timestampMD:(NSString*)time
{
    long long timesp = [time longLongValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timesp];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MM-dd"];
    NSString* timeStr=[dateFormat stringFromDate:date];
    return timeStr;
}
/**自定义时间 yyyy-MM-dd */
+(NSString*)timestampformat:(NSString*)format time:(NSString*)time{
    long long timesp = [time longLongValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timesp];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:format];
    NSString* timeStr=[dateFormat stringFromDate:date];
    return timeStr;
}


/**
 年月日 yyyy-MM-dd
 @param time 时间戳，要么是字符串，要么是数字（13位的）
 @return 时间
 */
+(NSString*)timestampYMD:(NSString*)time{
    long long timesp = [time longLongValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timesp];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString* timeStr=[dateFormat stringFromDate:date];
    return timeStr;
}

+(NSString*)timestampHHMM:(NSString*)time{
    long long timesp = [time longLongValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timesp];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"HH:mm"];
    NSString* timeStr=[dateFormat stringFromDate:date];
    return timeStr;
}
/**04.22 12：30 */
+(NSString*)timestampMDHM:(NSString*)time{
    long long timesp = [time longLongValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timesp];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MM.dd HH:mm"];
    NSString* timeStr=[dateFormat stringFromDate:date];
    return timeStr;
}

/**04-22 12：30 */
+(NSString*)timestampMD_HM:(NSString*)time{
    long long timesp = [time longLongValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timesp];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MM-dd HH:mm"];
    NSString* timeStr=[dateFormat stringFromDate:date];
    return timeStr;
}

/**2016-04-22 12：30 */
+(NSString*)timestampYMDHM:(NSString*)time{
    long long timesp = [time longLongValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timesp];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString* timeStr=[dateFormat stringFromDate:date];
    return timeStr;
}
/**2013.12.02 23:23:23 */
+(NSString*)timestampYMDHMS:(NSString*)time{
    long long timesp = [time longLongValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timesp];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    NSString* timeStr=[dateFormat stringFromDate:date];
    return timeStr;
}

/**2017年7月6日 11:32 */
+(NSString*)timestampYMDHM_Chinese:(NSString*)time{
    long long timesp = [time longLongValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timesp];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy年M月d日 H:mm"];
    NSString* timeStr=[dateFormat stringFromDate:date];
    return timeStr;
}

/**2017/7/6*/
+(NSString*)timestampY_M_D:(NSString*)time{
    long long timesp = [time longLongValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timesp];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/M/d"];
    NSString* timeStr=[dateFormat stringFromDate:date];
    return timeStr;
}

/**2017年7月6日*/
+(NSString*)timestampYMD_Chinese:(NSString*)time{
    long long timesp = [time longLongValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timesp];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy年M月d日"];
    NSString* timeStr=[dateFormat stringFromDate:date];
    return timeStr;
}
/**2017.7.6*/
+(NSString*)timestampPointYMD:(NSString*)time{
    long long timesp = [time longLongValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timesp];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy.M.d"];
    NSString* timeStr=[dateFormat stringFromDate:date];
    return timeStr;
}


/**
 当前时间转换为周几
 
 @param currentStr yyyy-MM-dd
 @return @"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"
 */
+ (NSString*)timestampWeekDayWithYMD:(NSString*)currentStr
{
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc]init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式,要注意跟下面的dateString匹配，否则日起将无效
    NSDate*date =[dateFormat dateFromString:currentStr];
    
    NSArray*weekdays = [NSArray arrayWithObjects: [NSNull null],@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",nil];
    NSCalendar* calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone*timeZone = [[NSTimeZone alloc]initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents*theComponents = [calendar components:calendarUnit fromDate:date];
    return [weekdays objectAtIndex:theComponents.weekday];
    
}



+(NSArray*)getCacheBannerFloderImg{

    return nil;
}
+(void)saveBannerFloderWithImgs:(NSArray<UIImage*>*)imgarray{
    
}
+(NSString*)createFolderPathWithFolderName:(NSString*)foldername{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //图片文件夹路径
    NSString *cacheBannerFolder = [DOCUMENT_PATH stringByAppendingPathComponent:foldername];
    //判断是否存在
    if (![fileManager fileExistsAtPath:cacheBannerFolder]) {
        //不存在就创建新的
        [fileManager createDirectoryAtPath:cacheBannerFolder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return cacheBannerFolder;
}
+(BOOL)deleteFolderWithFolderName:(NSString*)folderName{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL finish =  [fileManager removeItemAtPath:[PLHelp createFolderPathWithFolderName:folderName] error:&error];
    return finish;
}
+(NSArray*)getAllFileOfFolderName:(NSString*)folderName{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray * array = [fileManager contentsOfDirectoryAtPath:[PLHelp createFolderPathWithFolderName:folderName] error:nil];
    return array;
}


+(NSString*)cacheImgePathForFolderName:(NSString*)folderName imgName:(NSString*)imgName{
    NSString *imageFilePath = [[PLHelp createFolderPathWithFolderName:folderName] stringByAppendingPathComponent:imgName];
    return imageFilePath;
}
+(NSString*)cacheImgePathForFolderName:(NSString*)folderName withUIImage:(UIImage*)img imgName:(NSString*)imgName{
    NSString *imageFilePath = [[PLHelp createFolderPathWithFolderName:folderName] stringByAppendingPathComponent:imgName];
    BOOL success = [UIImageJPEGRepresentation(img, 0.6) writeToFile:imageFilePath  atomically:YES];
    if (success) {
        return imageFilePath;
    }else{
        return nil;

    }
}
+(kIphone)kIphoneType{
    
    if (KScreenWidth > 320 && KScreenWidth <414) {
        if(KScreenHeight == 812 ){
            return kIphoneX;
        }
        return kIphoneMiddle;
    }
    if(KScreenWidth > 375){
        return kIphonePlus;
    }
    return kIphoneLittle;
}


+(NSString *)psdMD5WithPsd:(NSString *)psd{
    //修剪字符串-把首尾空格去掉
    NSString *psdword =[NSString trimString:psd];
    //1次MD5
    psdword = [NSString md5:psdword];
    //2次MD5
    psdword = [NSString md5:psdword];
    return psdword;
}

+(UIImage *)shootScreenWithView:(UIView*)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    [view.layer renderInContext: ctx];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+(UIVisualEffectView*)effectViewWithframe:(CGRect)frame blurStyle:(UIBlurEffectStyle)style{
    UIBlurEffect * effect = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = frame;
    return effectView;
}



/**
 把美国日期时间转成date

 @param timeString 《Jan 9, 2016 8:20:00 AM》这样的格式的日期

 @return nsdate
 */
+(NSDate*)dateFromUSFormatString:(NSString *)timeString{
    NSDateFormatter* newDF = [[NSDateFormatter alloc] init];
    [newDF setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [newDF setDateFormat:@"MMM d,yyyy hh:mm:ss aa"];
    return [newDF dateFromString:timeString];
}

/**
 日期转时间

 @param date 日期

 @return yyyy-MM-dd HH:mm
 */
+(NSString*)timeStringWithDate:(NSDate*)date{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString* timeStr=[dateFormat stringFromDate:date];
    return timeStr;
}

//TODO:NSDate->yyyyMd
+(NSString*)timeyyyyMdWithDate:(NSDate*)date;{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyyMd"];
    NSString* timeStr=[dateFormat stringFromDate:date];
    return timeStr;
}

/**
 日期转月/日
 
 @param date 日期
 
 @return M-d
 */
+(NSString*)timeStringWithDate_MD:(NSDate*)date{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"M/d"];//D代表今年的第几天 比如10/30 D返回303
    NSString* timeStr=[dateFormat stringFromDate:date];
    return timeStr;
}
+(NSString*)timeStringWithDate_D:(NSDate*)date{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"d"];//D代表今年的第几天 比如10/30 D返回303
    NSString* timeStr=[dateFormat stringFromDate:date];
    return timeStr;
}
/**
 NSDate 转时间戳
 
 @param date
 @return 时间戳
 */
+(NSString*)timestampWithDate:(NSDate*)date{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]*1000];//时间戳
    return timeSp;
}

+(void)shadowView:(UIView*)view Opacity:(CGFloat)opacity Offset:(CGSize)Offset Color:(UIColor*)Color Radius:(CGFloat)radius{
    view.layer.shadowOffset = Offset;
    view.layer.shadowOpacity = opacity;//阴影值
    view.layer.shadowColor = Color.CGColor;
    view.layer.shadowRadius =radius;
}


+(NSAttributedString*)attributedStringCombinationFirstPartString:(NSString*)FString withFontSize:(CGFloat)fsize AndAnotherString:(NSString*)SecStr withFontSize:(CGFloat)Ssize
{
    
    NSInteger str1Num = [FString length];
    NSString * linkStr = [NSString stringWithFormat:@"%@%@",FString,SecStr];
    NSInteger strNum = [linkStr length];
    NSMutableAttributedString *linkedString = [[NSMutableAttributedString alloc] initWithString:linkStr];
    
    [linkedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fsize] range:NSMakeRange(0,str1Num)];
    [linkedString addAttribute:NSForegroundColorAttributeName value:[UIColor PLColorTheme] range:NSMakeRange(0,str1Num)];
    
    [linkedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:Ssize] range:NSMakeRange(str1Num,strNum-str1Num)];
    [linkedString addAttribute:NSForegroundColorAttributeName value:[UIColor PLColorGrayDark] range:NSMakeRange(str1Num,strNum-str1Num)];
    
    
    return linkedString;
}

/**
 时间显示
 @param timestamp 时间戳字符串，13位的
 @return 返回时间显示，同一天中的 3分钟以内的显示刚刚，超过3分钟小于1天的显示具体时间 HH:mm,不在同一天的显示具体日期 MM-dd
 */
+(NSString*)timestampConversion:(NSString*)timestamp{
    
    //完整时间格式
    NSString * formate = @"yyyy-MM-dd HH:mm:ss";
    //时间戳
    long long timestampLongInt = [timestamp longLongValue];
    long long timestampInt = timestampLongInt/1000; //Unix 时间戳
    
    NSDate *timesData = [NSDate dateWithTimeIntervalSince1970:timestampInt];
    
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:formate];
    //结束时间
    @try {
        
        NSDate * nowDate = [NSDate date];
        
        //现成的时间与需要显示的时间戳的时间间隔
        NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:timesData];
        
        // 再然后，把间隔的秒数折算成天数和小时数：
        NSString *resultShowString = @"";
        
        if (timeInterval <= 60*3) {// 3分钟以内的显示 刚刚
            resultShowString = @"刚刚";
            
        }else if(timeInterval<=60*60*24){// 在1天内的
            
            [dateFormat setDateFormat:@"YYYY-MM-dd"];
            NSString * times_yMd = [dateFormat stringFromDate:timesData];
            NSString *now_yMd = [dateFormat stringFromDate:nowDate];
            
            [dateFormat setDateFormat:@"HH:mm"];
            if ([times_yMd isEqualToString:now_yMd]) {
                // 在同一天
                resultShowString = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:timesData]];
            }else{
                //  昨天
                [dateFormat setDateFormat:@"MM-dd HH:mm"];
                resultShowString = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:timesData]];
            }
        }else {
            
            [dateFormat setDateFormat:@"yyyy"];
            NSString * yearStr = [dateFormat stringFromDate:timesData];
            NSString *nowYear = [dateFormat stringFromDate:nowDate];
            
            if ([yearStr isEqualToString:nowYear]) {
                //  在同一年
                [dateFormat setDateFormat:@"MM-dd HH:mm"];
                resultShowString = [dateFormat stringFromDate:timesData];
            }else{
                //不同年的日期yyyy-MM-dd
                [dateFormat setDateFormat:@"MM-dd HH:mm"];
                resultShowString = [dateFormat stringFromDate:timesData];
            }
        }
        return resultShowString;
    
    }
    @catch (NSException *exception) {
        return @"";
    }

}






+ (NSString *)timestampCountYMDconversion:(NSString *)timestamp {
    
    //完整时间格式
    NSString * formate = @"yyyy-MM-dd HH:mm:ss";
    //时间戳
    long long timestampLongInt = [timestamp longLongValue];
    long long timestampInt = timestampLongInt/1000; //Unix 时间戳
    
    NSDate *timesData = [NSDate dateWithTimeIntervalSince1970:timestampInt];
    
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:formate];
    
    @try {
        NSDate * nowDate = [NSDate date];
        
        //现成的时间与需要显示的时间戳的时间间隔
        NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:timesData];
       return [PLHelp TimeToCurrentTime:timeInterval];
    } @catch (NSException *exception) {
        return @"";
    }
}
+(NSString*)TimeToCurrentTime:(NSInteger)time{
    
    NSInteger giveTime = time ;
    NSInteger returnTime ;
    NSInteger  mm      = 60;       //分
    NSInteger  hh      = mm * 60;  // 时
    NSInteger  dd      = hh * 24 ; // 天
    NSInteger  MM      = dd * 30;  // 月
    NSInteger  yy      = MM * 12;  // 年
    
//    if (giveTime < mm) {
//        return [NSString stringWithFormat:@"%ld秒",(long)giveTime];//秒
//    }else if(mm       <= giveTime && giveTime<hh){
//        returnTime  = giveTime / mm ;
//        return [NSString stringWithFormat:@"%ld分钟",(long)returnTime];//分
//    }else if (hh      <= giveTime && giveTime < dd){
//        returnTime     =  giveTime /hh;
//        return [NSString stringWithFormat:@"%ld小时",(long)returnTime];
//    }else
    if (dd      <= giveTime && giveTime < MM){
        returnTime     = giveTime / dd ;
        return [NSString stringWithFormat:@"%ld天",(long)returnTime];
    }else if (MM <= giveTime && giveTime < yy){
        returnTime     = giveTime / MM ;
        return [NSString stringWithFormat:@"%ld月",(long)returnTime];
    }else if (yy <= giveTime){
        returnTime    = giveTime / yy ;
        return [NSString stringWithFormat:@"%ld年",(long)returnTime];
    }
    return @"1天";
}



/**
 *  数据排序 按字母安排（ABCD... 最后一个#号）
 *
 *  @param array 需要排序的数组
 *
 *  @return 返回排序好的数组
 */
+ (NSArray *)dataArrayUsingComparator:(NSArray *)array
{
    
    if ([array containsObject:@"#"]) // 数组中包含#
    {
        NSMutableArray *arrayTemp = [[NSMutableArray alloc] initWithArray:array];
        [arrayTemp removeObject:@"#"];
        
        NSArray *arrayTemp1 = [[NSArray alloc] initWithArray:arrayTemp];
        
        NSArray *arrayTemp2 = [arrayTemp1 sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        
        [arrayTemp removeAllObjects];
        [arrayTemp addObjectsFromArray:arrayTemp2];
        [arrayTemp addObject:@"#"];
        
        NSArray *resultArray = [[NSArray alloc] initWithArray:arrayTemp];
        return resultArray;
    }
    else
    {
        return  [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
    }
}

/**把_cut_small切割字符串*/
+(NSString*)imageUrlReplacing_cut_smallForImgUrl:(NSString*)img{
//    NSString *imgUrl = img;
//    NSRange range1 = [img rangeOfString:@"_cut"];
//    NSRange range2 = [img rangeOfString:@"_small"];
//    if (range1.location != NSNotFound) {
//        imgUrl = [img stringByReplacingOccurrencesOfString:@"_cut" withString:@""];
//    }else if (range2.location != NSNotFound){
//        imgUrl =[img  stringByReplacingOccurrencesOfString:@"_small" withString:@""];
//    }
    
    return [[img stringByReplacingOccurrencesOfString:@"_cut" withString:@""] stringByReplacingOccurrencesOfString:@"_small" withString:@""];
}

//给UILabel设置行间距和字间距
+(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}

//计算UILabel的高度(带有行间距的情况)
+(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+(NSString *)distanceKilometreChange:(double)distance{
    if (distance<1000) {
        return [NSString stringWithFormat:@"%ld米",(long)distance];
    }else{
        double kilometre = distance/1000.0;
        return [NSString stringWithFormat:@"%.2f公里",kilometre];
    }
    return @"";
}




/**13位时间戳获取 */
+(NSString *)timestamp{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    // *1000 是精确到毫秒，不乘就是精确到秒
    NSTimeInterval interval = [date timeIntervalSince1970]*1000;
    //转为字符型
    NSString *timestamp = [NSString stringWithFormat:@"%.0f", interval];
    return timestamp;
}

/**当前时间之后intrval秒，+之后，-之前 */
+(NSString*)timestampSinceNow:(NSInteger)intrval{

    NSDate *otherDate = [NSDate dateWithTimeIntervalSinceNow:intrval];
    // *1000 是精确到毫秒，不乘就是精确到秒
    NSTimeInterval otherInterval = [otherDate timeIntervalSince1970]*1000;
    //转为字符型
    NSString *timestamp = [NSString stringWithFormat:@"%.0f", otherInterval];
    return timestamp;
}


+(void)addPhotoCameraCount:(NSInteger)maxCount haveshowArray:(NSArray*)showArray SelectedVC:(UIViewController*)superVC backData:(void(^)(NSArray<ZLPhotoAssets*>*))block{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil message: nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionC = [UIAlertAction actionWithTitle:@"打开照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
        {
            ZLCameraViewController *camreaVc = [[ZLCameraViewController alloc] init];
            camreaVc.currentViewController = superVC;
            camreaVc.maxCanSelecrted = maxCount-showArray.count;
            [camreaVc setComplate:^(id objc){
                NSArray *array = (NSArray*)objc;
                
                NSMutableArray *photoArr = [NSMutableArray arrayWithCapacity:0];
                [photoArr addObjectsFromArray:showArray];
                for (ZLCamera *camere in array) {
                    ZLPhotoAssets *ass = [ZLPhotoAssets assetWithImage:camere.fullScreenImage];
                    [photoArr addObject:ass];
                }
                block(photoArr);
            }];
            [superVC presentViewController:camreaVc animated:YES completion:nil];
            
        }else
        {
            NSLog(@"模拟其中无法打开照相机,请在真机中使用");
        }
    }];
    [alertController addAction:actionC];
    
    UIAlertAction *actionP = [UIAlertAction actionWithTitle:@"从手机相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
        pickerVc.maxCount = maxCount;
        pickerVc.status = PickerViewShowStatusCameraRoll;
        pickerVc.photoStatus = PickerPhotoStatusPhotos;
        pickerVc.selectPickers = showArray;
        pickerVc.topShowPhotoPicker = YES;
        pickerVc.isShowCamera = NO;
        pickerVc.callBack = ^(NSArray<ZLPhotoAssets *> *status){
            block(status);
        };
        [pickerVc showPickerVc:superVC];
    }];
    [alertController addAction:actionP];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [superVC presentViewController:alertController animated:YES completion:nil];
}

+(void)publishPhotoSubView:(UIView *)fatherView
                    addBtn:(UIButton*)addbtn
                  maxCount:(NSInteger)maxCount
                 WithArray:(NSArray<ZLPhotoAssets *> *)photoAssets
                addClicked:(void (^)())addSelected
             picBtnclicked:(void (^)(UIButton *))senderBlock
                finishBack:(void (^)(UIView*))frameblock{
    
    //改变 - 图片数组确定 显示的行数
    //int rowNum = 0;
    //if (photoAssets.count <= 4 || photoAssets.count == 0) {
        //rowNum = 1;
    //}
    //if (photoAssets.count > 4 && photoAssets.count<=8) {
       //rowNum = 2;
    //}
    //if (photoAssets.count >= 8) {
        //rowNum = 3;
    //}
    [fatherView removeAllSubviews];
    
    CGFloat TBPlace = 10;//图片上下间距
    CGFloat LRPlace = 10;//图片左右间距
    CGFloat ImgWH = ((KScreenWidth - 12*2)-(3*LRPlace))/4.0;//图片的宽高
    //assets.count+1创建btn，最后一个+1的btn作为btnAdd
    CGFloat fatherBottom = 0;
    for (NSInteger i = 0; i < photoAssets.count+1; i++) {
        UIButton *photoBnt = [UIButton buttonWithType:UIButtonTypeCustom];
        photoBnt.frame = CGRectMake(12+ i%4* (LRPlace+ ImgWH),i/4 * (TBPlace+ ImgWH) , ImgWH, ImgWH);
        [fatherView addSubview:photoBnt];
        //创建最后一个+1按钮
        if (i == photoAssets.count) {
            addbtn = photoBnt;
            [addbtn setImage:[UIImage imageNamed:@"publishadd"] forState:UIControlStateNormal];
            addbtn.hidden = photoAssets.count == maxCount ? YES:NO;
            [addbtn handleEventTouchUpInsideWithBlock:^{
                addSelected();
            }];
            if (!addbtn.hidden) {
                fatherBottom = addbtn.bottom_sd;
            }
        }else{
            [photoBnt handleEventTouchUpInsideWithBlock:^{
                senderBlock(photoBnt);
            }];
            photoBnt.tag = PhotoBtnTag + i;
            ZLPhotoAssets *assestModel = photoAssets[i];
            [photoBnt setImage:assestModel.thumbImage forState:UIControlStateNormal];
            [PLHelp imageAspectFillForImageView:photoBnt.imageView];
            fatherBottom = photoBnt.bottom_sd;
        }
    }
    //确定父视图的高
    fatherView.frame = CGRectMake(0,fatherView.top_sd, KScreenWidth,fatherBottom);
    frameblock(fatherView);
}

+(NSString*)appsignGenerateWithAppkey:(NSString*)appkey timestamp:(NSString*)ts{
    NSString *deviceIdentifier =[DeviceIdentifier deviceIdentifier];
    NSString *plam = [NSString stringWithFormat:@"Clanunity"];
    NSString * appsecret  = [DeviceIdentifier hmac:deviceIdentifier withKey:plam];
    NSString *secrectTime = [NSString stringWithFormat:@"%@%@",appsecret,ts];
    NSString *appsign =[DeviceIdentifier hmac:secrectTime withKey:appkey];
    return appsign;
}

+(void)appkeyRequestReturn:(void(^)(NSString *appkey))block{
//    NetworkParameter *parModel = [[NetworkParameter alloc] init];
//    [NetService POST_NetworkParameter:parModel url:URL_authentication_appkey successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if ([responseObject[@"status"] isEqualToString:@"OK"]) {
//            NSString *appkey = [ResponseHelp getAppkeyAkyStringWithResponse:(NSHTTPURLResponse*)task.response];
//            block(appkey);
//        }else{
//            block(nil);
//        }
//    } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        block(nil);
//    }];
}


+(NSString *)mobileSuitScanf:(NSString*)number{
    
    //首先验证是不是手机号码
    
//    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\\\d{8}$";
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    BOOL isOk = [regextestmobile evaluateWithObject:number];
    if (number.length>4) {
        NSString *numberString = [number stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return numberString;
    }else{
        return number;
    }
}


+(void)navimapShowVC:(UIViewController *)backVC lon:(NSString * )lon lai:(NSString * )lai endAddress:(NSString*)endS{
    NSMutableArray *mapsArray = [NSMutableArray arrayWithCapacity:0];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSLog(@"高德");
        NSDictionary *dic= @{@"title":@"高德地图",@"id":@"gaode"};
        [mapsArray addObject:dic];
        
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        NSLog(@"百度");
        NSDictionary *dic= @{@"title":@"百度地图",@"id":@"baidu"};
        [mapsArray addObject:dic];
        
    }
//    NSDictionary *dic= @{@"title":@"苹果地图",@"id":@"apple"};
//    [mapsArray addObject:dic];
    
    NSMutableArray *titlesArray = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary  * dic in mapsArray) {
        [titlesArray addObject:dic[@"title"]];
    }
    if (titlesArray.count == 0) {
        [WFHudView showMsg:@"查看路线\n请下载百度或高德地图" inView:APPDELEGATE.window];
        return;
    }
    
    [PLGlobalClass alertActionSheetWithDefaultTitles:titlesArray cancelTitle:@"取消" forDelegate:backVC defaultActionBlock:^(NSInteger index) {
        
        NSString *appName = [DeviceIdentifier AppstrAppName];
        NSString *backScheme = @"Clanunity://";
        
        
        NSString *key = [mapsArray[index] objectForKey:@"id"];
        if ([key isEqualToString:@"gaode"]) {
            
            NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&backScheme=%@&sname=%@&dname=%@&dev=0&m=0&t=0&sid=BGVIS1&did=BGVIS2&dlat=%@&dlon=%@",appName, backScheme, @"我的位置",endS,lai, lon] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
        if ([key isEqualToString:@"baidu"]) {
            
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%@,%@|name=目的地&mode=driving&coord_type=gcj02",lai,lon] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
            
        }
        if ([key isEqualToString:@"apple"]) {
//            NSDecimalNumber *laiNumber = [NSDecimalNumber decimalNumberWithString:lai];
//            NSDecimalNumber *laiNumberInt = [laiNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"1000000"]];
//            unsigned long laiLong = laiNumberInt.unsignedLongValue;
//            double laiDouble = laiLong * 0.000001;
//
//
//
//            NSDecimalNumber *lonNumber = [NSDecimalNumber decimalNumberWithString:lon];
//            NSDecimalNumber *lonNumberInt = [lonNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"1000000"]];
//            unsigned long lonLong = lonNumberInt.unsignedLongValue;
//            double lonDouble = lonLong * 0.000001;
            
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(lai.doubleValue, lon.doubleValue);
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
            
            [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
            
        }
        
    } cancelBlock:^{
    }];
    
    
}


+(CALayer *)gradualChangeColorWithFrame:(CGRect)frame startColor:(UIColor*)startC startPoint:(CGPoint)startP endColor:(UIColor*)endC endPoint:(CGPoint)endP{
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = frame;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)startC.CGColor,
                       (id)endC.CGColor, nil];
    //比如(0，0）表示从左上角开始变化
    gradient.startPoint = startP;
    //比如（1，1）表示到右下角变化结束
    gradient.endPoint = endP;
    return gradient;
}

+(NSString *)StateTo:(NSString *)status
{
    if ([status  isEqualToString:@"101"])
    {
        NSString *oneStr =@"请输入正确信息";
        
        return oneStr;
        
    }else if ([status  isEqualToString:@"102"])
    {
        NSString *twoStr =@"短信验证码不正确";
        
        return twoStr;
        
    }else if ([status  isEqualToString:@"103"])
    {
        NSString *threeStr =@"用户名不存在";
        
        return threeStr;
        
    }else if ([status  isEqualToString:@"104"])
    {
        NSString *fourStr =@"密码不正确";
        
        return fourStr;
        
    }else if ([status  isEqualToString:@"105"])
    {
        NSString *fiveStr =@"第三方登录失败";
        
        return fiveStr;
        
    }else if ([status  isEqualToString:@"106"])
    {
        NSString *sixStr =@"用户已存在";
        
        return sixStr;
        
    }else if ([status  isEqualToString:@"107"])
    {
        NSString *sevenStr =@"未登录";
        
        return sevenStr;
        
    }else if ([status  isEqualToString:@"108"])
    {
        NSString *sevenStr =@"在不同设备上登录";
        
        return sevenStr;
        
    }else if ([status  isEqualToString:@"109"])
    {
        NSString *sevenStr =@"提交信息不全";
        
        return sevenStr;
        
    }
    else if ([status  isEqualToString:@"110"])
    {
        NSString *sevenStr =@"昵称已存在";
        
        return sevenStr;
        
    }else if ([status  isEqualToString:@"111"])
    {
        NSString *sevenStr =@"第三方用户第一次登陆";
        
        return sevenStr;
        
    }
    else if ([status  isEqualToString:@"121"])
    {
        NSString *sevenStr =@"第三方用户绑定的手机号不存在";
        
        return sevenStr;
        
    }
    else if ([status  isEqualToString:@"122"])
    {
        NSString *sevenStr =@"第三方用户绑定的手机号存在";
        
        return sevenStr;
        
    }
    else if ([status  isEqualToString:@"130"])
    {
        NSString *sevenStr =@"客户端提供的系统时间戳为空";
        
        return sevenStr;
        
    }
    else if ([status  isEqualToString:@"140"])
    {
        NSString *sevenStr =@"已签到";
        
        return sevenStr;
        
    }
    else if ([status  isEqualToString:@"150"])
    {
        NSString *sevenStr =@"没有权限";
        
        return sevenStr;
        
    }
    else if ([status  isEqualToString:@"150"])
    {
        NSString *sevenStr =@"没有权限";
        
        return sevenStr;
        
    }
    else if ([status  isEqualToString:@"300"])
    {
        NSString *sevenStr =@"身份认证成功";
        
        return sevenStr;
        
    }
    else if ([status  isEqualToString:@"301"])
    {
        NSString *sevenStr =@"身份认证失败";
        
        return sevenStr;
        
    }
    else if ([status  isEqualToString:@"302"])
    {
        NSString *sevenStr =@"身份认证信息过期";
        
        return sevenStr;
        
    }
    else if ([status  isEqualToString:@"401"])
    {
        NSString *sevenStr =@"当前用户名下已经存在商铺或存在正在审核的商铺";
        
        return sevenStr;
        
    }
    else if ([status  isEqualToString:@"501"])
    {
        NSString *sevenStr =@"没有权限将该用户踢出圈子";
        
        return sevenStr;
        
    }
    else if ([status  isEqualToString:@"502"])
    {
        NSString *sevenStr =@"当前用户不在圈子中";
        
        return sevenStr;
        
    }
    else if ([status  isEqualToString:@"503"])
    {
        NSString *sevenStr =@"当前用户已在圈子中";
        
        return sevenStr;
        
    }
    else if ([status  isEqualToString:@"601"])
    {
        NSString *sevenStr =@"提交的信息已存在";
        
        return sevenStr;
        
    }
    else
    {
        NSString *eightStr =@"错误";
        
        return eightStr;
    }
    
}
// url特殊字符编码
+ (NSString *)encodeToPercentEscapeString: (NSString *) input

{
    
    NSString *outputStr =
    
    (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                 
                                                                 NULL, /* allocator */
                                                                 
                                                                 (__bridge CFStringRef)input,
                                                                 
                                                                 NULL, /* charactersToLeaveUnescaped */
                                                                 
                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                 
                                                                 kCFStringEncodingUTF8);
    
    return outputStr;
    
}

//验证网址是否可用
+(void)validateUrl: (NSURL *) url returnBlock:(void(^)(BOOL statue))returnBlock{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"HEAD"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"error %@",error);
        if (error) {
            NSLog(@"不可用");
            if (returnBlock) {
                returnBlock(NO);
            }
        }else{
            NSLog(@"可用");
            returnBlock(YES);
        }
    }];
    [task resume];
}

//将字符串（字典、数组、NSDate等七种可存储数据对象）写入沙盒
+(void)write:(id )objcid address:(NSString *)plistName{
    NSLock *theLock = [[NSLock alloc] init];
    [theLock lock];
    NSString *address = [NSString stringWithFormat:@"/%@.plist",plistName];
    NSString *ss= [NSHomeDirectory() stringByAppendingString:@"/Library/Preferences"];
    ss = [NSString stringWithFormat:@"%@%@",ss,address];
    NSMutableDictionary *logDic = [[NSMutableDictionary alloc]initWithContentsOfFile:ss];
    if (!logDic) {
        logDic = [NSMutableDictionary dictionary];
    }
    NSString *date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"MM-dd HH:mm:ss";
    date = [dateFormatter stringFromDate:[NSDate date]];
    [logDic setObject:objcid forKey:[NSString stringWithFormat:@"%@",date]];
    //将dvsToken存入本地推送日志在的 device token.plist里
    [logDic writeToFile:ss atomically:YES];
    [theLock unlock];
}


+(void)writeToFile:(NSString *)plistName withKey:(NSString *)key value:(id )objcid;
{
    NSLock *theLock = [[NSLock alloc] init];
    [theLock lock];
    NSString *address = [NSString stringWithFormat:@"/%@.plist",plistName];
    NSString *ss= [NSHomeDirectory() stringByAppendingString:@"/Library/Preferences"];
    ss = [NSString stringWithFormat:@"%@%@",ss,address];
    NSMutableDictionary *logDic = [[NSMutableDictionary alloc]initWithContentsOfFile:ss];
    if (!logDic) {
        logDic = [NSMutableDictionary dictionary];
    }
    NSString *date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"MM-dd HH:mm:ss";
    date = [dateFormatter stringFromDate:[NSDate date]];
    [logDic setObject:objcid forKey:key];
    //将dvsToken存入本地推送日志在的 device token.plist里
    [logDic writeToFile:ss atomically:YES];
    [theLock unlock];
}

+(id)getValueFromFile:(NSString *)plistName withKey:(NSString *)key;
{
    NSLock *theLock = [[NSLock alloc] init];
    [theLock lock];
    NSString *address = [NSString stringWithFormat:@"/%@.plist",plistName];
    NSString *ss= [NSHomeDirectory() stringByAppendingString:@"/Library/Preferences"];
    ss = [NSString stringWithFormat:@"%@%@",ss,address];
    NSMutableDictionary *logDic = [[NSMutableDictionary alloc]initWithContentsOfFile:ss];
    if (!logDic) {
        logDic = [NSMutableDictionary dictionary];
    }
    NSString *date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"MM-dd HH:mm:ss";
    date = [dateFormatter stringFromDate:[NSDate date]];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:ss];
    
    return [dic objectForKey:key];
//    [logDic setObject:objcid forKey:key];
//    //将dvsToken存入本地推送日志在的 device token.plist里
//    [logDic writeToFile:ss atomically:YES];
    [theLock unlock];
}

//TODO:删除plist文件
+(void)delegateFile:(NSString *)plistName;{
    NSLock *theLock = [[NSLock alloc] init];
    [theLock lock];
    NSString *address = [NSString stringWithFormat:@"/%@.plist",plistName];
    NSString *ss= [NSHomeDirectory() stringByAppendingString:@"/Library/Preferences"];
    ss = [NSString stringWithFormat:@"%@%@",ss,address];
    
    [[NSFileManager defaultManager] removeItemAtPath:ss error:nil];
    [theLock unlock];
}

/**压缩图片,可以传图片的nsdata，或者Uiimage */
+ (NSData *)compressImage:(id)img toByte:(NSUInteger)maxLength{
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = nil;
    if ([img isKindOfClass:[NSData class]]) {
        data = img;
    }else if ([img isKindOfClass:[UIImage class]]){
        data = UIImageJPEGRepresentation(img, compression);
    }
    if (data.length < maxLength) return data;

    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return data;

    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    return data;
}

+(NSString *)mobileCertification:(NSString*)number{
    
    if (number.length>4) {
        NSString *numberString = [number stringByReplacingCharactersInRange:NSMakeRange(3, 14) withString:@"**************"];
        return numberString;
    }else{
        return number;
    }
}

/*获取当前日期所在的一周日期，从周一至周日*/
+(NSMutableArray *)weekArrayWithNowData{
    
    NSDate *date = [NSDate date];
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //calendar.firstWeekday=2;//一周从周一开始
    //获取当天是这周的第几天
    NSInteger daynum = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:[NSDate date]];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    for (int i = 1 - (int)daynum; i <= 7 - daynum; i++) {
        [adcomps setDay:i];
        NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
        NSLog(@"%d, %@",i, newdate);
        [arr addObject:newdate];
    }
    return arr;
}

+ (NSString *)subtitleForDate:(NSDate *)date{
    NSArray * monthArr = [NSArray arrayWithObjects:
                          @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                          @"九月", @"十月", @"冬月", @"腊月", nil];
    
    NSArray *  dayArr = [NSArray arrayWithObjects:
                         @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                         @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                         @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    unsigned unitFlags =  NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSString *monthStr = [monthArr objectAtIndex:localeComp.month-1];
    NSString *dayString = [dayArr objectAtIndex:localeComp.day-1];
    
    NSString *chineseCal_str;
    if ([dayString isEqualToString:@"初一"]) {
        chineseCal_str = monthStr;
    } else {
        chineseCal_str = dayString;
    }
    return chineseCal_str;
}

//颜色转图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    //颜色转换为背景图片
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(void)UploadphotosIfAllowsEditing:(BOOL)allowsEditing;{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //相机
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //判断有无相机设备
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            
            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];//读取设备授权状态
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
                
                [PLGlobalClass aletWithTitle:@"未获得授权使用摄像头" Message:@"请在 设置-隐私-相机中打开" sureTitle:@"知道了" CancelTitle:nil SureBlock:^{
                    [picker removeFromParentViewController];
                } andCancelBlock:^{
                } andDelegate:[APPDELEGATE currentViewController]];
                
                return;
            }
            //访问相机
            //访问相机
            //实例化
            
            //设置图片来源，相机或者相册
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //设置后续是否可编辑
            picker.allowsEditing = allowsEditing;
            //设置代理
            picker.delegate = [APPDELEGATE currentViewController];
            [[APPDELEGATE currentViewController] presentViewController:picker animated:YES completion:nil];
        }else{
            [WFHudView  showMsg:@"未开启相机" inView:[APPDELEGATE currentViewController].view];
        }
    }]];
    //相册
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied){
            //无权限
            [PLGlobalClass aletWithTitle:@"未获得访问相册授权" Message:@"请在 设置-掌方圆-照片中打开" sureTitle:@"知道了" CancelTitle:nil SureBlock:^{
                [picker removeFromParentViewController];
            } andCancelBlock:^{
            } andDelegate:[APPDELEGATE currentViewController]];
            return;
        }
        //访问相册
        //访问相机
        //实例化
        
        //设置图片来源，相机或者相册
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //设置后续是否可编辑
        picker.allowsEditing = allowsEditing;
        //设置代理
        picker.delegate = [APPDELEGATE currentViewController];
        [[APPDELEGATE currentViewController] presentViewController:picker animated:YES completion:nil];
    }]];
    //取消
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    //推出视图控制器
    [[APPDELEGATE currentViewController] presentViewController:alert animated:YES completion:nil];
}

//TODO:判断字符串含不含表情
+ (BOOL)isContainsTwoEmoji:(NSString *)string
{
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         //         NSLog(@"hs++++++++%04x",hs);
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f)
                 {
                     isEomji = YES;
                 }
                 //                 NSLog(@"uc++++++++%04x",uc);
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3|| ls ==0xfe0f) {
                 isEomji = YES;
             }
             //             NSLog(@"ls++++++++%04x",ls);
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
         
     }];
    return isEomji;
}

/**
 判断是不是九宫格
 @param string  输入的字符
 @return YES(是九宫格拼音键盘)
 */
+(BOOL)isNineKeyBoard:(NSString *)string
{
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++)
    {
        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }
    return YES;
}

//TODO:从沙盒取图片
+(UIImage *)getImageFormBox:(NSString *)imgStr;{
    // 读取沙盒路径图片
    NSString *aPath3=[NSString stringWithFormat:@"%@/Documents/imageFinder/%@.png",NSHomeDirectory(),imgStr];
    // 拿到沙盒路径图片
    UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPath3];
    // 图片保存相册
    
    if (imgFromUrl3){
        return imgFromUrl3;
    }else{
        return [UIImage imageNamed:imgStr];
    }
}

//TODO:返回荣誉等级对应的大图标
+(UIImage *)getImageFormBoxWithLevel:(NSInteger)honorlevel{
    switch(honorlevel) {
            
        case 0:
            return [PLHelp getImageFormBox:@"vip_home"];
            break;
            
        case 1:
            return [PLHelp getImageFormBox:@"vip_gold"];
            break;
            
        case 2:
            return [PLHelp getImageFormBox:@"vip_platinum"];
            break;
            
        case 3:
            return [PLHelp getImageFormBox:@"vip_diamond"];
            break;
        default:
            return [PLHelp getImageFormBox:@""];
            break;
    }
}

//TODO:从沙盒读取图片
+(void)setImageWithUIImageView:(UIImageView *)imageView imageStr:(NSString *)imgStr{
    imageView.image = [PLHelp getImageFormBox:imgStr];
}

+(void)sethonorLevel:(NSInteger)honorlevel imageView:(UIImageView *)imageView honoriconBtn:(UIButton *)honorBtn
{
     switch(honorlevel) {
//        case 0:
//             [PLHelp setImageWithUIImageView:imageView imageStr:@""];
//             [PLHelp setImageWithUIImageView:imageView imageStr:@"vip_diamond_header"];
//
//             [honorBtn setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
//             [honorBtn setTitle:@"" forState:(UIControlStateNormal)];
//             honorBtn.backgroundColor = [UIColor clearColor];
//
//            break;
        case 0:
             [PLHelp setImageWithUIImageView:imageView imageStr:@"vip_home_header"];
             
             [honorBtn setImage:[PLHelp getImageFormBox:@"vip_home_icon"] forState:(UIControlStateNormal)];
             [honorBtn setTitle:@"家园使者" forState:(UIControlStateNormal)];
             honorBtn.backgroundColor =  [UIColor colorWithHexString:@"C57D00"];

            break;
        case 1:
             [PLHelp setImageWithUIImageView:imageView imageStr:@"vip_gold_header"];
             
             [honorBtn setImage:[PLHelp getImageFormBox:@"vip_gold_icon"] forState:(UIControlStateNormal)];
             [honorBtn setTitle:@"黄金会员" forState:(UIControlStateNormal)];
             honorBtn.backgroundColor =  [UIColor colorWithHexString:@"C57D00"];

            break;
        case 2:
             [PLHelp setImageWithUIImageView:imageView imageStr:@"vip_platinum_header"];
             
             [honorBtn setImage:[PLHelp getImageFormBox:@"vip_platinum_icon"] forState:(UIControlStateNormal)];
             [honorBtn setTitle:@"铂金会员" forState:(UIControlStateNormal)];
             honorBtn.backgroundColor =  [UIColor colorWithHexString:@"C57D00"];

            break;
        case 3:
             [PLHelp setImageWithUIImageView:imageView imageStr:@"vip_diamond_header"];
             
             [honorBtn setImage:[PLHelp getImageFormBox:@"vip_diamond_icon"] forState:(UIControlStateNormal)];
             [honorBtn setTitle:@"钻石会员" forState:(UIControlStateNormal)];
             honorBtn.backgroundColor =  [UIColor colorWithHexString:@"C57D00"];

            break;
        default:
            break;
    }
}

//TODO:检查日期是否是当月
+(BOOL)checkIfIsCurrentMonth:(NSDate *)thedate;
{
    //是不是本月份 只能补签本月份的
    NSDateComponents *currentcomponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger currentmonth= [currentcomponents month];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:thedate];
    NSInteger month= [components month];
    
    if(month != currentmonth){
        return NO;
    }
    return YES;
}

//TODO:检查日期是不是本月 和今天的关系 -1今天以前 1今天以后 0今天 2不是本月
+(int)compeartheDateWithToday:(NSDate *)thedate;
{
    if([PLHelp checkIfIsCurrentMonth:thedate]){
        
        NSDateComponents *currentcomponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
        NSInteger currentDay= [currentcomponents day];
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:thedate];
        NSInteger day= [components day];
        
        if (day < currentDay) {
            return -1;
        }
        if (day == currentDay) {
            return 0;
        }
        if (day > currentDay) {
            return 1;
        }
    }
    return 2;
}

+(NSArray *)getDayOfThisMonth{
    NSDate *firstDay;
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    //本月是几月
    NSDateComponents *currentcomponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger currentmonth= [currentcomponents month];
    NSInteger currentyear = [currentcomponents year];
    
    //本月天数
    NSUInteger dayNumberOfMonth = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]].length;
    NSLog(@"本月一共的天数 = %ld",(long)dayNumberOfMonth);
    
    firstDay = [PLHelp dateFromStringyyyyMd:[NSString stringWithFormat:@"%ld%ld1",(long)currentyear,(long)currentmonth]];
    NSLog(@"%@  %@",firstDay,[NSString stringWithFormat:@"%ld%ld1",(long)currentyear,(long)currentmonth]);
    
    NSDateFormatter* newDF = [[NSDateFormatter alloc] init];
    [newDF setDateFormat:@"yyyyMd"];
    
    NSDateComponents *lastDateComponents = [calendar components:NSMonthCalendarUnit | NSYearCalendarUnit |NSDayCalendarUnit fromDate:firstDay];

    for (int i=0; i<dayNumberOfMonth; i++) {
        [lastDateComponents setDay:1+i];
        NSDate *dd = [calendar dateFromComponents:lastDateComponents];
        [arr addObject:dd];
    }
    return arr;
}

/*获取某一个日期所在的一周日期，从周一至周日*/
+(NSMutableArray *)weekArrayWithData:(NSDate *)date;{
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //calendar.firstWeekday=2;//一周从周一开始
    //获取当天是这周的第几天
    NSInteger daynum = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:date];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    for (int i = 1 - (int)daynum; i <= 7 - daynum; i++) {
        [adcomps setDay:i];
        NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
        NSLog(@"%d, %@",i, newdate);
        [arr addObject:newdate];
    }
    return arr;
}

//返回完整周的日历时间数组
+(void)getDayOfThisMonthcallBack:(void(^)(NSArray * previousMonth,NSArray *nextMonth,NSArray *thisMonth,NSArray *wholeArray))completion;{
    
    NSArray *thisMonth = [PLHelp getDayOfThisMonth];
    
    NSMutableArray *arr;
    arr = [NSMutableArray arrayWithArray:thisMonth];
    
    NSDate *firstDate = [arr firstObject];
    NSArray *firstWeekArr = [PLHelp weekArrayWithData:firstDate];
    NSMutableArray *previousMonth = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i=0; i<firstWeekArr.count; i++) {
        if ([PLHelp checkIfIsCurrentMonth:firstWeekArr[i]]) {
         //本月日期
        }else{
            // 不是本月
            [previousMonth addObject:firstWeekArr[i]];
        }
    }
    
    NSDate *lastDate = [arr lastObject];
    NSArray *lastWeekArr = [PLHelp weekArrayWithData:lastDate];
    NSMutableArray *nextMonth = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i=0; i<lastWeekArr.count; i++) {
        if ([PLHelp checkIfIsCurrentMonth:lastWeekArr[i]]) {
            //本月日期
        }else{
            // 不是本月
            [nextMonth addObject:lastWeekArr[i]];
        }
    }
    
    NSRange range = NSMakeRange(0, previousMonth.count);
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
    [arr insertObjects:previousMonth atIndexes:set];
    [arr addObjectsFromArray:nextMonth];
    
    if(completion){
        completion(previousMonth,nextMonth,thisMonth,arr);
    }
}


/**
 把美国日期时间转成date
 
 @param timeString 《Jan 9, 2016 8:20:00 AM》这样的格式的日期
 
 @return nsdate
 */
+(NSDate*)dateFromStringyyyyMd:(NSString *)timeString{
    NSDateFormatter* newDF = [[NSDateFormatter alloc] init];
    [newDF setDateFormat:@"yyyyMd"];
    return [newDF dateFromString:timeString];
}


+(void)currentver:(NSString*)current lastver:(NSString*)lastver{
    if ([current compare:lastver options:NSNumericSearch] ==NSOrderedDescending){
        NSLog(@"%@ is bigger",current);
    }
    else{
        NSLog(@"%@ is bigger",lastver);
    }
    
}

@end
