//
//  HomeNaviBarView.m
//  PlamLive
//
//  Created by wangyadong on 2016/11/1.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "HomeNaviBarView.h"
@interface HomeNaviBarView ()

@property(nonatomic,copy)AddressChooseBlock addressBlock;

//left
@property(nonatomic,weak)UIImageView * addressImg;
@property(nonatomic,weak)UIButton * chooseBtn;
@property(nonatomic,weak)UILabel * addressNamelb;

@end

@implementation HomeNaviBarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



+(HomeNaviBarView *)homeNavLeftAddressWithClicked:(AddressChooseBlock)addressB{
    return [[HomeNaviBarView alloc] initWithFrame:CGRectMake(0, 0,KScreenWidth/2.0, 44) withAddressB:addressB];
}

#pragma mark - 导航栏 右按钮 两个按钮设置
+(HomeNaviBarView *)navRightTwobarFirstImgName:(NSString *)firstName firstClicked:(BarButtonClicked)firstB secondImgName:(NSString *)secondName secondClicked:(BarButtonClicked)secondB{
    HomeNaviBarView *home = [[HomeNaviBarView alloc] initWithFrame:CGRectMake(0,0,75, 44) firstImg:[UIImage imageNamed:firstName] firstBlock:firstB secondImg:[UIImage imageNamed:secondName] secondBlock:secondB];
    return home;
}
-(instancetype)initWithFrame:(CGRect)frame firstImg:(UIImage*)firstImg firstBlock:(BarButtonClicked)firstB secondImg:(UIImage*)secondImg secondBlock:(BarButtonClicked)secondB{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        secondBtn.frame = CGRectMake(0, 0,38, 44);
        secondBtn.right_sd = self.width_sd+7;
        [secondBtn setImage:secondImg forState:UIControlStateNormal];
        secondBtn.tag = 2;
        [self addSubview:secondBtn];
        self.rightSecond = secondBtn;
        self.btn = secondBtn;
        [secondBtn handleEventTouchUpInsideWithBlock:^{
            if (secondB != nil) {
                secondB();
            }
        }];
        UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        firstBtn.frame = CGRectMake(0, 0,38, 44);
        firstBtn.right_sd = secondBtn.left_sd-1;
        [firstBtn setImage:firstImg forState:UIControlStateNormal];
        [self addSubview:firstBtn];
        self.rightFirst = firstBtn;
        firstBtn.tag  = 1;
        [firstBtn handleEventTouchUpInsideWithBlock:^{
            if (firstB) {
                firstB();
            }
        }];

    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame withAddressB:(AddressChooseBlock)addressB {
    self = [super initWithFrame:frame];
    if (self) {
        self.addressBlock = addressB;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15, 0,100,30)];
        btn.backgroundColor = [UIColor clearColor];
        [self addSubview:btn];
        self.chooseBtn = btn;
        btn.clipsToBounds = YES;
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityView.center = CGPointMake(20,15);
        [btn addSubview:activityView];
        activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        [activityView startAnimating];
        activityView.tag = 12307;
        
        self.addressImg.userInteractionEnabled = NO;
        UILabel *nameLb = [UILabel labelWithText:@"" andFont:13 andTextColor:[UIColor whiteColor] andTextAlignment:NSTextAlignmentLeft];
        nameLb.frame = CGRectMake(0, 0,55,btn.height_sd);
        [btn addSubview:nameLb];
        self.addressNamelb = nameLb;
        self.addressImg.centerY_sd = btn.height_sd/2.0;
        self.addressImg.left_sd = 13;
        self.addressNamelb.centerY_sd = self.addressImg.centerY_sd;
        self.addressNamelb.left_sd = self.addressImg.right_sd+8;
        self.chooseBtn.centerY_sd = self.height_sd/2.0;
        self.addressNamelb.userInteractionEnabled = NO;
        __weak typeof(self)weakSelf = self;
        [self.chooseBtn handleEventTouchUpInsideWithBlock:^{
            if (weakSelf.addressBlock) {
                weakSelf.addressBlock();
            }
        }];
        

    }
    return self;
}

-(void)setLeftAddressName:(NSString *)leftAddressName{
    UIActivityIndicatorView *acti = (UIActivityIndicatorView *)[self viewWithTag:12307];
    [acti stopAnimating];
    acti.hidden = YES;
    UIImageView *locimg = (UIImageView*)[self viewWithTag:12306];
    locimg.hidden = NO;
    _leftAddressName = leftAddressName;
    CGSize size = [PLGlobalClass sizeWithText:leftAddressName font:[UIFont systemFontOfSize:13] width:MAXFLOAT height:MAXFLOAT];
    CGFloat lbW = size.width+1;
    if (size.width > self.width_sd-30) {
        lbW = self.width_sd-30;
    }
    if (size.width < 55) {
        lbW = 55;
    }
    self.addressNamelb.text = leftAddressName;
    self.addressNamelb.width_sd = lbW;
    [UIView animateWithDuration:0.25 animations:^{
        self.chooseBtn.width_sd = self.addressNamelb.right_sd+10;
        
    }];
}

@end

