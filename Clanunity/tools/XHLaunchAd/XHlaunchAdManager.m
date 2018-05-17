//
//  XHlaunchAdManager.m
//  Clanunity
//
//  Created by wangyadong on 2018/1/22.
//  Copyright © 2018年 zfy_srf. All rights reserved.
//

#import "XHlaunchAdManager.h"
#import "XHLaunchAd.h"

static XHlaunchAdManager * manager = nil;

@interface XHlaunchAdManager()<XHLaunchAdDelegate>{
    UIScrollView *_guideScrollView;
}



@end


@implementation XHlaunchAdManager

+(XHlaunchAdManager *)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XHlaunchAdManager alloc] init];
    });
    return manager;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        //在UIApplicationDidFinishLaunching时初始化开屏广告,做到对业务层无干扰,当然你也可以直接在AppDelegate didFinishLaunchingWithOptions方法中初始化
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            NSLog(@"DidFinishLaunchingNotification");
            //初始化开屏广告
            NSUserDefaults *guideUser = [NSUserDefaults standardUserDefaults];
            NSString *AppV =[DeviceIdentifier AppstrAppVersion];
            if ([guideUser objectForKey:GuidePageStartKey] != nil && [[guideUser objectForKey:GuidePageStartKey] isEqualToString:AppV]) {
                [self setupXHLaunchAd];
            }else{
                [self createGuideView];
                [self showGuideInWindow];
            }
        }];
    }
    return self;
}
-(void)setupXHLaunchAd{
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将不显示
    //3.数据获取成功,配置广告数据后,自动结束等待,显示广告
    //注意:请求广告数据前,必须设置此属性,否则会先进入window的的根控制器
    [XHLaunchAd setWaitDataDuration:3];
    WeakSelf;
//    [NetService GET_NetworkParameter:nil url:@"http://192.168.1.22:8080/api/main/startup" successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        //解析
//        if ([responseObject isKindOfClass:[NSArray class]]) {
//            NSArray *array = (NSArray*)responseObject;
//            if (array.count>0) {
//
//                NSDictionary *dic = array.firstObject;
//
//                /*
//                 {
//                 adname = "\U542f\U52a8\U5e7f\U544a";
//                 adtext = 1;
//                 imgurl = "http://apk.zhangfangyuan.com/serverimg/ad/6fc001ba84e04156891736bbf01eafe7.png";
//                 ts = 1495180498000;
//                 url = 1;
//                 }http://imgsrc.baidu.com/forum/pic/item/55b26363f6246b60c2c40fe6ebf81a4c530fa292.jpg
//                 */
//                //广告数据转模型
//                //配置广告数据
//                XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
//                //广告停留时间
//                imageAdconfiguration.duration = 2;
//                //广告frame
//                imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.8);
//                //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
//                imageAdconfiguration.imageNameOrURLString = dic[@"imgurl"];
//                //设置GIF动图是否只循环播放一次(仅对动图设置有效)
//                imageAdconfiguration.GIFImageCycleOnce = NO;
//                //缓存机制(仅对网络图片有效)
//                //为告展示效果更好,可设置为XHLaunchAdImageCacheInBackground,先缓存,下次显示
//                imageAdconfiguration.imageOption = XHLaunchAdImageDefault;
//                //图片填充模式
//                imageAdconfiguration.contentMode = UIViewContentModeScaleAspectFill;
//                //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
//                if ([dic[@"url"] hasPrefix:@"http"]) {
//                    imageAdconfiguration.openModel =dic[@"url"];
//                }
//                //广告显示完成动画
//                imageAdconfiguration.showFinishAnimate =ShowFinishAnimateLite;
//                //广告显示完成动画时间
//                imageAdconfiguration.showFinishAnimateTime = 0.8;
//                //跳过按钮类型
//                imageAdconfiguration.skipButtonType = SkipTypeTimeText;
//                //后台返回时,是否显示广告
//                imageAdconfiguration.showEnterForeground = NO;
//
//                //图片已缓存 - 显示一个 "已预载" 视图 (可选)
//                if([XHLaunchAd checkImageInCacheWithURL:[NSURL URLWithString:dic[@"imgurl"]]]){
//                    //设置要添加的自定义视图(可选)
////                    imageAdconfiguration.subViews = [self launchAdSubViews_alreadyView];
//
//                }
//                //显示开屏广告
//                [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:weakSelf];
//            }
//        }
//    } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//    }];
    
    
    
    /*
     {
     adname = "\U542f\U52a8\U5e7f\U544a";
     adtext = 1;
     imgurl = "http://apk.zhangfangyuan.com/serverimg/ad/6fc001ba84e04156891736bbf01eafe7.png";
     ts = 1495180498000;
     url = 1;
     }http://imgsrc.baidu.com/forum/pic/item/55b26363f6246b60c2c40fe6ebf81a4c530fa292.jpg
     */
    //广告数据转模型
    //配置广告数据
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
    //广告停留时间
    imageAdconfiguration.duration = 2;
    //广告frame
    imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.8);
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    NSString *imageUrl = @"http://imgsrc.baidu.com/forum/pic/item/55b26363f6246b60c2c40fe6ebf81a4c530fa292.jpg";
    imageAdconfiguration.imageNameOrURLString = imageUrl;
    //设置GIF动图是否只循环播放一次(仅对动图设置有效)
    imageAdconfiguration.GIFImageCycleOnce = NO;
    //缓存机制(仅对网络图片有效)
    //为告展示效果更好,可设置为XHLaunchAdImageCacheInBackground,先缓存,下次显示
    imageAdconfiguration.imageOption = XHLaunchAdImageDefault;
    //图片填充模式
    imageAdconfiguration.contentMode = UIViewContentModeScaleAspectFill;
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    if ([imageUrl hasPrefix:@"http"]) {
        imageAdconfiguration.openModel =imageUrl;
    }
    //广告显示完成动画
    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateLite;
    //广告显示完成动画时间
    imageAdconfiguration.showFinishAnimateTime = 0.8;
    //跳过按钮类型
    imageAdconfiguration.skipButtonType = SkipTypeTimeText;
    //后台返回时,是否显示广告
    imageAdconfiguration.showEnterForeground = NO;
    
    //图片已缓存 - 显示一个 "已预载" 视图 (可选)
    if([XHLaunchAd checkImageInCacheWithURL:[NSURL URLWithString:imageUrl]]){
        //设置要添加的自定义视图(可选)
        //                    imageAdconfiguration.subViews = [self launchAdSubViews_alreadyView];
        
    }
    //显示开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:weakSelf];
    
    
    
}
#pragma mark - XHLaunchAd delegate - 其他
//跳过按钮点击事件
-(void)skipAction{
    //移除广告
    [XHLaunchAd removeAndAnimated:YES];
}
/**
 广告点击事件回调
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint{
    
    NSLog(@"广告点击事件");
    /**
     openModel即配置广告数据设置的点击广告时打开页面参数
     */
}
/**
 *  图片本地读取/或下载完成回调
 *
 *  @param launchAd  XHLaunchAd
 *  @param image 读取/下载的image
 *  @param imageData 读取/下载的imageData
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd imageDownLoadFinish:(UIImage *)image imageData:(NSData *)imageData{
    NSLog(@"图片下载完成/或本地图片读取完成回调");
}
/**
 *  广告显示完成
 */
-(void)xhLaunchAdShowFinish:(XHLaunchAd *)launchAd{
    
    NSLog(@"广告显示完成");
}



#pragma mark - 引导页显示
-(void)createGuideView{
    
        _guideScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        _guideScrollView.bounces = NO;
        _guideScrollView.showsHorizontalScrollIndicator = NO;
        _guideScrollView.showsVerticalScrollIndicator = NO;
        _guideScrollView.pagingEnabled = YES;
        
        _guideScrollView.contentSize = CGSizeMake(3*KScreenWidth, KScreenHeight);
        CGFloat model = KScreenHeight/667;
        for (int i = 0; i < 3; i++) {
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(i*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
            imageV.userInteractionEnabled = YES;
            imageV.tag = 12306+i;
            imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"Guide%d.jpg",i+1]];
            [PLHelp imageAspectFillForImageView:imageV];
            [_guideScrollView addSubview:imageV];
            
            if (i < 2) {
                UIImageView *pointImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 47, 9)];
                pointImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"point_%d",i+1]];
                [imageV addSubview:pointImg];
                pointImg.centerX_sd = imageV.width_sd/2.0;
                pointImg.centerY_sd = KScreenHeight - KBottomHeight - 35*model;
            }
        }
        
        UIImageView *img = (UIImageView*)[_guideScrollView viewWithTag:12306+2];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((KScreenWidth-130)/2.0,KScreenHeight-150,115,32);
        [btn setImage:[UIImage imageNamed:@"Guide3_btn"] forState:UIControlStateNormal];
        btn.centerX_sd = img.centerX_sd;
        btn.centerY_sd = KScreenHeight - KBottomHeight - 35*model;
        [btn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
        [_guideScrollView addSubview:btn];
}
- (void)dismissView{
    
    [UIView animateWithDuration:1 animations:^{
        //1秒的过程中导航页隐藏、放大
        _guideScrollView.alpha = 0;
        _guideScrollView.transform = CGAffineTransformMakeScale(2.0, 2.0);
    } completion:^(BOOL finished) {
        //移除导航页 保证内存管理
        [_guideScrollView removeFromSuperview];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }];
    
    NSUserDefaults *defautls = [NSUserDefaults standardUserDefaults];
    //存储版本号更新
    NSString *AppV =[DeviceIdentifier AppstrAppVersion];
    [defautls setValue:AppV forKey:GuidePageStartKey];
    [defautls synchronize];
}

- (void)showGuideInWindow{
#if 0
    //先拿到UIApplication对象 单例 在拿到AppDelegate对象 也是单例
    AppDelegate *app = (id)[[UIApplication sharedApplication] delegate];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [app.window addSubview:_guideScrollView];
#else
    //keyWindow 当前活跃的window
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [[UIApplication sharedApplication].keyWindow addSubview:_guideScrollView];
#endif
    
}



@end
