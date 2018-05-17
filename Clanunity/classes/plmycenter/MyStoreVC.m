//
//  MyStoreVC.m
//  PlamLive
//
//  Created by Mac on 16/12/2.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "MyStoreVC.h"

#import "MyStoreCell.h"
#import "NoviceCell.h"
#import "CertificationCell.h"
#import "StoreUserModel.h"

//发布产品
#import "PLReleaseBabyVC.h"
//产品管理
#import "PLProductManagerVC.h"
//店铺维修
#import "StoreRepairVC.h"
//弹出视图
#import "PopoverView.h"

@interface MyStoreVC ()<UITableViewDataSource,UITableViewDelegate,PopoverViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong)StoreUserModel *userModel;

@property (nonatomic,strong)NSMutableArray *userArr;

@end

@implementation MyStoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self preferredStatusBarStyle];
    // Do any additional setup after loading the view from its nib.
    self.pl_navigationBar.backgroundColor = [UIColor whiteColor];
    
    self.pl_navigationItem.title = @"我的商铺";
    self.pl_navigationItem.titleColor =[UIColor blackColor];
    
//商铺tablebiew
    [self createMyStoreTableView];
//左边导航
    [self NavLeftButton];
//自定义中间view
    [self createDivbuttonView];
//自定义底部view
    [self createBottombuttonView];
//商家信息请求
    [self parseDatauuidWithmerchants];
//通知回调
    [self jumpRepair];
    
}

-(void)jumpRepair
{
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(changeRepair) name:@"Repair" object:nil];
}
//接到通知调用此方法
-(void)changeRepair{
    [self parseDatauuidWithmerchants];
}




-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}


//请求唯一标识获取商家信息
-(void)parseDatauuidWithmerchants
{
    [self showGifView];
    __weak typeof(self)weakSelf = self;
    
    NSString * seller =[LOGIN_USER loginGetResult].sellerModel.uuid;
    
    NetworkParameter *parModel =[[NetworkParameter alloc]init];
    parModel.parameter =@{@"uid":seller};
    
    [NetService GET_NetworkParameter:parModel url:Seller_sellerbyuid successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf hiddenGifView];
        weakSelf.userModel = [StoreUserModel pl_initWithDictionary:responseObject];
        [weakSelf.userArr addObject:weakSelf.userModel];
        [weakSelf.tableView reloadData];

    } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf hiddenGifView];
        [WFHudView  showMsg:@"获取店铺信息失败" inView:weakSelf.view];
    }];

}
-(void)createDivbuttonView
{
    UIView *buttonView =[[UIView alloc]initWithFrame:CGRectMake(0, 290, KScreenWidth, 5+KScreenWidth/4-40+10+30+10 )];
    buttonView.backgroundColor = [UIColor PLColorGlobalBack];
    [self.view addSubview:buttonView];
    
    NSArray *buttonArr =@[@"imdp_1",@"imdp_9",@"imdp_6",@"imdp_5"];
    NSArray *labelArr =@[@"发布产品",@"管理产品",@"活动管理",@"生意参谋"];
    
    for (int i=0; i<4; i++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =CGRectMake(25+i*KScreenWidth/4, 5, KScreenWidth/4-40, KScreenWidth/4-40);
        [button setImage:[UIImage imageNamed:buttonArr[i]] forState:UIControlStateNormal];
        button.tag = 10 +i;
        //添加响应事件
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:button];
        
        UILabel *label =[[UILabel alloc]init];
        label.frame  =CGRectMake(15+i*KScreenWidth/4, 5+KScreenWidth/4-40+10, KScreenWidth/4-20, 30);
        label.text =labelArr[i];
        label.font =[UIFont systemFontOfSize:14];
//        label.lee_theme.LeeConfigTextColor(ThemeDarkTextColor);
        
        [buttonView addSubview:label];
    }
}
#pragma mark - 按钮响应方法
-(void)buttonClick:(UIButton *)button
{
    switch (button.tag - 10) {
        case 0:
        {
            PLReleaseBabyVC *releaseV =[[PLReleaseBabyVC alloc]init];
            [self.navigationController pushViewController:releaseV animated:YES];
            break;
        }
        case 1:
        {
            PLProductManagerVC *productV =[[PLProductManagerVC alloc]init];
            [self.navigationController pushViewController:productV animated:YES];
             break;
        }
           
        case 2:
        {
            NSLog(@"点击了2");
            break;
        }
        default:
            break;
    }
}
-(void)createBottombuttonView
{
    UIView *buttonView =[[UIView alloc]initWithFrame:CGRectMake(0, 400, KScreenWidth, 5+KScreenWidth/4-40+10+30+10+KScreenWidth/4-40+10+30+10+30+5)];
    buttonView.backgroundColor = [UIColor PLColorGlobalBack];

    [self.view addSubview:buttonView];
    
    NSArray *buttonArr =@[@"imdp_2",@"imdp_3",@"imdp_4",@"imdp_7"];
    NSArray *labelArr =@[@"店铺装修",@"营销推广",@"小店学院",@"一件代发"];
    
    for (int i=0; i<4; i++) {
        
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =CGRectMake(25+i*KScreenWidth/4, 5, KScreenWidth/4-40, KScreenWidth/4-40);
        [button setImage:[UIImage imageNamed:buttonArr[i]] forState:UIControlStateNormal];
        
        [buttonView addSubview:button];
    
        UILabel *label =[[UILabel alloc]init];
        label.frame  =CGRectMake(15+i*KScreenWidth/4, 5+KScreenWidth/4-40+10, KScreenWidth/4-20, 30);
        label.text =labelArr[i];
        label.textColor =[UIColor colorWithRed:147/255.f green:147/255.f blue:147/255.f alpha:1];
        label.font =[UIFont systemFontOfSize:14];
        
        [buttonView addSubview:label];
        
        UIButton *Morebtn =[UIButton buttonWithType:UIButtonTypeCustom];
        Morebtn.frame =CGRectMake(25, 5+KScreenWidth/4-40+10+30+10, KScreenWidth/4-40, KScreenWidth/4-40);
        [Morebtn setImage:[UIImage imageNamed:@"imdp_8"] forState:UIControlStateNormal];
        
        [buttonView addSubview:Morebtn];
        
        UILabel *moreLabel =[[UILabel alloc]init];
        moreLabel.frame  =CGRectMake(15, 5+KScreenWidth/4-40+10+30+10+5+KScreenWidth/4-40, KScreenWidth/4-20, 30);
        moreLabel.text =@"更多";
        moreLabel.textColor =[UIColor colorWithRed:147/255.f green:147/255.f blue:147/255.f alpha:1];
        moreLabel.textAlignment = NSTextAlignmentCenter;
        moreLabel.font =[UIFont systemFontOfSize:14];
        
        [buttonView addSubview:moreLabel];
    }
    
}
-(void)NavLeftButton
{
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftBtn addTarget:self action:@selector(searchPageback) forControlEvents:UIControlEventTouchUpInside];
    
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    
    [leftBtn setImage:[UIImage imageNamed:@"leftblueback1"] forState:UIControlStateNormal];
    
    [leftBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    
    self.pl_navigationItem.leftBarButtonItem = [[PLBarButtonItem alloc] initWithCustomView:leftBtn];
    
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightBtn addTarget:self action:@selector(clickMoreright) forControlEvents:UIControlEventTouchUpInside];
    
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    
    [rightBtn setImage:[UIImage imageNamed:@"more-blue"] forState:UIControlStateNormal];
    
    [rightBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
    
    self.pl_navigationItem.rightBarButtonItem = [[PLBarButtonItem alloc] initWithCustomView:rightBtn];
    
}
-(void)searchPageback
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)clickMoreright
{
    CGPoint point = CGPointMake(KScreenWidth-30, 64);
    
    PopoverView *view = [[PopoverView alloc]initWithPoint:point
                                                   titles:@[@"店铺维修",@"店铺关闭"]
                                               imageNames:nil];
    view.delegate = self;
    [view show];
   
}
#pragma mark - PopoverViewDelegate
- (void)didSelectedRowAtIndex:(NSInteger)index{
    
    if (index == 0)
    {
        StoreRepairVC *repairV =[[StoreRepairVC alloc]init];
        repairV.repairUserModel =self.userModel;
        [self.navigationController pushViewController:repairV animated:YES];
        
    }else if(index == 1)
    {
        [PLGlobalClass aletWithTitle:@"点击了店铺关闭" Message:nil sureTitle:@"确定" CancelTitle:@"取消" SureBlock:^{
            
        } andCancelBlock:^{
            
        } andDelegate:self];
        
    }else
    {
        NSLog(@"新添加的");
    }
}

#pragma mark --我的店铺信息 TableView
-(void)createMyStoreTableView
{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, 220) style:UITableViewStylePlain];
    
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset: UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins: UIEdgeInsetsZero];
    }
    
    
    self.tableView.scrollEnabled =NO;
    
    self.tableView.backgroundColor = [UIColor PLColorGlobalBack];

    
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator   = NO;
    
    self.tableView.separatorColor = [UIColor PLColorSeparateLine];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyStoreCell" bundle:nil] forCellReuseIdentifier:@"MyStoreCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NoviceCell" bundle:nil] forCellReuseIdentifier:@"NoviceCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CertificationCell" bundle:nil] forCellReuseIdentifier:@"CertificationCell"];
    
    [self.view addSubview:self.tableView];
}
//cell线条 代理方法
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

/*******************UITableViewDelegate********************/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row ==0) {
        return 100;
    }else
    {
        return 60;
    }
}
/***********************UITableViewDatasoure**********************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row ==0) {
        
        MyStoreCell *cell =[tableView dequeueReusableCellWithIdentifier:@"MyStoreCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor PLColorContentBack];
        cell.contentView.backgroundColor = [UIColor PLColorContentBack];
        
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor PLColorCellSelected];
        
        [cell SetModelWithStoreUsermodel:_userModel];
        
        return cell;
        
    }else if (indexPath.row ==1)
    {
        NoviceCell *cell =[tableView dequeueReusableCellWithIdentifier:@"NoviceCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = [UIColor PLColorContentBack];
        cell.contentView.backgroundColor = [UIColor PLColorContentBack];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor PLColorCellSelected];
        return cell;
    }else
    {
        CertificationCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CertificationCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = [UIColor PLColorContentBack];
        cell.contentView.backgroundColor = [UIColor PLColorContentBack];
        
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor PLColorCellSelected];
        
        return cell;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   
    
    
}
- (NSMutableArray *)userArr{
    if (!_userArr) {
        _userArr  = [[NSMutableArray alloc]init];
    }
    return _userArr;
}

-(void)dealloc{
    
    //移除监听者(通知)
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
