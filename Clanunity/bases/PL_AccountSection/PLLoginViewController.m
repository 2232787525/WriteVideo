//
//  PLLoginViewController.m
//  Clanunity
//
//  Created by zfy_srf on 2017/4/5.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

#import "PLLoginViewController.h"
#import "ThirdLoginManager.h"
#import "WXApi.h"
#import "KNavigationController.h"

@interface PLLoginViewController ()<UITextFieldDelegate>

@property(nonatomic,weak)UIButton * registerBtn;

@property(nonatomic,weak)UIButton * forgetBtn;


@property(nonatomic,weak)NSTimer * timer;
@property(nonatomic,assign)NSInteger timerId;

@property(nonatomic,weak)UITextField * phoneTf;

@property(nonatomic,weak)UITextField * psdTf;

@property(nonatomic,weak)UIButton * agreeStateBtn;

@property(nonatomic,weak)UIButton * loginButton;

@property(nonatomic,weak)UIImageView * weChatlg;
@property(nonatomic,weak)UIImageView * qqlg;

@property(nonatomic,strong)UIImageView * topBcImgView;

@property(nonatomic,strong)UIImageView * logoImgView;



@end

@implementation PLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.knavigationBar.hidden = YES;
    UIButton *leftBar = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBar.frame = CGRectMake(0,KStatusBarHeight, 44, 44);
    [leftBar setImage:[UIImage imageNamed:@"left_back_iconShadow"] forState:UIControlStateNormal];
    [self.view addSubview:leftBar];
    WeakSelf;
    [leftBar handleEventTouchUpInsideWithBlock:^{
        [weakSelf kBackBtnAction];
    }];
    
    [self makeUIView];
}

-(void)makeUIView{
    WeakSelf;
    self.view.backgroundColor = [UIColor PLColorBAE1E7];
    UIImageView *btmImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 375/2.0*kScreenScale)];
    btmImg.image = [UIImage imageNamed:@"btmbeijing"];
    btmImg.bottom_sd = KScreenHeight;
    [self.view addSubview:btmImg];
    
    UIImageView *leftcloud = [[UIImageView alloc] initWithFrame:CGRectMake(5,70, 58, 38.5)];
    leftcloud.image = [UIImage imageNamed:@"leftbaiyun"];
    [self.view addSubview:leftcloud];
    UIImageView *rightcloud = [[UIImageView alloc] initWithFrame:CGRectMake(5,25, 87, 57.5)];
    rightcloud.right_sd = KScreenWidth-5;
    rightcloud.image = [UIImage imageNamed:@"rightbaiyun"];
    [self.view addSubview:rightcloud];
    
    self.topBcImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth-20, (KScreenWidth-20)*976.0/694.0)];
    self.topBcImgView.userInteractionEnabled = YES;
    self.topBcImgView.image = [UIImage imageNamed:@"topLogin"];
    [self.view addSubview:self.topBcImgView];
    self.topBcImgView.left_sd = 10;
    self.topBcImgView.centerY_sd = KScreenHeight/2.0-3;
    CGFloat topViewCenter = self.topBcImgView.width_sd/2.0;
    UIImageView *logoImg = [[UIImageView alloc] initWithFrame:CGRectMake(40*kScreenScale, 30*kScreenScale, 115.5*kScreenScale, 115.5*kScreenScale)];
    logoImg.image = [UIImage imageNamed:@"logotouxiang"];
    [self.topBcImgView addSubview:logoImg];
    UIImageView *qqImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44*kScreenScale, 44*kScreenScale)];
    qqImg.image = [UIImage imageNamed:@"loginqq"];
    [self.topBcImgView addSubview:qqImg];
    qqImg.bottom_sd = self.topBcImgView.height_sd-35*kScreenScale;
    qqImg.left_sd = topViewCenter+15;
    self.qqlg = qqImg;
    UITapGestureRecognizer *qqTap = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
//        [weakSelf showGifView];
        [[ThirdLoginManager thirdLoginManager] thirdLoginForQQWithSuccess:^(LoginType type, NSString *masg, NSDictionary *result) {
            [weakSelf hiddenGifView];
            NSNumber *code = result[@"code"];
            if ([code integerValue] == 100) {
                [weakSelf thirdLoginSuccessWithResult:result];
            }else{
                [weakSelf thirdLoginSuccessNextBindMobileWithResult:result];
            }
            
        } failed:^(LoginType type, NSString *masg, NSString *status) {
            [weakSelf hiddenGifView];
        }];
 
    }];
    [self.qqlg addGestureRecognizer:qqTap];
    self.qqlg.userInteractionEnabled = YES;
    
    //微信
    UIImageView *wxImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44*kScreenScale, 44*kScreenScale)];
    wxImg.image = [UIImage imageNamed:@"loginweixin"];
    [self.topBcImgView addSubview:wxImg];
    wxImg.top_sd = qqImg.top_sd;
    wxImg.right_sd = topViewCenter-15;
    self.weChatlg = wxImg;
    UITapGestureRecognizer *wxTap = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
//        [weakSelf showGifView];
        APPDELEGATE.wxlogintype = 1;
        [[ThirdLoginManager thirdLoginManager] thirdLoginForWeChatSuccess:^(LoginType type, NSString *masg,NSDictionary* result) {
            [weakSelf hiddenGifView];
            NSNumber *code = result[@"code"];
            if ([code integerValue] == 100) {
                [weakSelf thirdLoginSuccessWithResult:result];
            }else{
                [weakSelf thirdLoginSuccessNextBindMobileWithResult:result];
            }
            
        } failed:^(LoginType type, NSString *masg, NSString *status) {
            [weakSelf hiddenGifView];
            [WFHudView showMsg:@"微信登录失败" inView:weakSelf.view];
        }];
    }];
    [self.weChatlg addGestureRecognizer:wxTap];
    self.weChatlg.userInteractionEnabled = YES;
    
    UILabel *lb = [UILabel labelFrame:CGRectMake(0, 0,70, 18) text:@"第三方登录" PLfont:[UIFont PLFont12] textPLColor:[UIColor PLColor999999] andTextAlignment:NSTextAlignmentCenter];
    lb.centerX_sd = topViewCenter;
    lb.bottom_sd = wxImg.top_sd-12*kScreenScale;
    [self.topBcImgView addSubview:lb];
    UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 0.5)];
    leftLine.backgroundColor = [UIColor PLColorDFDFDF_Cutline];
    [self.topBcImgView addSubview:leftLine];
    leftLine.right_sd = lb.left_sd-10;
    leftLine.centerY_sd = lb.centerY_sd;
    
    UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 0.5)];
    rightLine.backgroundColor = [UIColor PLColorDFDFDF_Cutline];
    [self.topBcImgView addSubview:rightLine];
    rightLine.left_sd = lb.right_sd+10;
    rightLine.centerY_sd = lb.centerY_sd;
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        //微信
        self.weChatlg.hidden = NO;
    }else{
        self.weChatlg.hidden = YES;
    }
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
        self.qqlg.hidden = NO;
    }else{
        self.qqlg.hidden = YES;
    }
    
    if (self.qqlg.hidden == YES&&self.weChatlg.hidden == YES) {
        lb.hidden = YES;
        rightLine.hidden = YES;
        leftLine.hidden = YES;
    }
    if ((self.qqlg.hidden == YES && self.weChatlg.hidden == NO) ||(self.qqlg.hidden == NO && self.weChatlg.hidden == YES)) {
        self.qqlg.centerX_sd = lb.centerX_sd;
        self.weChatlg.centerX_sd = lb.centerX_sd;
    }
    UIView *codeline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.topBcImgView.width_sd-2*60*kScreenScale, 0.5)];
    codeline.backgroundColor = [UIColor PLColor12B06B_Theme];
    [self.topBcImgView addSubview:codeline];
    codeline.left_sd = 60*kScreenScale;
    codeline.centerY_sd = self.topBcImgView.height_sd/2.0-8*kScreenScale;
    
    //注册
    UIButton*registerB = [[UIButton alloc] initWithFrame:CGRectMake(codeline.left_sd+5, codeline.bottom_sd+3,55, 24)];
    self.registerBtn = registerB;
    [self.registerBtn setTitleColor:[UIColor PLColor666666] forState:UIControlStateNormal];
    [self.registerBtn setTitle:@"快速注册" forState:UIControlStateNormal];
    self.registerBtn.titleLabel.font = [UIFont PLFont12];
    self.registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.topBcImgView addSubview:self.registerBtn];
    [self.registerBtn handleEventTouchUpInsideWithBlock:^{
        
       
    }];
    //忘记密码
    UIButton *forgetB = [[UIButton alloc] initWithFrame:CGRectMake(0,registerB.top_sd, registerB.width_sd, registerB.height_sd)];
    self.forgetBtn = forgetB;
    [self.forgetBtn setTitleColor:[UIColor PLColor666666] forState:UIControlStateNormal];
    [self.forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    self.forgetBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //self.forgetBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    self.forgetBtn.right_sd = codeline.right_sd-5;
    [self.topBcImgView addSubview:self.forgetBtn];
    [self.forgetBtn handleEventTouchUpInsideWithBlock:^{
       
    }];

    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(codeline.left_sd, 0, self.topBcImgView.width_sd-2*60*kScreenScale, 40*kScreenScale)];
    [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.topBcImgView addSubview:loginBtn];
    loginBtn.top_sd = registerB.bottom_sd+20*kScreenScale;
    loginBtn.backgroundColor = [UIColor PLColord9d9d9_UnTouch];
    loginBtn.enabled = NO;
    loginBtn.layer.cornerRadius = 5;
    loginBtn.layer.masksToBounds = YES;
    self.loginButton = loginBtn;
    [self loginBtnEnabledState:NO];
    [loginBtn handleEventTouchUpInsideWithBlock:^{
        [weakSelf requestForlogin];
    }];
    
    
    UIButton *agreebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    agreebtn.tag = 12306;
    agreebtn.frame = CGRectMake(0, 0, 25, 25);
    [agreebtn setImage:[UIImage imageNamed:@"agreexuanzhong"] forState:UIControlStateNormal];
    agreebtn.left_sd = loginBtn.left_sd-5;
    agreebtn.top_sd = loginBtn.bottom_sd+2;
    [self.topBcImgView addSubview:agreebtn];
    [agreebtn handleEventTouchUpInsideWithBlock:^{
        NSLog(@"用户协议同意不同意");
        if (weakSelf.agreeStateBtn.tag == 12306) {
            //点击之后就是不可登录
            [weakSelf.agreeStateBtn setImage:[UIImage imageNamed:@"agreexuan"] forState:UIControlStateNormal];
            weakSelf.agreeStateBtn.tag = 10086;
            
            if (weakSelf.phoneTf.text.length==11&&weakSelf.psdTf.text.length>=6) {
                [weakSelf loginBtnEnabledState:NO];
            }
        }else{
            [weakSelf.agreeStateBtn setImage:[UIImage imageNamed:@"agreexuanzhong"] forState:UIControlStateNormal];
            weakSelf.agreeStateBtn.tag = 12306;
            if (weakSelf.phoneTf.text.length==11&&weakSelf.psdTf.text.length>=6) {
                [weakSelf loginBtnEnabledState:YES];
            }
        }
    }];
    self.agreeStateBtn = agreebtn;
    
    UILabel *agreeLb= [UILabel labelFrame:CGRectMake(0, 0,57, 25) text:@"阅读并接受" PLfont:[UIFont PLFont11] textPLColor:[UIColor PLColor999999] andTextAlignment:NSTextAlignmentLeft];
    agreeLb.left_sd = agreebtn.right_sd;
    agreeLb.centerY_sd = agreebtn.centerY_sd;
    [self.topBcImgView addSubview:agreeLb];
    
    UILabel *zfyagreeLb= [UILabel labelFrame:CGRectMake(0, 0,105, 25) text:@"《掌方圆用户协议》" PLfont:[UIFont PLFont11] textPLColor:[UIColor PLColor12B06B_Theme] andTextAlignment:NSTextAlignmentLeft];
    zfyagreeLb.left_sd = agreeLb.right_sd;
    zfyagreeLb.centerY_sd = agreebtn.centerY_sd;
    [self.topBcImgView addSubview:zfyagreeLb];
    
    zfyagreeLb.userInteractionEnabled = YES;
    
    
    UIView *phoneline = [[UIView alloc] initWithFrame:CGRectMake(codeline.left_sd, 0, loginBtn.width_sd, 0.5)];
    phoneline.bottom_sd = codeline.top_sd-50*kScreenScale;
    phoneline.backgroundColor = [UIColor PLColor12B06B_Theme];
    [self.topBcImgView addSubview:phoneline];
    
    UITextField *phone = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, loginBtn.width_sd-20, 30)];
    phone.placeholder = @"请输入手机号码";
    [phone setValue:[UIColor PLColorD0D0D0] forKeyPath:@"_placeholderLabel.textColor"];
    phone.textColor = [UIColor PLColor33333];
    phone.font = [UIFont PLFont15];
    phone.bottom_sd = phoneline.top_sd;
    phone.left_sd = phoneline.left_sd+5;
    [self.topBcImgView addSubview:phone];
    phone.tintColor = [UIColor PLColor12B06B_Theme];
    phone.keyboardType = UIKeyboardTypeNumberPad;
    phone.clearButtonMode = UITextFieldViewModeWhileEditing;
    phone.delegate = self;
    self.phoneTf = phone;
    
    UITextField *psd = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, codeline.width_sd-20, 30)];
    psd.placeholder = @"请输入（6~16位）密码";
    [psd setValue:[UIColor PLColorD0D0D0] forKeyPath:@"_placeholderLabel.textColor"];
    psd.textColor = [UIColor PLColor33333];
    psd.font = [UIFont PLFont15];
    psd.bottom_sd = codeline.top_sd;
    psd.left_sd = codeline.left_sd+5;
    [self.topBcImgView addSubview:psd];
    psd.tintColor = [UIColor PLColor12B06B_Theme];
    psd.keyboardType = UIKeyboardTypeDefault;
    psd.clearButtonMode = UITextFieldViewModeWhileEditing;
    psd.secureTextEntry = YES;
    psd.delegate = self;
    self.psdTf = psd;
}
-(void)kBackBtnAction{
    if (![LOGIN_USER loginGetSessionModel].session_asd) {
        if (self.loginSuccessBlock) {
            self.loginSuccessBlock(NO);
        }
    }
    [super kBackBtnAction];
}
#pragma mark - 登录按钮状态改变
-(void)loginBtnEnabledState:(BOOL)state{
    
    if (state == YES) {
        [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.loginButton.backgroundColor = [UIColor PLColor12B06B_Theme];
        self.loginButton.enabled = YES;
    }else{
        [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.loginButton.backgroundColor = [UIColor PLColord9d9d9_UnTouch];
        self.loginButton.enabled = NO;
    }
}

#pragma mark - textfield delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSMutableString* textString = [NSMutableString stringWithString:textField.text];
    [textString replaceCharactersInRange:range withString:string];
    
    if ([string isEqualToString:@" "]) {//输入的是空格，就不要
        return NO;
    }
    if (textField == self.phoneTf) {
        if (range.location > 10) {//手机号码11位
            return NO;
        }
        if (textString.length == 11 && self.psdTf.text.length>=6) {
            
            if (self.agreeStateBtn.tag == 10086) {
                
                [self loginBtnEnabledState:NO];
            }else{
                [self loginBtnEnabledState:YES];
            }
            
        }else{
            [self loginBtnEnabledState:NO];
        }
    }
    
    if (textField == self.psdTf) {
        if (range.location > 15) {//>=6位 ，<=16位
            return NO;
        }
        if (textString.length >=6 && self.phoneTf.text.length == 11) {
            if (self.agreeStateBtn.tag == 10086) {
                [self loginBtnEnabledState:NO];
            }else{
                [self loginBtnEnabledState:YES];
            }
        }else{
            [self loginBtnEnabledState:NO];
        }
    }
    
    return YES;
}

#pragma mark - 登录 方法
-(void)requestForlogin{
    if ([PLGlobalClass valiMobilePhone:self.phoneTf.text] ==  NO) {
        [WFHudView showMsg:@"请输入正确的手机号" inView:self.view];
        return ;
    }
    if (self.psdTf.text.length <6 || self.psdTf.text.length > 16) {
        [WFHudView showMsg:@"请输入6~16位密码" inView:self.view];
        return;
    }
    [self.psdTf resignFirstResponder];
    [self.psdTf resignFirstResponder];
    NSDictionary *parDic = @{@"ggag":[PLHelp psdMD5WithPsd:self.psdTf.text],@"efeg":self.phoneTf.text};
    [self showGifView];
    NetworkParameter *parModel = [[NetworkParameter alloc] init];
    parModel.parameter = parDic;
    parModel.devicetoken = [LOGIN_USER deviceTokenGet];
    
    __weak typeof(self)weakSelf = self;
    [NetService POST_NetworkParameter:parModel url:URL_login_validate successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject = 登录信息 %@",responseObject);
        [weakSelf hiddenGifView];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            LoginResultModel *model = [LoginResultModel mj_objectWithKeyValues:responseObject];
            
            //result==100登录成功
            if ([model.result isEqualToString:@"100"]) {
                
                NSDictionary *sessionDic = [ResponseHelp getAsdApptokenCookeWithResponse:(NSHTTPURLResponse*)task.response];
                [LOGIN_USER loginSuccessSaveSessionData:[LoginSessionModel mj_objectWithKeyValues:sessionDic]];
                //保存用户基础数据
                [LOGIN_USER loginSuccessSaveUserData:[LoginUserModel mj_objectWithKeyValues:model.user]];
                //保存绑定账号
                [LOGIN_USER loginSuccessSaveBindsData:[BindModel mj_objectArrayWithKeyValuesArray:model.binds]];
                //保存 登录类型
                [LOGIN_USER loginSuccessSaveUTPData:model.utp];
                //保存 邀请码
                [LOGIN_USER loginSuccessSavesharecodeData:model.sharecode shareName:model.sharename];
                

                [WFHudView showMsg:@"登录成功" inView:weakSelf.view];                
                //发送登录成功的消息
                [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:NoticeLoginSuccess object:nil userInfo:nil]];
                NSLog(@"登录通知");
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (weakSelf.loginSuccessBlock) {
                        weakSelf.loginSuccessBlock(YES);
                    }
                    [weakSelf kBackBtnAction];
                });
            }else if ([model.result isEqualToString:@"104"]){
                [WFHudView showMsg:@"密码不正确" inView:weakSelf.view];
                weakSelf.psdTf.text = nil;
            }else if ([model.result isEqualToString:@"103"]){
                [WFHudView showMsg:@"用户名不存在" inView:weakSelf.view];
                weakSelf.psdTf.text = nil;
            }
        }
    } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf hiddenGifView];
        [WFHudView showMsg:@"登录失败" inView:weakSelf.view];
        NSLog(@"%@",error);
    }];
}
#pragma mark - 第三方登录返回之后的方法
/**第三方登录成功返回 */
-(void)thirdLoginSuccessWithResult:(NSDictionary*)result{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [WFHudView showMsg:@"登录成功" inView:self.view];
        });
        //子线程做事
        //直接登录
        NSDictionary *session = result[@"session"];
        NSDictionary *data = result[@"data"];
        [LOGIN_USER loginSuccessSaveSessionData:[LoginSessionModel mj_objectWithKeyValues:session]];
        LoginResultModel *model = [LoginResultModel mj_objectWithKeyValues:data];
        
        //保存用户基础数据
        [LOGIN_USER loginSuccessSaveUserData:[LoginUserModel mj_objectWithKeyValues:model.user]];
        //保存绑定账号
        [LOGIN_USER loginSuccessSaveBindsData:[BindModel mj_objectArrayWithKeyValuesArray:model.binds]];
        //保存 登录类型
        [LOGIN_USER loginSuccessSaveUTPData:model.utp];
        //保存 邀请码
        [LOGIN_USER loginSuccessSavesharecodeData:model.sharecode shareName:model.sharename];
        //发送登录成功的消息
        [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:NoticeLoginSuccess object:nil userInfo:nil]];
        NSLog(@"登录通知");
        //回到主线程修改UI
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self kBackBtnAction];
        });
    });

}
/**第三方登录 绑定手机号 */
-(void)thirdLoginSuccessNextBindMobileWithResult:(NSDictionary*)result{
    dispatch_async(dispatch_get_main_queue(), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [WFHudView showMsg:[NSString stringWithFormat:@"请绑定手机号"] inView:self.view];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
        });
    });
}

-(void)dealloc{
    NSLog(@"PLLoginViewController  -- dealloc");
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
