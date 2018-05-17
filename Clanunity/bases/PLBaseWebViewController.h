//
//  PLBaseWebViewController.h
//  PlamLive
//
//  Created by wangyadong on 2017/3/22.
//  Copyright © 2017年 wangyadong. All rights reserved.
//

#import "PLBaseViewController.h"
@class WKWebView;
@interface PLBaseWebViewController : PLBaseViewController

@property (nonatomic ,strong) WKWebView *wkWebview;
@property (nonatomic ,copy) NSString *urlStr;
@property (nonatomic ,copy) NSDictionary *shareDic;

-(instancetype)initWithUrlStr:(NSString *)urlStr andNavTitle:(NSString *)navTitle;
-(void)createNav;
-(void)requestForLoadWebView;


@end
