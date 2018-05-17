//
//  PlayerViewController.m
//  KZWeChatSmallVideo_OC
//
//  Created by wangyadong on 2017/8/17.
//  Copyright © 2017年 侯康柱. All rights reserved.
//

#import "PlayerViewController.h"
#import "KZVideoPlayer.h"
#import "UIView+WDKit.h"
@interface PlayerViewController ()
@property(nonatomic,strong)KZVideoPlayer *player;
@property(nonatomic,strong)UIImageView * backImg;
@property(nonatomic,strong)UIView * showView;
@property(nonatomic,assign)BOOL show;
@property(nonatomic,strong)PlayerHeaderToor * headerToor;
@end

@implementation PlayerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.knavigationBar.hidden = YES;
    self.backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kzSCREEN_WIDTH, kzSCREEN_HEIGHT)];
    [self.view addSubview:self.backImg];
     self.backImg.contentMode=UIViewContentModeScaleAspectFit;
     self.backImg.clipsToBounds=YES;
    [ self.backImg setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kzSCREEN_WIDTH, kzSCREEN_HEIGHT)];
    [self.view addSubview:self.showView];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadPlayer];
    });
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    tapGesture1.delaysTouchesBegan = YES;
    [self.showView addGestureRecognizer:tapGesture1];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    tapGesture.delaysTouchesBegan = YES;
    [self.backImg addGestureRecognizer:tapGesture];
    self.show = NO;
    
    self.headerToor = [[PlayerHeaderToor alloc] initWithFrame:CGRectMake(0, 0, kzSCREEN_WIDTH, 64)];
    [self.view addSubview:self.headerToor];
    if (self.onlyShow == YES) {
        self.headerToor.deleteButton.hidden = YES;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.headerToor hiddenAnmition];

    });
    __weak typeof(self)weakSelf = self;
    [self.headerToor setBackClicked:^{
        [weakSelf kBackBtnAction];
    }];
    [self.headerToor setDeleteClicked:^{
        [KZVideoUtil deleteCacheVideo];
        if (weakSelf.deleteVideoBlock) {
            weakSelf.deleteVideoBlock();
        }
        [weakSelf kBackBtnAction];
    }];
    
    
    // Do any additional setup after loading the view.
}
-(void)tapAction{
    if (self.show) {
        self.show = NO;
        [self.headerToor hiddenAnmition];

        
    }else{
        self.show = YES;
        [self.headerToor showAnmition];

    }
}




-(void)loadPlayer{
    if (self.model != nil) {
        NSURL *videoUrl = [NSURL fileURLWithPath:self.model.videoAbsolutePath];
        self.player= [[KZVideoPlayer alloc] initWithFrame:self.showView.bounds videoUrl:videoUrl];
        [self.showView addSubview:self.player];
        self.backImg.image = [UIImage imageNamed:self.model.thumAbsolutePath];
        __weak typeof(self)weakSelf = self;
        [self.player setPlayerTapActionBlock:^{
            [weakSelf tapAction];
        }];
        return;
    }
    if (self.netModel != nil) {
        NSURL *videoUrl = [NSURL URLWithString:self.netModel.videoAbsolutePath];
        self.player= [[KZVideoPlayer alloc] initWithFrame:self.showView.bounds videoUrl:videoUrl];
        [self.showView addSubview:self.player];
//        [self.backImg sd_setImageWithURL:[NSURL URLWithString:self.netModel.thumAbsolutePath] placeholderImage:[UIImage imageNamed:PLACE_HEADIMG]];
        __weak typeof(self)weakSelf = self;
        [self.player setPlayerTapActionBlock:^{
            [weakSelf tapAction];
        }];
    }
    

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



@implementation PlayerHeaderToor

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [KZVideoConfig motionBlurView:self];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];

        self.top = self.top_sd;
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        [back setImage:[UIImage imageNamed:@"left_back_icon"] forState:UIControlStateNormal];
        back.frame = CGRectMake(5, 0,44,44);
        back.bottom_sd = self.height_sd;
        [self addSubview:back];
        
        [back addTarget:self action:@selector(backActionClicked) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
        [delete setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
        delete.frame = CGRectMake(10, 0, 44, 44);
        delete.bottom_sd = self.height_sd;
        delete.right_sd = self.width_sd-5;
        [self addSubview:delete];
        self.deleteButton = delete;
        [delete addTarget:self action:@selector(deleteActionClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)backActionClicked{
    if (self.backClicked) {
        self.backClicked();
    }
}

-(void)deleteActionClicked{
    if (self.deleteClicked) {
        self.deleteClicked();
    }
}

-(void)showAnmition{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.top_sd = self.top;
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];

    }];
}
-(void)hiddenAnmition{
   [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
       self.bottom_sd = self.top;
       [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
   } completion:^(BOOL finished) {
       
       
   }];
}


@end
