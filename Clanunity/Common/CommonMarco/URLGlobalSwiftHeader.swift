//
//  URLGlobalSwiftHeader.swift
//  Clanunity
//
//  Created by wangyadong on 2017/9/14.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

import Foundation

@objc enum BuildCode : Int8 {
    case Dev = 1//内网·
    case Release = 2//外网
    case Bug = 3//bug
}
let PLVersion : String = "v0909"

//编译环境
private let buildCode = BuildCode.Dev


func PLURL(V:Bool) -> String{
    var url = "";
    if buildCode == BuildCode.Dev {
        //内网
        url = "http://192.168.1.192:9997"

    }else if buildCode == BuildCode.Release{
        //外网测试
        url = "http://dlm.zhangfangyuan.com"
    }else if buildCode == BuildCode.Bug{
        //bug测试http://192.168.1.22:8080
//        url = "http://dlm.zhangfangyuan.com:8888"
        //bug测试
        url = "http://47.95.223.107"
    }
    return url;
//    if url.count == 0 || V == false {
//        return url;
//    }else{
//        return url + "\(PLVersion)";
//    }
}

func BaseURL() -> String{
    return PLHeader.plUrl(V: true);
}

func BaseURLH5() -> String{
    return BaseURLHeader.h5Header(V: true);
}

/// H5页面的连接头
///
/// - Returns: 字符串
func H5URL(V:Bool) -> String{
    var header = "";
    if buildCode == BuildCode.Dev {
        header = "http://192.168.1.192:9997/zfy-h5/"//内网原来8080
    }else if buildCode == BuildCode.Release{
        header = "http://dlm.zhangfangyuan.com/zfy-h5/"//外网
    }else if buildCode == BuildCode.Bug{
        header = "http://192.168.1.22/zfy-h5/"//bug测试
    }
    if V == false || header.count == 0 {
        return header;
    }else{
        return  header + "\(PLVersion)";
    }
}



/// 环信appkey
///
/// - Returns: key
func EaseMobAppKey() -> String{
    
    if buildCode == BuildCode.Dev {
        //内网
        return "1192170227115326#zhangfangyuan1"
    }else if buildCode == BuildCode.Release{
        //外网
        return "1192170227115326#zhangfangyuan"
    }else if buildCode == BuildCode.Bug{
        //bug测试
        return "1192170227115326#zhangfangyuan1"
    }
    return ""
}

@objc class PLHeader : NSObject{
    class func plUrl(V:Bool) -> String{
        return PLURL(V: V);
    }
    class func h5Url(V:Bool) -> String{
        return H5URL(V:V);
    }
    class func easeMobAppKey() -> String{
        return EaseMobAppKey()
    }
}


/// 这个类完全是为了OC中方便调用
@objc class BaseURLHeader : NSObject{
    class func baseUrl() -> String{
        return PLHeader.plUrl(V: true);
    }
    class func easeMobAppKey() -> String{
        return PLHeader.easeMobAppKey()
    }
    class func baseH5Url() -> String{
        return PLHeader.h5Url(V: true)
    }
    class func h5Header(V:Bool) -> String{
        return PLHeader.h5Url(V:V)
    }
    class func H5Version() -> String{
        return "version=\(PLVersion)"
    }
    class func Version() -> String{
        return PLVersion
    }
    class func BuildType() -> BuildCode{
        return buildCode
    }
}


let URL_socialgroupact_calsignup = "/ysjapp/v0909/socialgroupact/calsignup"

/// 判断是否登录
let Link_login_islogin = "/ysjapp/v0909/login/islogin"

/// 发布活动
let Link_socialgroupact_create = "/ysjapp/v0909/socialgroupact/create"

/// 社群活动列表
let Link_socialgroupact_groupactlist = "/ysjapp/v0909/socialgroupact/groupactlist"

/// 删除活动
let Link_socialgroupact_delete = "/ysjapp/v0909/socialgroupact/delete"

/// 餐厅详情
let Link_communityolddinner_detail = "/ysjapp/v0909/communityolddinner/detail"

/// 评论列表
let Link_zfy_news_commentlist = "/ysjapp/v0909/zfy/news/commentlist"

/// 发布评论
let Link_zfy_comment_submit = "/ysjapp/v0909/zfy/comment/submit"

/// 老年餐厅
let Link_communityolddinner_list = "/ysjapp/v0909/communityolddinner/list"

/// 删除评论
let Link_comment_delete = "/ysjapp/v0909/comment/delete"

/// 点赞接口(所有点赞通用)
let Link_praise_submit = "/ysjapp/v0909/praise/submit"

/// 官方活动
let Link_socialgroupact_acthomelist = "/ysjapp/v0909/socialgroupact/acthomelist"

/// 申请添加好友
let Link_friendsapplycommit_apply = "/ysjapp/v0909/friendsapplycommit/apply"

/// 社区公告详情
let Link_communitynotice_detail = "/ysjapp/v0909/communitynotice/detail"

/// 办事流程详情
let Link_communityworkflow_detail = "/ysjapp/v0909/communityworkflow/detail"

/// 类别
let Link_zfy_category_categorylist = "/ysjapp/v0909/zfy/category/categorylist"

/// 填写好友邀请码
let Link_invitation_commitsharecode = "/ysjapp/v0909/invitation/commitsharecode"

/// 获取个人掌币
let Link_common_getmybasedate = "/ysjapp/v0909/common/getmybasedate"

/// 获取社群资料详情（未加入社区）
let Link_socialgroup_detail = "/ysjapp/v0909/socialgroup/detail"

/// 加入社群
let Link_socialgroupapply_create = "/ysjapp/v0909/socialgroupapply/create"

/// 活动报名接口
let Link_socialgroupact_signup = "/ysjapp/v0909/socialgroupact/signup"
