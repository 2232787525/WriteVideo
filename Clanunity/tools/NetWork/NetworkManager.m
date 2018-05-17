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
 "d_brand" = iPhone;
 "d_code" = "BE6C2C31-6094-425F-AA62-FE627B958514";
 "d_model" = "iPhone 6";
 "d_platform" = "10.0.2";
 dpi = 375;
 iiod = 1;
 lati = "<null>";
 lon = "<null>";
 nc = wifi;
 resolution = "1334*750";
 "v_code" = "1.0";
 "v_name" = common;
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
//设备信息 公共参数
#import "PLDeviceIdentifier.h"

#import "AFSecurityPolicy.h"

#import "PLHttpTool.h"
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
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];//2
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
        self.requestSerializer.timeoutInterval =60.0f;
    }
    return self;
    

}

-(void)registerSerializerUserAgent{
    //APP name
    NSString *AppName =[PLDeviceIdentifier AppstrAppName];
    //App 版本
    NSString *AppV =[PLDeviceIdentifier AppstrAppVersion];
    //设备 版本
    NSString *SysVersion =[PLDeviceIdentifier DevicestrSysVersion];
    //设备 型号
    NSString *phoneModel =[PLDeviceIdentifier DevicephoneModel];
    NSString *UserAgnet =[NSString stringWithFormat:@"%@ %@ (ios/%@ %@)",AppName,AppV,SysVersion,phoneModel];
    [self.requestSerializer setValue:UserAgnet forHTTPHeaderField:@"User-Agent"];
}

-(void)POST_NetworkParameter:(NetworkParameter *)model url:(NSString *)url successBlock:(SuccessHandleBlock)successBlock failureBlock:(FailureHandleBlock)failureBlock{
    [self registerSerializerUserAgent];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",Url_header,url];
    [self POST:urlString parameters:[self configureParameterWithNetworkParameter:model] progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            id status =responseObject[@"status"];
            if ([status isKindOfClass:[NSNull class]]) {
                //没什么事
            }
            if ([status isKindOfClass:[NSString class]]) {
                if ([responseObject[@"status"] isEqualToString:@"108"]) {
                    
                    //已经被登录了
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您的账号在其他设备已登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alertView show];
                    [LOGIN_USER loginOutClearDataWithRequestBlock:^(BOOL success) {
                    }];
                    
                    
                }
            }
        }
        successBlock(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(task,error);
    }];

}
-(void)dispatch_mainQuine:(DispathMainHandleBlock)mainBlock{
    dispatch_async(dispatch_get_main_queue(), ^{
        mainBlock(nil);
    });
}
-(void)GET_NetworkParameter:(NetworkParameter *)model url:(NSString *)url successBlock:(SuccessHandleBlock)successBlock failureBlock:(FailureHandleBlock)failureBlock{
    [self registerSerializerUserAgent];
    NSString *par = [self configureGETParameterWithNetworkParameter:model];
    NSString *urlString = [NSString stringWithFormat:@"%@%@?%@",Url_header,url,par];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (model.asd.length>0) {
        [self judgeLoginStatusWithAsd:model.asd successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                if ([responseObject[@"status"] isEqualToString:@"108"]) {
                    
                    //已经被登录了
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您的账号在其他设备已登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alertView show];
                    [LOGIN_USER loginOutClearDataWithRequestBlock:^(BOOL success) {
                    }];
                    successBlock(task,responseObject);
                }
                else{
                    [NetService GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        successBlock(task,responseObject);
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        failureBlock(task,error);
                    }];
                }
            }
        } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failureBlock(task,error);
        }];
    }else{
        [NetService GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successBlock(task,responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failureBlock(task,error);
        }];
    }
}
-(void)POST_UpdateFilesNetworkParameter:(NetworkParameter*)model url:(NSString*)url withFileParameter:(NSDictionary*)fileParDic successBlock:(SuccessHandleBlock _Nonnull)successBlock failureBlock:(FailureHandleBlock _Nonnull)failureBlock{
    [self registerSerializerUserAgent];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",Url_header,url];
    
    [self POST:urlString parameters:[self configureParameterWithNetworkParameter:model] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSString *string in fileParDic.allKeys) {
            NSArray *value = fileParDic[string];
            if ([string isEqualToString:@"logo"]) {
                [formData appendPartWithFileData:value.firstObject name:string fileName:[NSString stringWithFormat:@"%@.jpg",string] mimeType:@"image/jpeg"];
            }
            if ([string isEqualToString:@"headimg"]) {
                [formData appendPartWithFileData:value.firstObject name:string fileName:[NSString stringWithFormat:@"%@.jpg",string] mimeType:@"image/jpeg"];
            }
            if ([string isEqualToString:@"bgimg"]) {
                [formData appendPartWithFileData:value.firstObject name:string fileName:[NSString stringWithFormat:@"%@.jpg",string] mimeType:@"image/jpeg"];
            }
            if ([string isEqualToString:@"idfrontimg"]) {
                [formData appendPartWithFileData:value.firstObject name:string fileName:[NSString stringWithFormat:@"%@.jpg",string] mimeType:@"image/jpeg"];
            }
            if ([string isEqualToString:@"idbackimg"]) {
                [formData appendPartWithFileData:value.firstObject name:string fileName:[NSString stringWithFormat:@"%@.jpg",string] mimeType:@"image/jpeg"];
            }
            if ([string isEqualToString:@"idcard"]) {
                [formData appendPartWithFileData:value.firstObject name:string fileName:[NSString stringWithFormat:@"%@.jpg",string] mimeType:@"image/jpeg"];
            }
            
            if ([string isEqualToString:@"imgfile"]) {
                [formData appendPartWithFileData:value.firstObject name:string fileName:[NSString stringWithFormat:@"%@.jpg",string] mimeType:@"image/jpeg"];

            }
            if ([string isEqualToString:@"imgfiles"]) {
                for (NSInteger i = 0; i < value.count; i++) {
                    [formData appendPartWithFileData:value[i] name:string fileName:[NSString stringWithFormat:@"%@%ld.jpg",string,(long)i] mimeType:@"image/jpeg"];
                }
            }
            if ([string isEqualToString:@"amrfile"]) {
                [formData appendPartWithFileData:value.firstObject name:string fileName:@"voice.amr" mimeType:@"amr"];
            }
        
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id status =responseObject[@"status"];
        if ([status isKindOfClass:[NSNull class]]) {
            //没什么事，保证不蹦
        }
        if ([status isKindOfClass:[NSString class]]) {
            if ([responseObject[@"status"] isEqualToString:@"108"]) {
                //已经被登录了
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您的账号在其他设备已登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
                [LOGIN_USER loginOutClearDataWithRequestBlock:^(BOOL success) {
                }];
            }
        }
        successBlock(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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
    [parameters setObject:lati forKey:@"lati"];
    [parameters setObject:lon forKey:@"lon"];
    //此时把经纬度加上，公共参数配置完成，公共参数整体将作为cmpms的值
    //
    NSMutableDictionary *packagePar = [NSMutableDictionary dictionaryWithCapacity:0];
    [packagePar setValuesForKeysWithDictionary:model.parameter];
    //组合参数-把公共参数和个性参数组合到一起成为packagePar
    [packagePar setObject:parameters forKey:@"cmpms"];
    
    
    //组合参数字典转成json字符串
    NSString *packageJson = [packagePar JSONRepresentation];
    //转成的json再进行base64转码
    NSString *packageBase64 = [PLHttpTool base64EncodeString:packageJson];
    //再对base64字符串处理特殊字符串生成最后的zfy参数值
    NSString *zfyEcodeString = [PLHttpTool encodeToPercentEscapeString:packageBase64];
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
    NSString *resolution_Screenrl =[PLDeviceIdentifier DeviceScreenrl];
    //设备像素
    NSString *dpi_Screenpx =[PLDeviceIdentifier DeviceScreenpx];
    //设备品牌
    NSString *d_brand_deviceBrand =[PLDeviceIdentifier DeviceBrand];
    //设备编号
    NSString *d_code_deviceIdentifier =[PLDeviceIdentifier deviceIdentifier];
    //设备型号
    NSString *d_model_deviceModel =[PLDeviceIdentifier DevicephoneModel];
    //设备版本号平台及版本
    NSString *d_platform_deviceVersion =[PLDeviceIdentifier DevicestrSysVersion];
    //APP 版本号
    NSString *v_code_AppVersion =[PLDeviceIdentifier AppstrAppVersion];
    //版本类型
    NSString *v_name = @"common";
    
    if (d_code_deviceIdentifier.length <= 0 && [d_model_deviceModel isEqualToString:@"Simulator"]) {
        d_code_deviceIdentifier = @"BE17FAD0-10086-42F6-9A9F-1109A871F48A";
    }
    //网络状况
    NSString *nc_netStatus =[PLDeviceIdentifier networkingStatesFromStatebar];
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

-(void)AppSignPostforappsecret{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[user objectForKey:@"AppSignGood"]);
    if ([user objectForKey:@"AppSignGood"]) {
        return;
    }
    NetworkParameter *par = [[NetworkParameter alloc] init];
    [self POST_NetworkParameter:par url:@"/authsubmit/appsecret" successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:[NSNumber numberWithBool:YES] forKey:@"AppSignGood"];
    } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    

}


-(void)networkReachabilityStatus{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
       /*
        AFNetworkReachabilityStatusUnknown          = -1,
        AFNetworkReachabilityStatusNotReachable     = 0,
        AFNetworkReachabilityStatusReachableViaWWAN = 1,
        AFNetworkReachabilityStatusReachableViaWiFi = 2,
        */
        
        NSLog(@"%ld",(long)status);
  
    }];
}

-(void)judgeLoginStatusWithAsd:(NSString*)asd successBlock:(SuccessHandleBlock _Nonnull)successBlock
                  failureBlock:(FailureHandleBlock _Nonnull)failureBlock{
    NetworkParameter *parModel = [[NetworkParameter alloc] init];
    parModel.parameter = @{@"asd":asd};
    
    [self registerSerializerUserAgent];
    NSString *par = [self configureGETParameterWithNetworkParameter:parModel];
    NSString *urlString = [NSString stringWithFormat:@"%@%@?%@",Url_header,@"/login/islogin",par];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [NetService GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(task,error);
    }];
}


@end


@implementation NetworkParameter
@end

