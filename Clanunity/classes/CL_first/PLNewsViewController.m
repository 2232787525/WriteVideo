//
//  PLNewsViewController.m
//  Clanunity
//
//  Created by zfy_srf on 2017/4/1.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

#import "PLNewsViewController.h"
//segment
#import "NavigationBarView.h"
#import "PLNewsViewVC.h"

#import "KNavigationController.h"
#import "LPSemiModalView.h"

#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#pragma mark - 新的
#import "PageBaseVC.h"

@interface PLNewsViewController ()<UIScrollViewDelegate>{
    CGFloat _marginalBottom;//小临界值
    CGFloat _marginalTop;//大临界值
    BOOL _drag;//是否是在手指拖动状态
    CGFloat _scopeH;//滑动范围
    CGFloat _startY;
    BOOL _scrollDown;//向下滑
    //固定高度
    CGFloat _fixedViewBottom;
    
#pragma mark - xinde
    CGFloat _scrollViewBeginTopInset;
    CGFloat _topViewHeight;
    CGFloat _menuHeight;
    CGFloat _beginOffsetX;

}
@property(nonatomic,strong)NSMutableArray<NSString*> * segmentArray;

@property(nonatomic,strong)NavigationBarView * segmentBtnView;
@property (strong, nonatomic) UIPageViewController *pageController;
@property (nonatomic, strong)NSArray *controllers;
@property (nonatomic, assign) NSInteger willIndex;
@property (nonatomic, assign) NSInteger currentIndex;

@property(nonatomic,strong)UIScrollView * backView;

@property (nonatomic, strong) LPSemiModalView *narrowedModalView;


#pragma mark - 新的

@property (nonatomic, assign) CGFloat lastPageMenuY;

@property (nonatomic, assign) CGPoint lastPoint;

@end

@implementation PLNewsViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Miniature" ofType:@"mp4"];
    if(UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path))
    {
        UISaveVideoAtPathToSavedPhotosAlbum(path,nil,nil,nil);
    }
    else {
        //NSLog(@"no available");
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"no available" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        [alert show];
    }
    
    
    
    
//    self.knavigationItem.leftBarButtonItem = nil;
//    self.knavigationItem.title = @"首页";
//
//    //把scrollview放到底部
//    [self.view addSubview:self.backView];
//    _menuHeight = 44;
//    [self.view addSubview:self.segmentBtnView];
//    _scrollViewBeginTopInset = _topViewHeight + _menuHeight;
//
//    self.lastPageMenuY = self.segmentBtnView.top_sd;
//
//    // 监听子控制器发出的通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(subScrollViewDidScroll:) name:ChildScrollViewDidScrollNSNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshState:) name:ChildScrollViewRefreshStateNSNotification object:nil];
//    //获取分类
////    [self requestForCatgeory];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UnreadMessageWithbageView) name:@"UnreadMessage" object:nil];
}

//TODO:消息推送 消息提醒
-(void)UnreadMessageWithbageView{
    dispatch_async(dispatch_get_main_queue(), ^{
        //读取未读条数更新（环信的未读条数，由于没有会话列表，所以小红点暂时先删掉）
        self.bageView.hidden = NO;
    });
}

#pragma mark - scrollView 代理
//屏幕滑动监测
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    PageBaseVC *baseVc = self.childViewControllers[self.segmentBtnView.curruntNum];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (baseVc.scrollView.contentSize.height < KScreenHeight-KTopHeight-KBottomHeight && [baseVc isViewLoaded]) {
            [baseVc.scrollView setContentOffset:CGPointMake(0, -_scrollViewBeginTopInset) animated:YES];
        }
    });
    
    // 这个if条件的意思就是没有滑动的意思
    if (!scrollView.dragging && !scrollView.decelerating) {return;}
    
    // 当滑到边界时，继续通过scrollView的bouces效果滑动时，直接return
    if (scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > scrollView.contentSize.width-scrollView.bounds.size.width) {
        return;
    }
    
    static int i = 0;
    if (i == 0) {
        _beginOffsetX = scrollView.bounds.size.width * self.segmentBtnView.curruntNum;
        i = 1;
    }
    // 当前偏移量
    CGFloat currentOffSetX = scrollView.contentOffset.x;
    // 偏移进度
    CGFloat offsetProgress = currentOffSetX / scrollView.bounds.size.width;
    CGFloat progress = offsetProgress - floor(offsetProgress);
    
    NSInteger fromIndex;
    NSInteger toIndex;
    
    if (currentOffSetX - _beginOffsetX > 0) { // 向左拖拽了
        // 求商,获取上一个item的下标
        fromIndex = currentOffSetX / scrollView.bounds.size.width;
        // 当前item的下标等于上一个item的下标加1
        toIndex = fromIndex + 1;
        if (toIndex >= 4) {
            toIndex = fromIndex;
        }
    } else if (currentOffSetX - _beginOffsetX < 0) {  // 向右拖拽了
        toIndex = currentOffSetX / scrollView.bounds.size.width;
        fromIndex = toIndex + 1;
        progress = 1.0 - progress;
        
    } else {
        progress = 1.0;
        fromIndex = self.segmentBtnView.curruntNum;
        toIndex = fromIndex;
    }
    
    if (currentOffSetX == scrollView.bounds.size.width * fromIndex) {// 滚动停止了
        progress = 1.0;
        toIndex = fromIndex;
    }
    
    // 如果滚动停止，直接通过点击按钮选中toIndex对应的item
    if (currentOffSetX == scrollView.bounds.size.width*toIndex) {
        i = 0;
        [self.segmentBtnView changeSelectedIndex:toIndex];
        return;
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    PageBaseVC *baseVc = self.childViewControllers[self.segmentBtnView.curruntNum];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (baseVc.scrollView.contentSize.height < KScreenHeight-KTopHeight-KBottomHeight  && [baseVc isViewLoaded]) {
            [baseVc.scrollView setContentOffset:CGPointMake(0, -_scrollViewBeginTopInset) animated:YES];
        }
    });
}

#pragma mark - SPPageMenuDelegate
-(void)segmentViewClickeditemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex{
    if (!self.childViewControllers.count) { return;}
    // 如果上一次点击的button下标与当前点击的buton下标之差大于等于2,说明跨界面移动了,此时不动画.
    if (labs(toIndex - fromIndex) >= 2) {//跨界了不动画
        [self.backView setContentOffset:CGPointMake(_backView.frame.size.width * toIndex, 0) animated:NO];
    } else {
        [self.backView setContentOffset:CGPointMake(_backView.frame.size.width * toIndex, 0) animated:YES];
    }
    PageBaseVC *fromViewController = self.childViewControllers[fromIndex];
    PageBaseVC *targetViewController = self.childViewControllers[toIndex];
    if (fromIndex != toIndex) {
        if ([fromViewController isKindOfClass:[PLNewsViewVC class]]) {
            [fromViewController viewWillDisappear:NO];
        }
    }
    
    // 如果已经加载过，就不再加载
    if ([targetViewController isViewLoaded]) return;
    
    // 来到这里必然是第一次加载控制器的view，这个属性是为了防止下面的偏移量的改变导致走scrollViewDidScroll
    targetViewController.isFirstViewLoaded = YES;
    targetViewController.view.frame = CGRectMake(KScreenWidth*toIndex, 0, KScreenWidth, KScreenHeight-KTopHeight-KBottomHeight);
    
    UIScrollView *s = targetViewController.scrollView;
    CGPoint contentOffset = s.contentOffset;
    if (contentOffset.y + _scrollViewBeginTopInset >= _topViewHeight) {
        contentOffset.y = _topViewHeight-_scrollViewBeginTopInset;
    }
    s.contentOffset = contentOffset;
    [self.backView addSubview:targetViewController.view];
}

-(NSMutableArray<NSString *> *)segmentArray{
    if (!_segmentArray) {
        _segmentArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _segmentArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - segmentView
-(NavigationBarView *)segmentBtnView{
    if (!_segmentBtnView) {
        _segmentBtnView = [[NavigationBarView alloc] initWithFrame:CGRectMake(0,0, KScreenWidth, _menuHeight) withSegmentArray:nil];
        _segmentBtnView.backgroundColor = [UIColor whiteColor];
        _segmentBtnView.bottomLineColor = [UIColor PLColorDFDFDF_Cutline];
        WeakSelf;
        [_segmentBtnView setChangeClickedBlock:^(NSInteger fromIndex, NSInteger toIndex) {
            [weakSelf segmentViewClickeditemSelectedFromIndex:fromIndex toIndex:toIndex];
            
        }];
    }
    return _segmentBtnView;
}

#pragma mark - 底部scrollview
-(UIScrollView *)backView{
    if (!_backView) {
        _backView = [[UIScrollView alloc] init];
        _backView.frame = CGRectMake(0, KTopHeight, KScreenWidth, KScreenHeight-KBottomHeight-KTopHeight);
        _backView.delegate = self;
        _backView.pagingEnabled = YES;
        _backView.showsVerticalScrollIndicator = NO;
        _backView.showsHorizontalScrollIndicator = NO;
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateBegan) {
        
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint currenrPoint = [pan translationInView:pan.view];
        CGFloat distanceY = currenrPoint.y - self.lastPoint.y;
        self.lastPoint = currenrPoint;
        NSLog(@"currenrPoint==%f",currenrPoint.y);
        if (self.childViewControllers.count == 0) {
            return;
        }
        PageBaseVC *baseVc = self.childViewControllers[self.segmentBtnView.curruntNum];
        CGPoint offset = baseVc.scrollView.contentOffset;
        offset.y += -distanceY;
        if (offset.y <= -_scrollViewBeginTopInset) {
            offset.y = -_scrollViewBeginTopInset;
        }
        baseVc.scrollView.contentOffset = offset;
    } else {
        [pan setTranslation:CGPointZero inView:pan.view];
        self.lastPoint = CGPointZero;
    }
}

#pragma mark - 检测到通知
// 子控制器上的scrollView已经滑动的代理方法所发出的通知(核心)
- (void)subScrollViewDidScroll:(NSNotification *)noti {
    // 取出当前正在滑动的tableView
    UIScrollView *scrollingScrollView = noti.userInfo[@"scrollingScrollView"];
    CGFloat offsetDifference = [noti.userInfo[@"offsetDifference"] floatValue];
    
    CGFloat distanceY;
    
    // 取出的scrollingScrollView并非是唯一的，当有多个子控制器上的scrollView同时滑动时都会发出通知来到这个方法，所以要过滤
    PageBaseVC *baseVc = self.childViewControllers[self.segmentBtnView.curruntNum];
    
    if (scrollingScrollView == baseVc.scrollView && baseVc.isFirstViewLoaded == NO) {
        
        // 让悬浮菜单跟随scrollView滑动
        CGRect pageMenuFrame = self.segmentBtnView.frame;
        
        if (pageMenuFrame.origin.y >= KTopHeight) {
            // 往上移
            if (offsetDifference > 0 && scrollingScrollView.contentOffset.y+_scrollViewBeginTopInset > 0) {
                if (((scrollingScrollView.contentOffset.y+_scrollViewBeginTopInset+self.segmentBtnView.frame.origin.y)>=_topViewHeight) || scrollingScrollView.contentOffset.y+_scrollViewBeginTopInset < 0) {
                    // 悬浮菜单的y值等于当前正在滑动且显示在屏幕范围内的的scrollView的contentOffset.y的改变量(这是最难的点)
                    pageMenuFrame.origin.y += -offsetDifference;
                    if (pageMenuFrame.origin.y <= KTopHeight) {
                        pageMenuFrame.origin.y = KTopHeight;
                    }
                }
            } else { // 往下移
                if ((scrollingScrollView.contentOffset.y+_scrollViewBeginTopInset+self.segmentBtnView.frame.origin.y)<_topViewHeight+KTopHeight) {
                    pageMenuFrame.origin.y = -scrollingScrollView.contentOffset.y-_scrollViewBeginTopInset+_topViewHeight+KTopHeight;
                    if (pageMenuFrame.origin.y >= _topViewHeight+KTopHeight) {
                        pageMenuFrame.origin.y = _topViewHeight+KTopHeight;
                    }
                }
            }
        }
        self.segmentBtnView.frame = pageMenuFrame;
                
        // 记录悬浮菜单的y值改变量
        distanceY = pageMenuFrame.origin.y - self.lastPageMenuY;
        self.lastPageMenuY = self.segmentBtnView.frame.origin.y;
        
        // 让其余控制器的scrollView跟随当前正在滑动的scrollView滑动
        [self followScrollingScrollView:scrollingScrollView distanceY:distanceY];
        
    }
    baseVc.isFirstViewLoaded = NO;
}

- (void)followScrollingScrollView:(UIScrollView *)scrollingScrollView distanceY:(CGFloat)distanceY{
    PageBaseVC *baseVc = nil;
    for (int i = 0; i < self.childViewControllers.count; i++) {
        baseVc = self.childViewControllers[i];
        if (baseVc.scrollView == scrollingScrollView) {
            continue;
        } else {
            CGPoint contentOffSet = baseVc.scrollView.contentOffset;
            contentOffSet.y += -distanceY;
            baseVc.scrollView.contentOffset = contentOffSet;
        }
    }
}

- (void)refreshState:(NSNotification *)noti {
    BOOL state = [noti.userInfo[@"isRefreshing"] boolValue];
    // 正在刷新时禁止self.scrollView滑动
    self.backView.scrollEnabled = !state;
}

@end

