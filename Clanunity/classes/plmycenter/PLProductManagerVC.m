//
//  PLProductManagerVC.m
//  PlamLive
//
//  Created by Mac on 16/12/9.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "PLProductManagerVC.h"

#import "ManagerCell.h"

#import "StoreProductModel.h"

@interface PLProductManagerVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *productArr;

@property (nonatomic,weak) StoreProductModel *productModel;

@end

@implementation PLProductManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pl_navigationItem.title = @"产品管理";
    self.pl_navigationItem.titleColor = [UIColor whiteColor];
    
    [self NavcreateRightbutton];
    
    [self createProductManagerTableView];
    
    [self ParseDatatoobtainProduct];
    
}
//获取产品信息
-(void)ParseDatatoobtainProduct
{
    [self showGifView];
    
    __weak typeof(self)weakSelf = self;
    
    NSString *uuid =[LOGIN_USER loginGetResult].sellerModel.uuid;

    
    NetworkParameter *parModel =[[NetworkParameter alloc]init];
    parModel.parameter =@{@"seuid":uuid,
                          @"pno":@"1",
                          @"pnu":@"20",
                          };
    [NetService GET_NetworkParameter:parModel url:Seller_myproductlist successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self hiddenGifView];
        
        if ([responseObject isKindOfClass:[NSArray class]])
        {
            NSArray * responseObjectArray = responseObject;
            
            if (responseObjectArray >0) {
                
                for (int i = 0; i<responseObjectArray.count; i++) {
                    
                    [weakSelf.productArr addObject:[StoreProductModel pl_initWithDictionary:[responseObjectArray objectAtIndex:i]]];
                }
            }else
            {
                [WFHudView showMsg:@"解析出错" inView:weakSelf.view];
            }
        }
        
        [weakSelf.tableView reloadData];
        
    } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [WFHudView showMsg:@"出错了" inView:weakSelf.view];
        
        [weakSelf hiddenGifView];
        
    }];
    
}

-(void)NavcreateRightbutton
{
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightBtn addTarget:self action:@selector(ClickMore) forControlEvents:UIControlEventTouchUpInside];
    
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    
    [rightBtn setImage:[UIImage imageNamed:@"more-white"] forState:UIControlStateNormal];
    
    [rightBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
    
    self.pl_navigationItem.rightBarButtonItem = [[PLBarButtonItem alloc] initWithCustomView:rightBtn];
}

-(void)ClickMore
{
    [PLGlobalClass aletWithTitle:@"点击了产品更多" Message:nil sureTitle:@"确定" CancelTitle:@"取消" SureBlock:^{
        
    } andCancelBlock:^{
        
    } andDelegate:self];
}

#pragma mark --发布产品
-(void)createProductManagerTableView
{
    
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-64) style:UITableViewStylePlain];
    
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset: UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins: UIEdgeInsetsZero];
    }
    
    
    // self.tableView.scrollEnabled =NO;
    
//    self.tableView.lee_theme.LeeConfigBackgroundColor([Theme themeBGColor]);
    
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator   = NO;
    
//    self.tableView.lee_theme.LeeConfigSeparatorColor([Theme themeLineUnObviousColor]);
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ManagerCell" bundle:nil] forCellReuseIdentifier:@"ManagerCell"];
    
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
    
    return 110;
}
/***********************UITableViewDatasoure**********************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.productArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.productArr.count >0) {
        
        _productModel =self.productArr[indexPath.row];
    }
    
    ManagerCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ManagerCell" forIndexPath:indexPath];
    
//    cell.lee_theme.LeeConfigBackgroundColor([Theme themeItemBGColor]);
//    cell.contentView.lee_theme.LeeConfigBackgroundColor([Theme themeItemBGColor]);
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
//    cell.selectedBackgroundView.lee_theme.LeeConfigBackgroundColor([Theme themeSelectedBGColor]);
    
    
    [cell.shelvesButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.shelvesButton.tag =1+indexPath.row;
    
    [cell setModelWithProductModel:_productModel];
    
    return cell;
}

-(void)clickButton:(UIButton *)button
{
    NSInteger index = button.tag;
    
    _productModel =[self.productArr objectAtIndex:index];
    
    NSString *session =[LOGIN_USER loginGetSessionModel].session_asd;

    NSString *flag =[_productModel.flag isEqualToString:@"1100"]?@"1":@"0";

    
    __weak typeof(self)weakSelf = self;
    
    
    NetworkParameter *parModel =[[NetworkParameter alloc]init];
    parModel.parameter =@{@"uid":_productModel.uuid,
                          @"asd":session,
                          @"flag":flag,
                          };
    [NetService POST_NetworkParameter:parModel url:Sellercommit_productupdate successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * responseStr =responseObject[@"status"];
        
        if ([responseStr isEqualToString:@"OK"])
        {
            [WFHudView  showMsg:@"修改成功" inView:weakSelf.view];
            
            [button setTitle:[flag isEqualToString:@"0"]?@"上架":@"下架" forState:UIControlStateNormal];
            
            //    [button setTitle:[button.titleLabel.text isEqualToString:@"下架"]?@"上架":@"下架" forState:UIControlStateNormal];
            
            //                if ([_productModel.flag isEqualToString:@"1100"]) {
            //
            //                    [button setTitle:@"上架1" forState:UIControlStateNormal];
            //
            //                }else if ([_productModel.flag isEqualToString:@"1101"])
            //                {
            //                    [button setTitle:@"下架1" forState:UIControlStateNormal];
            //
            //                }else
            //                {
            //                    [button setTitle:@"暂定" forState:UIControlStateNormal];
            //                }
            
            
        }else
        {
            NSString *backStr = [PLHttpTool StateTo:responseStr];
            
            [WFHudView  showMsg:backStr inView:weakSelf.view];
        }
        
        //   [weakSelf.tableView reloadData];
        
//        HIDENHUD;
        
        
    } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [WFHudView  showMsg:@"出错了" inView:weakSelf.view];
        
    }];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
}

#pragma mark --懒加载数组
-(NSMutableArray *)productArr{
    if (!_productArr) {
        _productArr =[NSMutableArray array];
    }
    return _productArr;
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
