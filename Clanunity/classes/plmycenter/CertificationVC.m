//
//  CertificationVC.m
//  PlamLive
//
//  Created by Mac on 17/2/16.
//  Copyright © 2017年 wangyadong. All rights reserved.
//

#import "CertificationVC.h"
#import "RealNameVC.h"
#import "IdentityVC.h"

@interface CertificationVC ()

@property (nonatomic,strong)UIButton *personalBtn;
@property (nonatomic,strong)UILabel *personalLabel;
@property (nonatomic,strong)UIButton *enterpriseBtn;
@property (nonatomic,strong)UILabel *enterpriseLabel;

@end

@implementation CertificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pl_navigationItem.title = @"身份认证";
    self.pl_navigationItem.titleColor = [UIColor whiteColor];
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self addView];
}

-(void)addView
{
    _personalBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _personalBtn.frame =CGRectMake(0, 64, KScreenWidth, 200);
    [_personalBtn setImage:[UIImage imageNamed:@"identity"] forState:UIControlStateNormal];
    [_personalBtn addTarget:self action:@selector(personalRealname) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_personalBtn];
    
    _personalLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, _personalBtn.bottom_sd+5, KScreenWidth, 20)];
    _personalLabel.text =@"个人认证";
    _personalLabel.textAlignment =NSTextAlignmentCenter;
    _personalLabel.font =[UIFont systemFontOfSize:15];
    [self.view addSubview:_personalLabel];
    
    
    _enterpriseBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _enterpriseBtn.frame =CGRectMake(0, _personalLabel.bottom_sd+10, KScreenWidth, 200);
    [_enterpriseBtn setImage:[UIImage imageNamed:@"realname"] forState:UIControlStateNormal];
    [_enterpriseBtn addTarget:self action:@selector(enterpriseRealname) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_enterpriseBtn];
    
    
    _enterpriseLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, _enterpriseBtn.bottom_sd+5, KScreenWidth, 20)];
    _enterpriseLabel.text =@"企业认证";
    _enterpriseLabel.textAlignment =NSTextAlignmentCenter;
    _enterpriseLabel.font =[UIFont systemFontOfSize:15];
    [self.view addSubview:_enterpriseLabel];
    
}
-(void)personalRealname
{
    IdentityVC *identityV =[[IdentityVC alloc]init];
    [self.navigationController pushViewController:identityV animated:YES];
}
-(void)enterpriseRealname
{
    RealNameVC *realV =[[RealNameVC alloc]init];
    [self.navigationController pushViewController:realV animated:YES];
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
