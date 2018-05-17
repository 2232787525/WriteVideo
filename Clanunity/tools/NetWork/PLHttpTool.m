//
//  PLHttpTool.m
//  PLHttp
//
//  Created by Mac on 16/10/19.
//  Copyright © 2016年 ZhangFY. All rights reserved.
//

#import "PLHttpTool.h"
//设备信息 公共参数
#import "PLDeviceIdentifier.h"
#import "NSData+Base64.h"

@implementation PLHttpTool

+(void)UrlCoding:(NSString *)url
{
    url =  [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}
//Get  公共参数
+(NSString * )parmsGet
{
    //设备分辨率
    NSString *Screenrl =[PLDeviceIdentifier DeviceScreenrl];
    //设备像素
    NSString *Screenpx =[PLDeviceIdentifier DeviceScreenpx];
    //设备品牌
    NSString *deviceBrand =[PLDeviceIdentifier DeviceBrand];
    //设备编号
    NSString *deviceIdentifier =[PLDeviceIdentifier deviceIdentifier];
    //设备型号
    NSString *phoneModel =[PLDeviceIdentifier DevicephoneModel];
    //设备版本号
    NSString *SysVersion =[PLDeviceIdentifier DevicestrSysVersion];
    //APP 版本号
    NSString *AppV =[PLDeviceIdentifier AppstrAppVersion];
    //当前网络
    NSString *network =[PLDeviceIdentifier networkingStatesFromStatebar];
    
    NSString *cmpms =[NSString stringWithFormat:@"iiod=1&d_brand=%@&d_platform=ios %@&d_model=%@&d_code=%@&dpi=%@&resolution=%@&v_code=%@&v_name=%@&nc=%@",deviceBrand,SysVersion,phoneModel,deviceIdentifier,Screenpx,Screenrl,AppV,@"common",network,nil,nil];
    
    return cmpms;
}

+(NSDictionary *)parmsPosttest
{
    //设备分辨率
    NSString *Screenrl =[PLDeviceIdentifier DeviceScreenrl];
    
    //设备像素
    NSString *Screenpx =[PLDeviceIdentifier DeviceScreenpx];
    
    //设备品牌
    NSString *deviceBrand =[PLDeviceIdentifier DeviceBrand];
    
    //设备编号
    NSString *deviceIdentifier =[PLDeviceIdentifier deviceIdentifier];
    
    //设备型号
    NSString *phoneModel =[PLDeviceIdentifier DevicephoneModel];
    
    //设备版本号
    NSString *SysVersion =[PLDeviceIdentifier DevicestrSysVersion];
    
    //APP 版本号
    NSString *AppV =[PLDeviceIdentifier AppstrAppVersion];
    
    //当前网络
    NSString *network =[PLDeviceIdentifier networkingStatesFromStatebar];
    
    NSDictionary *cmpmsDic =@{@"iiod":@"1",
                              @"d_brand":deviceBrand,
                              @"d_platform":SysVersion,
                              @"d_model":phoneModel,
                              @"d_code":deviceIdentifier,
                              @"dpi":Screenpx,
                              @"resolution":Screenrl,
                              @"v_code":AppV,
                              @"v_name":@"common",
                              @"nc":network,
                              };
    
    return cmpmsDic;
}


//Post 公共参数
+(NSDictionary *)parmsPost
{
    //设备分辨率
    NSString *Screenrl =[PLDeviceIdentifier DeviceScreenrl];
    
    //设备像素
    NSString *Screenpx =[PLDeviceIdentifier DeviceScreenpx];
    
    //设备品牌
    NSString *deviceBrand =[PLDeviceIdentifier DeviceBrand];
    
    //设备编号
    NSString *deviceIdentifier =[PLDeviceIdentifier deviceIdentifier];
    
    //设备型号
    NSString *phoneModel =[PLDeviceIdentifier DevicephoneModel];
    
    //设备版本号
    NSString *SysVersion =[PLDeviceIdentifier DevicestrSysVersion];
    
    //设备签名
//    NSString *appsign = [PLDeviceIdentifier hmac:deviceIdentifier withKey:@"palmlive"];
    
    //APP 名字
//    NSString *AppName =[PLDeviceIdentifier AppstrAppName];
    
    //APP 版本号
    NSString *AppV =[PLDeviceIdentifier AppstrAppVersion];
    
    //当前网络
    NSString *network =[PLDeviceIdentifier networkingStatesFromStatebar];
    
    //lati
    NSNull *latinull = [NSNull null];
    
    //lon
    NSNull *lonNull =[NSNull null];
    
    NSDictionary *cmpmsDic =@{@"iiod":@"1",
                              @"d_brand":deviceBrand,
                              @"d_platform":SysVersion,
                              @"d_model":phoneModel,
                              @"d_code":deviceIdentifier,
                              @"dpi":Screenpx,
                              @"resolution":Screenrl,
                              @"v_code":AppV,
                              @"v_name":@"common",
                              @"nc":network,
                              @"lati":latinull,
                              @"lon":lonNull,
                              };
    
    return cmpmsDic;
}
//请求头
+(void)registerRequestHeader:(AFHTTPSessionManager*)manager{
    
    
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];
    NSData * certData =[NSData dataWithContentsOfFile:cerPath];
    NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:2];
    // 是否允许,NO-- 不允许无效的证书
    [securityPolicy setAllowInvalidCertificates:YES];
    // 设置证书
    [securityPolicy setPinnedCertificates:certSet];
    manager.securityPolicy = securityPolicy;

    NSLog(@"%ld",manager.securityPolicy.SSLPinningMode);
    
    //模拟请求头参数
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];

    //APP name
    NSString *AppName =[PLDeviceIdentifier AppstrAppName];
    //App 版本
    NSString *AppV =[PLDeviceIdentifier AppstrAppVersion];
    //设备 版本
    NSString *SysVersion =[PLDeviceIdentifier DevicestrSysVersion];
    //设备 型号
    NSString *phoneModel =[PLDeviceIdentifier DevicephoneModel];
    
    NSString *UserAgnet =[NSString stringWithFormat:@"%@ %@ (ios/%@ %@)",AppName,AppV,SysVersion,phoneModel];
    
    [manager.requestSerializer setValue:UserAgnet forHTTPHeaderField:@"User-Agent"];
    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [manager.requestSerializer setValue:@"Keep-Alive" forHTTPHeaderField:@"Connection"];
    
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

//base64编码
+(NSString *)base64EncodeString:(NSString *)string
{
    //1.先把字符串转换为二进制数据
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //2.对二进制数据进行base64编码，返回编码后的字符串
    //这是苹果已经给我们提供的方法
    return [data base64EncodedStringWithOptions:0];
}


+(void)DownLoadFileFromHttp:(NSString *)url SavePath:(NSString *)savePath Down:(DownLoadFileBlock)down progress:(ProgressHandle)progress
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"下载进度  %lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
            progress(downloadProgress);
   
    }  destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //destination 这个block需要返回一个NSURL  本地存储文件的地址url
        //下载地址 参数targetPath 缓存url
        NSLog(@"默认下载地址:%@",targetPath);
        
        //正常情况下 可需要把文件放到沙盒目录下
        //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
        // NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        
        NSString *path = savePath;
        
        //fileURLWithPath 拿到的是本地url路劲
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //下载完成的后调用
        NSLog(@"响应%@--地址%@",response,filePath);

            down(error);    
    }];
    
    
    [task resume];
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
        NSString *eightStr =@"提交错误";
        
        return eightStr;
    }
    
}

/**
 *  验证身份证号码是否正确的方法
 *
 *  @param IDNumber 传进身份证号码字符串
 *
 *  @return 返回YES或NO表示该身份证号码是否符合国家标准
 */
+ (BOOL)isCorrect:(NSString *_Nonnull)IDNumber
{
    NSMutableArray *IDArray = [NSMutableArray array];
    // 遍历身份证字符串,存入数组中
    for (int i = 0; i < 18; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [IDNumber substringWithRange:range];
        [IDArray addObject:subString];
    }
    // 系数数组
    NSArray *coefficientArray = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
    // 余数数组
    NSArray *remainderArray = [NSArray arrayWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", nil];
    // 每一位身份证号码和对应系数相乘之后相加所得的和
    int sum = 0;
    for (int i = 0; i < 17; i++) {
        int coefficient = [coefficientArray[i] intValue];
        int ID = [IDArray[i] intValue];
        sum += coefficient * ID;
    }
    // 这个和除以11的余数对应的数
    NSString *str = remainderArray[(sum % 11)];
    // 身份证号码最后一位
    NSString *string = [IDNumber substringFromIndex:17];
    // 如果这个数字和身份证最后一位相同,则符合国家标准,返回YES
    if ([str isEqualToString:string]) {
        return YES;
    } else {
        return NO;
    }
}

+(BOOL)isBlankString:(id)sting
{
    if (![sting isKindOfClass:[NSString class]]) {
        return YES;
    }else if (sting==nil)
    {
        return YES;
    }
    if ([sting isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([sting isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([sting isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([[sting stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}



@end
