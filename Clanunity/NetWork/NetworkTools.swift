//
//  NetworkTools.swift
//  Clanunity
//
//  Created by wangyadong on 2017/9/28.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

import UIKit
import AFNetworking

//在swift定义typealias闭包跟oc中的typedef block
//OC中不识别swift中typealias定义的闭包
/*typealias是用来为已经存在的类型重新定义名字的,通过命名,可以使代码变得更加清晰.使用的语法也很简单,使用 typealias 关键字像普通的赋值语句一样,可以将某个在已经存在的类型赋值为新的名字
 
//typealias SuccessHandle = ( ( (_ task : URLSessionDataTask? , _ responseAny : Dictionary<String,Any?>?) -> Void )?)
//typealias FailureHandle = ( ( (_ task : URLSessionDataTask? , _ error : Error) -> Void )?)
// typealias ProgressHandle = ( ( (_ downloadProgress : Progress?) -> Void )?)
// typealias DispathMainHandle = ( ( (_ sender : Any) -> Void )?)
*/

class NetworkTools: AFHTTPSessionManager {
    
    // MARK: - 单例初始化
    /// 单例初始化
    static let shareInstance : NetworkTools = {
        let tools = NetworkTools()
        let cerPath = Bundle.main.path(forResource: "server", ofType: "cer")
        var cerData : NSData?
        if cerPath != nil{
            cerData = NSData.init(contentsOfFile: cerPath!)
        }
        var cerSet : NSSet?
        if cerData != nil{
            cerSet = NSSet.init(objects: cerData ?? NSData())
        }
        let securityPolicy = AFSecurityPolicy.init(pinningMode: AFSSLPinningMode.certificate)
        securityPolicy.allowInvalidCertificates = true
        if cerSet != nil{
            securityPolicy.pinnedCertificates = cerSet as? Set<Data>
        }
        tools.securityPolicy = securityPolicy
        
        tools.requestSerializer.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        tools.requestSerializer.setValue("gzip", forHTTPHeaderField: "Accept-Encoding")
        tools.requestSerializer.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
        
        var appName = ""
        if Bundle.main.infoDictionary?["CFBundleDisplayName"] != nil{
            appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as! String
        }else{
            if DeviceIdentifier.appstrAppName() != nil{
               appName = DeviceIdentifier.appstrAppName()
            }
        }
        
        var appVerson = ""
        if Bundle.main.infoDictionary?["CFBundleShortVersionString"] != nil{
            appVerson = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        }
        let sysVerson = UIDevice.current.systemVersion
        var phoneModel = ""
        if IPhoneDevice()?.rawValue != nil {
            phoneModel = (IPhoneDevice()?.rawValue)!
        }
        
        let userAgent = appName + " " + appVerson + " " + "(ios/" + sysVerson + " " + phoneModel + ")"
        
        tools.requestSerializer.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        
        tools.requestSerializer.timeoutInterval = 8.0
        tools.responseSerializer = AFJSONResponseSerializer.init(readingOptions: JSONSerialization.ReadingOptions.init(rawValue: 0))
        tools.responseSerializer.acceptableContentTypes = NSSet.init(objects: "text/html","application/json","text/json","text/javascript") as? Set<String>
        return tools
    }()

    // MARK: - POST 请求
    /// post请求
    ///
    /// - Parameters:
    ///   - paramodel: 参数model
    ///   - url: url
    ///   - success: 成功回调
    ///   - faile: 失败回调
    public func POST_request(paramodel:RequestParamater?,url:String?,success:@escaping SuccessfulHandle,faile:@escaping FailedHandle ) -> Void{
        var urlString = BaseURL() 
        if url != nil {
            urlString = urlString + url!
        }
        self.post(urlString, parameters: self.configurePOSTParameter(model: paramodel), progress: { (uploadProfress : Progress) in
        }, success: { (task : URLSessionDataTask, responseAny : Any?) in
            
            if (responseAny is [String : Any]){
                let resDic = responseAny as! [String : Any]
                let status = self.responseStatus(status: resDic["status"])
                if status != nil && status == "108" {//登录失效
                    if helpLoginAsd() != nil{
                        let alertView = UIAlertView.init(title: "温馨提示", message: "您的账号在其他设备已登录", delegate: nil, cancelButtonTitle: "知道了")
                        alertView.show();
                        let loginManager = LoginUserManager.loginShare()
                        loginManager.loginOutClearData(request: { (success:Bool) in
                            //确定东西
                        })
                    }
                }
            }
            success(task,responseAny)
        }) { (task : URLSessionDataTask?, error : Error) in
         faile(task,error)
        }
    }
    
    
    public func POST_NetRequest(paramodel:RequestParamater?, url:String?,success:@escaping SuccessfulHandle,faile:@escaping FailedHandle ) -> Void{
        
        
    }
    
    
    
    
    // MARK: - POST 上传图片，文件 请求
    /// post请求
    ///
    /// - Parameters:
    ///   - paramodel: 参数model
    ///   - url: url
    ///   - success: 成功回调
    ///   - faile: 失败回调
    public func POST_UpdateFiles_request(paramodel:RequestParamater?,url:String?,filePardic:Dictionary<String,Array<NSData>> ,success:@escaping SuccessfulHandle,faile:@escaping FailedHandle) ->Void{
        
        var urlString = BaseURL()
        if url != nil {
            urlString = urlString + url!
        }
        
        self.post(urlString, parameters: self.configurePOSTParameter(model: paramodel), constructingBodyWith: { (formData:AFMultipartFormData) in
            for item in filePardic{

                //logo，头像，背景图，身份证，身份证背面，
                if (item.key == "logo") || (item.key == "headimg") || (item.key == "bgimg") || (item.key == "idfrontimg") || (item.key == "imgfile") || (item.key == "license") || (item.key == "idbackimg") || (item.key == "idcard") {
                    if item.value.first != nil{
                        formData.appendPart(withFileData: item.value.first! as Data, name: item.key, fileName: (item.key+".jpg"), mimeType: "image/jpeg")
                    }
                }
                    //图片数组
                else if (item.key == "imgfiles") && (item.value.count > 0){
                    
                    for (index,temp) in item.value.enumerated(){
                        formData.appendPart(withFileData: temp as Data, name: item.key, fileName: (item.key+String(index)+".jpg"), mimeType: "image/jpeg")
                    }
                }
                    //语音文件
                else if item.key == "amrfile" && item.value.first != nil{
                    formData.appendPart(withFileData: item.value.first! as Data, name: item.key, fileName: "voice.amr", mimeType: "amr")
                }
                    //视频文件
                else if item.key == "videofile" && item.value.first != nil{
                    formData.appendPart(withFileData: item.value.first! as Data, name: item.key, fileName: item.key+".MP4", mimeType: "video/quicktime")
                }
   
            }
        }, progress: { (uploadProgress:Progress) in
        }, success: { (task : URLSessionDataTask, responseAny : Any?) in
            
            if (responseAny is [String : Any]){
                let resDic = responseAny as! [String : Any]
                let status = self.responseStatus(status: resDic["status"])
                if status != nil && status == "108"{
                    if helpLoginAsd() != nil{
                        let alertView = UIAlertView.init(title: "温馨提示", message: "您的账号在其他设备已登录", delegate: nil, cancelButtonTitle: "知道了")
                        alertView.show();
                        let loginManager = LoginUserManager.loginShare()
                        loginManager.loginOutClearData(request: { (success:Bool) in
                            //确定东西
                        })
                    }
                }
            }
            success(task,responseAny)
        }) { (task : URLSessionDataTask?, error : Error) in
            faile(task,error)
        }
    
    }
    
    // MARK: - GET 请求
    /// get请求
    ///
    /// - Parameters:
    ///   - paramodel: 请求model
    ///   - url: url
    ///   - success: 成功回调
    ///   - faile: 失败回调
    public func GET_request(paramodel:RequestParamater?,url:String?,success:@escaping SuccessfulHandle,faile:@escaping FailedHandle) -> Void{
        
        var urlString = BaseURL()
        if url != nil {
            urlString = urlString + url!
        }
        urlString = urlString + "?" + self.configureGETParameter(model: paramodel)
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        if paramodel?.asd != nil {
            self.GET_requestLoginStatus(asd: paramodel?.asd, success: { (task : URLSessionDataTask, responseAny : Any?) in
                
                var loginOut = false
                if responseAny is [String:Any]{
                    let resDic = responseAny as! [String:Any]
                    let status = self.responseStatus(status: resDic["status"])
                    if status != nil && status == "108" {//登录失效
                        loginOut = true
                        if helpLoginAsd() != nil{
                            let alertView = UIAlertView.init(title: "温馨提示", message: "您的账号在其他设备已登录", delegate: nil, cancelButtonTitle: "知道了")
                            alertView.show();
                            let loginManager = LoginUserManager.loginShare()
                            loginManager.loginOutClearData(request: { (success:Bool) in
                                //确定东西
                            })
                        }
                        success(task,responseAny)
                    }
                }
                if loginOut == false {
                    self.get(urlString, parameters: nil, progress: { (downloadProgress:Progress) in
                    }, success: { (task : URLSessionDataTask, responseAny : Any?) in
                        success(task,responseAny)
                    }) { (task : URLSessionDataTask?, error : Error) in
                        faile(task,error)
                    }
                }
            }, faile: { (task : URLSessionDataTask?, error : Error) in
                faile(task,error)
            })
            
        }else{
            
            self.get(urlString, parameters: nil, progress: { (downloadProgress:Progress) in
            }, success: { (task : URLSessionDataTask, responseAny : Any?) in
                success(task,responseAny)
            }) { (task : URLSessionDataTask?, error : Error) in
                faile(task,error)
            }
        }
  
    }
    
    private func responseStatus(status:Any?) -> String?{
        if status != nil{
            if status is NSNumber {
                let statusNum = status as! NSNumber
                return String(describing: statusNum)
            }else if status is String {
                let statusStr = status as! String
                return statusStr
            }else{
                return "\(status!)"
            }
        }
        return nil
    }
    
    
    // MARK: - 判断asd是否失效
    /// 判断asd是否失效，判断登录状态
    ///
    /// - Parameters:
    ///   - asd: asd
    ///   - success: 成功
    ///   - faile: 失败
    public func GET_requestLoginStatus(asd:String? , success:@escaping SuccessfulHandle,faile:@escaping FailedHandle) -> Void{
    
        let par = RequestParamater.init()
        par.asd = asd
        var urlString = self.configureGETParameter(model: par)
        urlString = BaseURL() + Link_login_islogin + "?" + urlString
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        NetworkTools.shareInstance.get(urlString, parameters: nil, progress: { (downloadProgress:Progress) in
        }, success: { (task : URLSessionDataTask, responseAny : Any?) in
            success(task,responseAny)
            
        }) { (task : URLSessionDataTask?, error : Error) in
            faile(task,error)
        }
    }
    

    // MARK: - 配置post参数
    private func configurePOSTParameter(model:RequestParamater?) -> Dictionary<String,Any>{
        var parameters = Dictionary<String,Any>()
        parameters = self.configureCommonParamaters()
        if model?.lat != nil {
            parameters["lati"] = model?.lat
        }
        if model?.lon != nil {
            parameters["lon"] = model?.lon
        }
        if model?.devicetoken != nil {
            parameters["devicetoken"] = model?.devicetoken
        }
        
        var packagePar = Dictionary<String,Any>()
        
        if model?.parameter != nil {
            packagePar = (model?.parameter)!
        }
        
        if packagePar["asd"] == nil && model?.asd != nil {
            packagePar["asd"] = model?.asd
        }
        
        packagePar["cmpms"] = parameters
        var packageJson = ""
        if JSONSerialization.isValidJSONObject(packagePar) == true{
            let jsonData : NSData! = try? JSONSerialization.data(withJSONObject: packagePar, options: []) as NSData!
            packageJson =  String.init(data: jsonData as Data, encoding: .utf8)!
        }else{
            print("无法解析")
        }
        let data = packageJson.data(using: .utf8)
        let packageBase64 = data?.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 0))
        let zfyEcodeString = PLHelp.encode(toPercentEscape: packageBase64)!
        var ts = PLHelp.timestamp()!
        if model?.ts != nil {
            ts = (model?.ts)!
        }
        var resultParm = Dictionary<String,Any>()
        resultParm = ["zfy" : zfyEcodeString,"ts" : ts]
        if model?.appkey != nil && model?.appsign != nil {
            resultParm = ["zfy" : zfyEcodeString ,"ts" : ts,"appsign" : model?.appsign ?? String(),"appkey" : model?.appkey ?? String()]
        }
        return resultParm
    }
    // MARK: - 配置get参数
    private func configureGETParameter(model:RequestParamater?) -> String{
        
        var parameters = Dictionary<String,Any>()
        parameters = self.configureCommonParamaters()
        if model?.lat != nil {
            parameters["lati"] = model?.lat
        }
        if model?.lon != nil {
            parameters["lon"] = model?.lon
        }
        if model?.devicetoken != nil {
            parameters["devicetoken"] = model?.devicetoken
        }
        
        var urlParString = String()
        
        //解析 常规参数
        if model?.parameter != nil {
            let modelPar = (model?.parameter)!

            for item in modelPar {
                
                if item.key == "asd" && model?.asd != nil {
                }else{
                    urlParString = urlParString + "\(item.key)=\(item.value)" + "&"
                }
            }
            
        }
        
        if model?.asd != nil {
            urlParString = urlParString + "asd" + "=" + (model?.asd)! + "&"
        }
        
        //解析 公共参数
        for item in parameters{
            urlParString = urlParString + "\(item.key)=\(item.value)" + "&"
        }
        
        if urlParString[urlParString.index(before: urlParString.endIndex)] == "&" {
            urlParString.remove(at: urlParString.index(before: urlParString.endIndex))
        }
        
        return urlParString
    }
    // MARK: - 配置公共参数
    private func configureCommonParamaters() -> Dictionary<String,Any>{
        
        //分辨率 = 屏幕宽 x 屏幕高
        let resolution_Screenrl = String.init(format: "%g*%g",UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height)
        
        //像素 = (屏幕宽*2) x (屏幕高*2)
        let dpi_Screenpx = String.init(format: "%g*%g",UIScreen.main.bounds.size.width*2.0,UIScreen.main.bounds.size.height*2.0)
        //设备品牌
        let d_brand_deviceBrand = UIDevice.current.model
        //设备编号
        var d_code_deviceIdentifier = DeviceIdentifier.deviceIdentifier()
        //设备型号
        let d_model_deviceModel = IPhoneDevice()?.rawValue
        
        //设备版本号平台及版本
        let d_platform_deviceVersion = UIDevice.current.systemVersion
        //APP 版本号
        var v_code_AppVersion = ""
        if Bundle.main.infoDictionary?["CFBundleShortVersionString"] != nil {
            v_code_AppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        }
        let v_name = "common"
        
        if d_code_deviceIdentifier == nil && d_model_deviceModel == "Simulator" {
            d_code_deviceIdentifier = "BE17FAD0-10086-42F6-9A9F-1109A871F48A"
        }
        //网络状况
        let nc_netStatus = DeviceIdentifier.networkingStatesFromStatebar()
        
        let cmpmsDic : Dictionary<String,Any> =  ["iiod" : 1,
                                                  "d_brand" : d_brand_deviceBrand,
                                                  "d_platform" : d_platform_deviceVersion,
                                                  "d_model" : d_model_deviceModel ?? String(),
                                                  "d_code" : d_code_deviceIdentifier ?? String(),
                                                  "dpi" : dpi_Screenpx,
                                                  "resolution" : resolution_Screenrl,
                                                  "v_code" : v_code_AppVersion,
                                                  "v_name" : v_name,
                                                  "nc" : nc_netStatus ?? String()]
        return cmpmsDic
    }
    
}




class RequestParamater: NSObject {
    
    ///允许的value类型是String,NSNumber，NSNull
    var parameter : Dictionary<String, Any>?
    var asd : String?
    var ts : String?
    var appkey : String?
    var appsign : String?
    var lon : String?
    var lat : String?
    var devicetoken : String?
    
}

