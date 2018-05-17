//
//  NetworkManager.m
//  PlamLive
//
//  Created by wangyadong on 2016/12/6.
//  Copyright © 2016年 wangyadong. All rights reserved.

/*掌方圆post请求相关说明
 普通post请求最终传个服务器的参数结构是
 @{@"ts" :  @"13位的时间戳",
 @"zfy":  @"业务参数（json格式）base64加密"};
 
 关键操作的post请求最终传给服务器的参数结构是
 @{@"ts" :  @"13位的时间戳",
 @"zfy":  @"业务参数（json格式）base64加密",
 @"appkey": @"秘钥",
 @"appsign":@"加密后的签名"
 }
 其中@"zfy":@"业务参数（json格式）base64加密"
 zfy的参数是 参数字典变成json
 */

/*
 //公共参数
 NSDictionary *commonPar = @{
                            @"d_brand":@"Iphone6",
                            @"d_platform":@"iOS10.0",
                            @"iiod":@"1"
                            };
 
 //公共参数
 {
 "d_brand" = iPhone;//设备品牌
 "d_code" = "BE6C2C31-6094-425F-AA62-FE627B958514";//设备编号
 "d_model" = "iPhone 6";//设备型号
 "d_platform" = "10.0.2";//系统编号
 dpi = 375;//像素
 iiod = 1;//系统 0-安卓,1-苹果
 lati = "<null>";//经纬度
 lon = "<null>";//经纬度
 nc = wifi; //当前网络
 resolution = "1334*750";//设备分辨率
 "v_code" = "1.0";//APP 版本号
 "v_name" = common;//名字
 }
 
 
 //个性参数
 NSDictionary *specialPar = @{
                            @"个性参数1":@"nameString",
                            @"个性参数2":@"123456"
 };
 
 //把公共参数整体 作为 参数“cmpms”的value值添加到个性参数里面
 NSDictionary *parmDic = @{ @"cmpms":commonPar,
                            @"个性参数1":@"nameString",
                            @"个性参数2":@"123456"
 };
 
 NSString *parJsonString = @"parmDic 参数字典转成json字符串";
 NSString *parBase64String = @"parJsonString base64编码后的字符串";
 NSString *zfyEcodeString = @"parBase64String特殊字符编码转码后的就是zfy参数的值";
 NSDictionary *resultParm = @{@"zfy":zfyEcodeString,
 @"ts":@"13位的时间戳"
 };
 //如果是关键操作就把appkey和appsign 加上
 NSDictionary *importResultParm = @{@"zfy":zfyEcodeString,
 @"ts":@"13位的时间戳",
 @"appkey":@"服务器返回的appkey",
 @"appsign":@"一定规则生成的签名"
 };
 */

#import "NetworkManager.h"
#import "DeviceIdentifier.h"//设备信息 公共参数
#import "AFSecurityPolicy.h"

static NetworkManager * network;

@implementation NetworkManager

+(instancetype _Nonnull)shareNetworkManager{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        network = [[NetworkManager alloc] init];
    });
    return network;
}


-(instancetype)init{
    self = [super init];
    if (self) {

        NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];
        NSData * certData =[NSData dataWithContentsOfFile:cerPath];
        NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:2];//2,AFSSLPinningModeCertificate
        // 是否允许,NO-- 不允许无效的证书
        [securityPolicy setAllowInvalidCertificates:YES];
        // 设置证书
        [securityPolicy setPinnedCertificates:certSet];
        self.securityPolicy = securityPolicy;
        
        //请求格式
        [self.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        [self.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        [self.requestSerializer setValue:@"Keep-Alive" forHTTPHeaderField:@"Connection"];
        //设置解析器responseSerializer
        /*
         AFHTTPResponseSerializer //数据流NSData
         AFJSONResponseSerializer //json数据 默认是json
         AFXMLParserResponseSerializer //xml数据
         */
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        //可接受的数据类型
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",nil];
        //超时
        self.requestSerializer.timeoutInterval = 18.0f;
    }
    return self;
    

}

+(void)registerSerializerUserAgent{
    //APP name
    NSString *AppName =[DeviceIdentifier AppstrAppName];
    //App 版本
    NSString *AppV =[DeviceIdentifier AppstrAppVersion];
    //设备 版本
    NSString *SysVersion =[DeviceIdentifier DevicestrSysVersion];
    //设备 型号
    NSString *phoneModel =[DeviceIdentifier DevicephoneModel];
    NSString *UserAgnet =[NSString stringWithFormat:@"%@ %@ (ios/%@ %@)",AppName,AppV,SysVersion,phoneModel];
    //[self.requestSerializer setValue:UserAgnet forHTTPHeaderField:@"User-Agent"];
}

+(void)POST_NetworkParameter:(NetworkParameter *)model url:(NSString *)url successBlock:(SuccessHandleBlock)successBlock failureBlock:(FailureHandleBlock)failureBlock{
    
    RequestParamater *parModel = [[RequestParamater alloc] init];
    parModel.parameter = model.parameter;
    parModel.asd = model.asd;
    parModel.ts = model.ts;
    parModel.appsign = model.appsign;
    parModel.appkey = model.appkey;
    parModel.lat = model.lat;
    parModel.lon = model.lon;
    parModel.devicetoken = model.devicetoken;
    [ToolService POST_requestWithParamodel:parModel url:url success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseAny) {
        successBlock(task,responseAny);
    } faile:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(task,error);
    }];
}
+(void)dispatch_mainQuine:(DispathMainHandleBlock)mainBlock{
    dispatch_async(dispatch_get_main_queue(), ^{
        mainBlock(nil);
    });
}
+(void)GET_NetworkParameter:(NetworkParameter *)model url:(NSString *)url successBlock:(SuccessHandleBlock)successBlock failureBlock:(FailureHandleBlock)failureBlock{
    
    RequestParamater *parModel = [[RequestParamater alloc] init];
    parModel.parameter = model.parameter;
    parModel.asd = model.asd;
    parModel.appkey = model.appkey;
    parModel.appsign = model.appsign;
    parModel.lon = model.lon;
    parModel.ts = model.ts;
    parModel.lat = model.lat;
    parModel.devicetoken = model.devicetoken;
   [ToolService GET_requestWithParamodel:parModel url:url success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseAny) {
       successBlock(task,responseAny);
   } faile:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       failureBlock(task,error);
   }];
    
}
+(void)POST_UpdateFilesNetworkParameter:(NetworkParameter*)model url:(NSString*)url withFileParameter:(NSDictionary*)fileParDic successBlock:(SuccessHandleBlock _Nonnull)successBlock failureBlock:(FailureHandleBlock _Nonnull)failureBlock{
    
    RequestParamater *parModel = [[RequestParamater alloc] init];
    parModel.parameter = model.parameter;
    parModel.asd = model.asd;
    parModel.appsign = model.appsign;
    parModel.appkey = model.appkey;
    parModel.lat = model.lat;
    parModel.lon = model.lon;
    parModel.ts = model.ts;
    parModel.devicetoken = model.devicetoken;
   
    [ToolService POST_UpdateFiles_requestWithParamodel:parModel url:url filePardic:fileParDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseAny) {
        successBlock(task,responseAny);
    } faile:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(task,error);
    }];
    
}

-(nonnull NSDictionary *)configureParameterWithNetworkParameter:(NetworkParameter * _Nullable)model{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:0];
    [parameters setValuesForKeysWithDictionary:[self CommonParameters]];
    id lati;
    id lon;
    if (model.lat.length > 0) {
        lati = model.lat;
    }else{
        lati = [NSNull null];
    }
    
    if (model.lon.length > 0) {
        lon = model.lon;
    }else{
        lon = [NSNull null];
    }
    if (model.devicetoken.length>0) {
        [parameters setObject:model.devicetoken forKey:@"devicetoken"];
    }
    [parameters setObject:lati forKey:@"lati"];
    [parameters setObject:lon forKey:@"lon"];
    //此时把经纬度加上，公共参数配置完成，公共参数整体将作为cmpms的值
    //
    NSMutableDictionary *packagePar = [NSMutableDictionary dictionaryWithCapacity:0];
    [packagePar setValuesForKeysWithDictionary:model.parameter];
    
    if (packagePar[@"asd"] == nil&&model.asd.length>0) {
        [packagePar setObject:model.asd forKey:@"asd"];
    }
    //组合参数-把公共参数和个性参数组合到一起成为packagePar
    [packagePar setObject:parameters forKey:@"cmpms"];
    
    
    //组合参数字典转成json字符串
    NSString *packageJson = [packagePar JSONRepresentation];
    //转成的json再进行base64转码
    
    //1.先把字符串转换为二进制数据
    NSData *data = [packageJson dataUsingEncoding:NSUTF8StringEncoding];
    //2.对二进制数据进行base64编码，返回编码后的字符串
    //这是苹果已经给我们提供的方法
    NSString *packageBase64 =[data base64EncodedStringWithOptions:0];
    //再对base64字符串处理特殊字符串生成最后的zfy参数值
    NSString *zfyEcodeString = [PLHelp encodeToPercentEscapeString:packageBase64];
    //时间戳
    NSString *ts = [PLHelp timestamp];
    if (model.ts.length>0) {
        ts = model.ts;
    }
    NSDictionary *resultParm = @{@"zfy":zfyEcodeString,@"ts":ts};

    if (model.appkey.length > 0 && model.appsign.length > 0) {
         resultParm = @{@"zfy":zfyEcodeString,@"ts":ts,@"appsign":model.appsign,@"appkey":model.appkey};
    }
    return resultParm;
}

-(nonnull NSString *)configureGETParameterWithNetworkParameter:( NetworkParameter * _Nullable)model{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:0];
    [parameters setValuesForKeysWithDictionary:[self CommonParameters]];
    id lati;
    id lon;
    if (model.lat.length > 0) {
        lati = model.lat;
        [parameters setObject:lati forKey:@"lati"];
    }
    if (model.lon.length > 0) {
        lon = model.lon;
        [parameters setObject:lon forKey:@"lon"];
    }
    NSMutableString *urlParString = [NSMutableString stringWithCapacity:0];
    
    NSArray *keyArray =model.parameter.allKeys;
    for (NSInteger i = 0; i < keyArray.count; i++) {
        NSString *keyString = keyArray[i];
        if ([keyString isEqualToString:@"asd"] && model.asd.length>0) {
        }else{
            NSString *value = model.parameter[keyString];
            NSString *keyValueString = [NSString stringWithFormat:@"%@=%@",keyString,value];
            [urlParString appendString:keyValueString];
            [urlParString appendString:@"&"];
        }
    }
    
    if (model.asd.length>0) {
        NSString *value = model.asd;
        NSString *keyValueString = [NSString stringWithFormat:@"%@=%@",@"asd",value];
        [urlParString appendString:keyValueString];
        [urlParString appendString:@"&"];
    }
    
    for (NSInteger i = 0; i < parameters.allKeys.count; i++) {
        NSString *key = parameters.allKeys[i];
        NSString *value = parameters[key];
        if (i != 0) {
            [urlParString appendString:@"&"];
        }
        NSString *keyValueStrng = [NSString stringWithFormat:@"%@=%@",key,value];
        [urlParString appendString:keyValueStrng];
    }
    return urlParString;
}


-(NSDictionary*)CommonParameters{

    //设备分辨率
    NSString *resolution_Screenrl =[DeviceIdentifier DeviceScreenrl];
    //设备像素
    NSString *dpi_Screenpx =[DeviceIdentifier DeviceScreenpx];
    //设备品牌
    NSString *d_brand_deviceBrand =[DeviceIdentifier DeviceBrand];
    //设备编号
    NSString *d_code_deviceIdentifier =[DeviceIdentifier deviceIdentifier];
    //设备型号
    NSString *d_model_deviceModel =[DeviceIdentifier DevicephoneModel];
    //设备版本号平台及版本
    NSString *d_platform_deviceVersion =[DeviceIdentifier DevicestrSysVersion];
    //APP 版本号
    NSString *v_code_AppVersion =[DeviceIdentifier AppstrAppVersion];
    //版本类型
    NSString *v_name = @"common";
  
    if (d_code_deviceIdentifier.length <= 0 && [d_model_deviceModel isEqualToString:@"Simulator"]) {
        d_code_deviceIdentifier = @"BE17FAD0-10086-42F6-9A9F-1109A871F48A";
    }
    //网络状况
    NSString *nc_netStatus =[DeviceIdentifier networkingStatesFromStatebar];
    NSDictionary *cmpmsDic =@{@"iiod":@"1",//客户端类型0-安卓1-苹果
                              @"d_brand":d_brand_deviceBrand,
                              @"d_platform":d_platform_deviceVersion,
                              @"d_model":d_model_deviceModel,
                              @"d_code":d_code_deviceIdentifier,
                              @"dpi":dpi_Screenpx,
                              @"resolution":resolution_Screenrl,
                              @"v_code":v_code_AppVersion,
                              @"v_name":v_name,
                              @"nc":nc_netStatus,
                              };
    //可变字典  接受公共参数 + 一般参数
    return cmpmsDic;
}
+(void)AppSignPostforappsecretFresh:(BOOL)fresh{
    if (fresh) {
        //需要刷新，置NO
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:[NSNumber numberWithInt:0] forKey:@"AppSignGood"];
    }else{
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        id code = [user objectForKey:@"AppSignGood"];
        if (code != nil && [code intValue] != 0) {
            if ([BaseURLHeader BuildType] == BuildCodeRelease) {
                if ([code intValue] == 1) {
                    //外网+code=1
                    return;
                }
            }else{
                if ([code intValue] == 2) {
                    //内网+code=2
                    return;
                }
            }
        }
    }
    
    [ToolService POST_requestWithParamodel:nil url:@"/ysjapp/v0909/authsubmit/appsecret" success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseAny) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        if ([BaseURLHeader BuildType] == BuildCodeRelease) {
            [userDefault setObject:[NSNumber numberWithInt:1] forKey:@"AppSignGood"];
        }else{
            [userDefault setObject:[NSNumber numberWithInt:2] forKey:@"AppSignGood"];
        }
    } faile:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

+(void)networkReachabilityStatus{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    }];
}

+(void)judgeLoginStatusWithAsd:(NSString*)asd successBlock:(SuccessHandleBlock _Nonnull)successBlock
                  failureBlock:(FailureHandleBlock _Nonnull)failureBlock{
    
    [ToolService GET_requestLoginStatusWithAsd:asd success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseAny) {
        successBlock(task,responseAny);

    } faile:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(task,error);
    }];
}


@end


@implementation NetworkParameter

+(NetworkParameter *_Nonnull)networkParameter{
    return [[NetworkParameter alloc] init];
}

@end

