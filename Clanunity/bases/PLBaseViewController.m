
//
//  PLBaseViewController.m
//  Clanunity
//  Dev::songruifeng
//  Created by zfy_srf on 2017/4/1.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//


#import "PLBaseViewController.h"
#import "CGImageGIFView.h"
#import "PLNewsViewController.h"

@interface PLBaseViewController ()<UIGestureRecognizerDelegate>
@property(nonatomic,weak) CGImageGIFView *gifView;

@end

@implementation PLBaseViewController

//TODO:判断聊天页面是不是push出来的。如果是present，则不显示右btnItem 左btnItem动作变为模态推出
-(BOOL)ifPush{
    if (self.presentingViewController) {
        return NO;
    } else {
        return YES;
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super init];
    if (self) {
        self.frame = frame;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.frame.size.width>0) {
        self.view.frame = self.frame;
    }
    [self preferredStatusBarStyle];
    self.view.backgroundColor = [UIColor PLColorEEEEEE_Background];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.navigationBar.barTintColor = [UIColor PLColorTheme];
    [self configNaviBar];
    //网络变化的通知
//    [self registNetworkReachabilityStatus];
    if (@available(iOS 11.0, *)) {
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}



- (void)configNaviBar{
    if ((self.isRootVC || !self.knavigationBar.superview) && self.knavigationBar)
    {
        [self.view addSubview:self.knavigationBar];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
-(void)showGifView{
    if (self.gifView == nil) {
        CGImageGIFView *imgView = [CGImageGIFView gifViewShowSuperView:self.view];
        self.gifView = imgView;
    }
    [self.view bringSubviewToFront:self.gifView];
    self.gifView.hidden = NO;
    [self.gifView startGIF];
}
-(void)hiddenGifView{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.gifView stopGIF];
        self.gifView.hidden = YES;
    });

}

-(void)popView:(NSString*)msg
{
    if(msg==nil || msg.length==0)
        return;
    
    UILabel* view=nil;
    UIView* bgView=nil;
    CGSize viewsize;
    CGSize max=CGSizeMake(150, 80);
    viewsize = [msg boundingRectWithSize:max options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldMT" size:15]} context:nil].size;
    
    NSInteger viewW = 80;
    NSInteger viewH = 80;
    viewW=viewW>viewsize.width?viewW:viewsize.width;
    viewH=viewH>viewsize.height?viewH:viewsize.height;
    
    if(viewW>60)//留出左右间隔
        viewW+=30;
    
    bgView = [[UILabel alloc] init];
    [bgView layer].cornerRadius = 3;
    [bgView layer].masksToBounds = YES;
    bgView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    view = [[UILabel alloc] initWithFrame:CGRectMake(15, 0,viewW-30,viewH)];
    [view setBackgroundColor:[UIColor clearColor]];
    
    
    [view setText:msg];
    view.numberOfLines=2;
    view.textColor = [UIColor whiteColor];
    [view setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15]];
    view.textAlignment = NSTextAlignmentCenter;
    
    [bgView addSubview:view];
    [self.view.window addSubview:bgView];

    bgView.size_sd = CGSizeMake(viewW, viewH);
    bgView.center = CGPointMake(KScreenWidth/2.0, KScreenHeight/2.0);
    bgView.alpha=0;
    bgView.transform = CGAffineTransformMakeScale(1.9,1.9);
    //进入动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    bgView.transform = CGAffineTransformMakeScale(1,1);
    bgView.alpha=1;
    [UIView commitAnimations];
    
    //     消失动画
    [self performSelector:@selector(popViewDisAnima:)withObject:bgView afterDelay:1.7];
    
    
}
-(void)popViewDisAnima:(UIView*)view
{
    //消失动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    view.transform = CGAffineTransformMakeScale(0.1,0.1);
    view.alpha=0;
    [UIView commitAnimations];
    [self performSelector:@selector(closeToast:)withObject:view afterDelay:0.4];
}

-(void)closeToast:(UIView*)view;
{
    [view removeFromSuperview];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载
-(UIView *)bageView{
    if ([self isKindOfClass:[PLNewsViewController class]]){
        if (!_bageView) {
            _bageView = [[UIView alloc]initWithFrame:CGRectMake(self.knavigationItem.rightBarButtonItem.customView.width_sd -20,10, 10, 10)];
            _bageView.backgroundColor = [UIColor redColor];
            _bageView.layer.masksToBounds = YES;
            _bageView.layer.cornerRadius = 5.0;
            _bageView.hidden = YES;
            [self.knavigationItem.rightBarButtonItem.customView addSubview:_bageView];
        }
    }
    return _bageView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
