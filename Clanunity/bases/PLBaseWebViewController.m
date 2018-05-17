//
//  PLBaseWebViewController.m
//  PlamLive
//
//  Created by wangyadong on 2017/3/22.
//  Copyright © 2017年 wangyadong. All rights reserved.
//

#import "PLBaseWebViewController.h"
#import <WebKit/WebKit.h>

@interface PLBaseWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic ,copy) NSString *NavTitle;

@end

@implementation PLBaseWebViewController
-(instancetype)initWithUrlStr:(NSString *)urlStr andNavTitle:(NSString *)navTitle

{
    if (self= [super init]) {
        _urlStr = urlStr;
        _NavTitle = navTitle;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.knavigationItem.title = _NavTitle;
    [self createNav];
    
    self.wkWebview = [[WKWebView alloc] initWithFrame:CGRectMake(0,KTopHeight,KScreenWidth ,KScreenHeight-KTopHeight)];
    self.wkWebview.UIDelegate = self;
    self.wkWebview.navigationDelegate = self;
    _wkWebview.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_wkWebview];
    [self requestForLoadWebView];
   
}
-(void)requestForLoadWebView{
    if (_urlStr.length>0) {
        NSURLRequest *requset = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
        [_wkWebview loadRequest:requset];
    }
}


-(void)createNav
{
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    [rightBtn setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    [rightBtn addTarget:self action:@selector(refreshWebView) forControlEvents:UIControlEventTouchUpInside];
    self.knavigationItem.rightBarButtonItem = [[KBarButtonItem alloc] initWithCustomView:rightBtn];
}
//刷新当前网址页面
-(void)refreshWebView  
{
    NSURLRequest *requset = [NSURLRequest requestWithURL:self.wkWebview.URL];
    [self.wkWebview loadRequest:requset];
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"开始加载");
    [self showGifView];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //webView 正文数据加载完 之后再加载评论数据
    self.knavigationItem.title = self.wkWebview.title;
    [self hiddenGifView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //自适应大小
        CGSize contentSize = webView.scrollView.contentSize;
        CGSize viewSize = self.view.bounds.size;
        if (contentSize.width > 0) {
            float rw = viewSize.width / contentSize.width;
            webView.scrollView.minimumZoomScale = rw;
            webView.scrollView.maximumZoomScale = rw;
            webView.scrollView.zoomScale = rw;
        }
    });
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"didFail");
    [self hiddenGifView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
