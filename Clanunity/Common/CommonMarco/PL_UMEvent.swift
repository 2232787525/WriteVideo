//
//  PL_UMEvent.swift
//  Clanunity
//
//  Created by bex on 2017/12/2.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

import Foundation
//首页四个按钮点击事件
/// 社区小区
let UM_shouye_community = "shouye_community"
/// 官方活动
let UM_shouye_activity = "shouye_activity"
/// 签到日历
let UM_shouye_sign = "shouye_sign"
/// 商家优惠
let UM_shouye_business = "shouye_business"

//资讯列表点击
/// 热点
let UM_news_hot = "news_hot"
/// 健康
let UM_news_healthy = "news_healthy"
/// 搞笑
let UM_news_funny = "news_funny"
/// 爆料
let UM_news_baoliao = "news_baoliao"

//签到事件
/// 商家优惠
let UM_sign = "sign"

//分享按钮点击（新闻资讯分享）
/// 资讯分享QQ
let UM_share_QQ = "share_QQ"
/// 资讯分享QQ空间
let UM_share_QQspace = "share_QQspace"
/// 资讯分享微信
let UM_share_wechat = "share_wechat"
/// 资讯分享微信朋友圈
let UM_share_wechatCircle = "share_wechatCircle"

//16个活动列表点击事件
/// 娱乐-棋牌
let UM_disport_Chess = "disport_Chess"
/// 娱乐-KTV
let UM_disport_KTV = "disport_KTV"
/// 娱乐-电子游戏
let UM_disport_game = "disport_game"
/// 娱乐-其他
let UM_disport_other = "disport_other"
/// 运动-健身
let UM_sport_body = "sport_body"
/// 运动-球类
let UM_sport_ball = "sport_ball"
/// 运动-广场舞
let UM_sport_squaredance = "sport_squaredance"
/// 运动-其他
let UM_sport_other = "sport_other"
/// 出游-旅游
let UM_travel_tourism = "travel_tourism"
/// 出游-钓鱼
let UM_travel_fishing = "travel_fishing"
/// 出游-爬山
let UM_travel_mountains = "travel_mountains"
/// 出游-其他
let UM_travel_other = "travel_other"
/// 亲子-晒照
let UM_parenting_photo = "parenting_photo"
/// 亲子-玩伴
let UM_parenting_playmate = "parenting_playmate"
/// 亲子-出游
let UM_parenting_travel = "parenting_travel"
/// 亲子-其他
let UM_parenting_other = "parenting_other"

/// 社群聊天
let UM_communityChat = "communityChat"

/// 点击发布爆料按钮
let UM_releaseBaoliao = "releaseBaoliao"
/// 发布娱乐
let UM_release_disport = "release_disport"
/// 发布运动
let UM_release_sport = "release_sport"
/// 发布出游
let UM_release_travel = "release_travel"
/// 发布亲子
let UM_release_parenting = "release_parenting"

/// 首页搜索框
let UM_search = "search"
/// 扫一扫
let UM_scanCode = "scanCode"
/// 邀请好友
let UM_inviteFriend = "inviteFriend"
/// 客服电话
let UM_service_phone = "service_phone"

/// 社区公告
let UM_community_bulletin = "community_bulletin"
/// 办事流程
let UM_work_process = "work_process"
/// 社区公益
let UM_community_dedication = "community_dedication"


@objc class UM_Key : NSObject{
    class func single_event(string : String){
        MobClick.event(string)
    }
    class func event(string : String , dic: Dictionary<String, Any>){
        MobClick.event(string, attributes: dic)
    }
    
    class func shouye_community() -> String{
        return UM_shouye_community
    }
    class func shouye_activity() -> String{
        return UM_shouye_activity
    }
    class func shouye_sign() -> String{
        return UM_shouye_sign
    }
    class func shouye_business() -> String{
        return UM_shouye_business
    }
    class func news_hot() -> String{
        return UM_news_hot
    }
    class func news_healthy() -> String{
        return UM_news_healthy
    }
    class func news_funny() -> String{
        return UM_news_funny
    }
    class func news_baoliao() -> String{
        return UM_news_baoliao
    }
    class func sign() -> String{
        return UM_sign
    }
    class func share_QQ() -> String{
        return UM_share_QQ
    }
    class func share_QQspace() -> String{
        return UM_share_QQspace
    }
    class func share_wechat() -> String{
        return UM_share_wechat
    }
    class func share_wechatCircle() -> String{
        return UM_share_wechatCircle
    }
    class func disport_Chess() -> String{
        return UM_disport_Chess
    }
    class func disport_KTV() -> String{
        return UM_disport_KTV
    }
    class func disport_game() -> String{
        return UM_disport_game
    }
    class func disport_other() -> String{
        return UM_disport_other
    }
    class func sport_body() -> String{
        return UM_sport_body
    }
    class func sport_ball() -> String{
        return UM_sport_ball
    }
    class func sport_squaredance() -> String{
        return UM_sport_squaredance
    }
    class func sport_other() -> String{
        return UM_sport_other
    }
    class func travel_tourism() -> String{
        return UM_travel_tourism
    }
    class func travel_fishing() -> String{
        return UM_travel_fishing
    }
    class func travel_mountains() -> String{
        return UM_travel_mountains
    }
    class func travel_other() -> String{
        return UM_travel_other
    }
    class func parenting_photo() -> String{
        return UM_parenting_photo
    }
    class func parenting_playmate() -> String{
        return UM_parenting_playmate
    }
    class func parenting_travel() -> String{
        return UM_parenting_travel
    }
    class func parenting_other() -> String{
        return UM_parenting_other
    }
    class func communityChat() -> String{
        return UM_communityChat
    }
    class func releaseBaoliao() -> String{
        return UM_releaseBaoliao
    }
    class func release_disport() -> String{
        return UM_release_disport
    }
    class func release_sport() -> String{
        return UM_release_sport
    }
    class func release_travel() -> String{
        return UM_release_travel
    }
    class func release_parenting() -> String{
        return UM_release_parenting
    }
    class func search() -> String{
        return UM_search
    }
    class func scanCode() -> String{
        return UM_scanCode
    }
    class func inviteFriend() -> String{
        return UM_inviteFriend
    }
    class func service_phone() -> String{
        return UM_service_phone
    }
    class func community_bulletin() -> String{
        return UM_community_bulletin
    }
    class func work_process() -> String{
        return UM_work_process
    }
    class func community_dedication() -> String{
        return UM_community_dedication
    }
}
