//
//  PLReleaseBabyVC.m
//  PlamLive
//
//  Created by Mac on 16/12/9.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "PLReleaseBabyVC.h"

#import "StoreCell.h"
#import "ProductCell.h"
#import "DescribeCell.h"


@interface PLReleaseBabyVC ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *ImageArr;

@end

@implementation PLReleaseBabyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pl_navigationItem.title = @"发布产品";
    self.pl_navigationItem.titleColor = [UIColor whiteColor];

//底部button
    [self createbottomButton];
//发布产品tableview
    [self createReleaseBabyTableView];
}
-(void)createbottomButton
{
    UIView *bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight-50, KScreenWidth, 50)];
//    bottomView.lee_theme.LeeConfigBackgroundColor([Theme themeBGColor]);
    [self.view addSubview:bottomView];
    
    UIButton *bottomLeftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    bottomLeftBtn.frame =CGRectMake(0, 0, KScreenWidth/2, 50);
    bottomLeftBtn.backgroundColor =[UIColor colorWithRed:25/255.f green:140/255.f blue:254/255.f alpha:1];
    [bottomLeftBtn setTitle:@"保存" forState:UIControlStateNormal];
    [bottomLeftBtn addTarget:self action:@selector(ProductSave) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:bottomLeftBtn];
    
    UIButton *bottomRightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    bottomRightBtn.frame=CGRectMake(KScreenWidth/2, 0, KScreenWidth/2, 50);
    bottomRightBtn.backgroundColor =[UIColor colorWithRed:240/255.f green:199/255.f blue:38/255.f alpha:1];
    [bottomRightBtn setTitle:@"发布" forState:UIControlStateNormal];
    [bottomRightBtn addTarget:self action:@selector(ReleaseProduct) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:bottomRightBtn];
    
}
//发布产品点击
-(void)ReleaseProduct
{
    UITextField *productname =(id)[self.view viewWithTag:4010];
    UITextField *attributes =(id)[self.view viewWithTag:4011];
    UITextField *brand =(id)[self.view viewWithTag:4012];
    UITextField *price =(id)[self.view viewWithTag:4013];
    UITextField *introduction =(id)[self.view viewWithTag:4014];

    __weak typeof(self)weakSelf = self;
    
    
    if (productname.text.length>0 && attributes.text.length>0 && brand.text.length >0 && price.text.length >0 && introduction.text.length >0 && self.ImageArr.count>0)
    {
        NSString *uuid =[LOGIN_USER loginGetResult].sellerModel.uuid;
        NSString *session =[LOGIN_USER loginGetSessionModel].session_asd;
        
        NetworkParameter *parModel =[[NetworkParameter alloc]init];
        parModel.parameter =@{@"uuid":@"",
                              @"seuid":uuid,
                              @"productname":productname.text,
                              @"price":price.text,
                              @"attributes":attributes.text,
                              @"introduction":introduction.text,
                              @"brand":brand.text,
                              @"asd":session,
                              @"flag":@"1",
                              };
        
        UIImage *image =self.ImageArr[0];
        //上传的图片数据
        NSData *imageData =UIImagePNGRepresentation(image);
        
        NSDictionary *dic =nil;
        
        NSMutableArray *ImgArr =[[NSMutableArray alloc]init];
        [ImgArr addObject:imageData];
      
        dic = @{@"imgfile":ImgArr};
      
         [self showGifView];
        [NetService POST_UpdateFilesNetworkParameter:parModel url:sellercommit_saveproduct withFileParameter:dic successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [weakSelf hiddenGifView];
            
            
            NSString * responseStr =responseObject[@"status"];
            
            if ([responseStr isEqualToString:@"OK"])
            {
                [WFHudView  showMsg:@"发布成功" inView:weakSelf.view];
                [weakSelf.navigationController popViewControllerAnimated:YES];
                
            }else
            {
                NSString *backStr = [PLHttpTool StateTo:responseStr];
                [WFHudView  showMsg:backStr inView:weakSelf.view];
                if ([responseStr isEqualToString:@"107"])
                {
                    [LOGIN_USER showLoginVCFromVC:self WithBackBlock:^(BOOL successBack, id modle) {
                        
                    }];
                }
                
            }
            
            
        } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [WFHudView  showMsg:@"发布失败" inView:weakSelf.view];
            
            [weakSelf hiddenGifView];
            
        }];
        
    }else
    {
        [WFHudView  showMsg:@"请输入完整的信息" inView:weakSelf.view];
        
    }

}
//产品保存
-(void)ProductSave
{
    UITextField *productname =(id)[self.view viewWithTag:4010];
    UITextField *attributes =(id)[self.view viewWithTag:4011];
    UITextField *brand =(id)[self.view viewWithTag:4012];
    UITextField *price =(id)[self.view viewWithTag:4013];
    UITextField *introduction =(id)[self.view viewWithTag:4014];
    
    __weak typeof(self)weakSelf = self;
    
    
    if (productname.text.length>0 && attributes.text.length>0 && brand.text.length >0 && price.text.length >0 && introduction.text.length >0 && self.ImageArr.count>0)
    {
    
        NSString *uuid =[LOGIN_USER loginGetResult].sellerModel.uuid;
    
        NSString *session =[LOGIN_USER loginGetSessionModel].session_asd;
    
        NetworkParameter *parModel =[[NetworkParameter alloc]init];
        parModel.parameter =@{@"uuid":@"",
                          @"seuid":uuid,
                          @"productname":productname.text,
                          @"price":price.text,
                          @"attributes":attributes.text,
                          @"introduction":introduction.text,
                          @"brand":brand.text,
                          @"asd":session,
                          @"flag":@"0",
                          };
    
        NSDictionary *dic =nil;
        
        UIImage *image =self.ImageArr[0];
        //上传的图片数据
        NSData *imageData =UIImagePNGRepresentation(image);
        
        NSMutableArray *imageArr =[[NSMutableArray alloc]init];
        
        [imageArr addObject:imageData];
        
        dic =@{@"imgfile":imageArr};
        [self showGifView];
        [NetService POST_UpdateFilesNetworkParameter:parModel url:sellercommit_saveproduct withFileParameter:dic successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [weakSelf hiddenGifView];
            
            NSString * responseStr =responseObject[@"status"];
            
            if ([responseStr isEqualToString:@"OK"])
            {
                [WFHudView  showMsg:@"保存成功" inView:weakSelf.view];
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
                
            }else
            {
                NSString *backStr = [PLHttpTool StateTo:responseStr];
                
                [WFHudView  showMsg:backStr inView:weakSelf.view];
                
                if ([responseStr isEqualToString:@"107"])
                {
                    [LOGIN_USER showLoginVCFromVC:self WithBackBlock:^(BOOL successBack, id modle) {
                        
                    }];
                }
                
            }

            
        } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [weakSelf hiddenGifView];
             [WFHudView  showMsg:@"保存失败" inView:weakSelf.view];
            
        }];
        
    }else
    {
        [WFHudView  showMsg:@"请输入完整的信息" inView:weakSelf.view];
        
    }
    

    
}
-(void)searchPagebackMystore
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --发布产品
-(void)createReleaseBabyTableView
{
    
    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 200)];
    headView.backgroundColor =[UIColor colorWithRed:222/255.f green:222/255.f blue:222/255.f alpha:1];
    
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(KScreenWidth/2-50, 50, 100, 100);
    [btn setImage:[UIImage imageNamed:@"headviewbutton"] forState:UIControlStateNormal];
    btn.tag =40100;
    [btn addTarget:self action:@selector(productPhoto) forControlEvents:UIControlEventTouchUpInside];

    [headView addSubview:btn];
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-64-50) style:UITableViewStyleGrouped];
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
    self.tableView.tableHeaderView =headView;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreCell" bundle:nil] forCellReuseIdentifier:@"StoreCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellReuseIdentifier:@"ProductCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DescribeCell" bundle:nil] forCellReuseIdentifier:@"DescribeCell"];
    
    [self.view addSubview:self.tableView];
}
-(void)productPhoto
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //相机
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //判断有无相机设备
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            //访问相机
            [self loadImageWithType:UIImagePickerControllerSourceTypeCamera];
        }
        else
        {
            [WFHudView  showMsg:@"未开启相机" inView:self.view];
        }
    }]];
    
    //相册
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //访问相册
        [self loadImageWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    }]];
    
    //取消
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    //推出视图控制器
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)loadImageWithType:(UIImagePickerControllerSourceType)type

{
    //实例化
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    //设置图片来源，相机或者相册
    picker.sourceType = type;
    //设置后续是否可编辑
    picker.allowsEditing = YES;
    //设置代理
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - 代理方法
//完成选择图片之后的回调,也就是点击系统自带的choose按钮之后调用的方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //获取选择的照片
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [self.ImageArr addObject:image];

    UIButton *productBtn =(id)[self.view viewWithTag:40100];
    [productBtn setImage:image forState:UIControlStateNormal];
    productBtn.userInteractionEnabled =NO;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//取消选择
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    if (indexPath.section ==0) {
        return 60;
    }else
    {
        return 150;
    }
}
/***********************UITableViewDatasoure**********************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 4;
    }else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0)
    {
        if (indexPath.row ==3) {
            ProductCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ProductCell" forIndexPath:indexPath];

//            cell.lee_theme.LeeConfigBackgroundColor([Theme themeItemBGColor]);
//            cell.contentView.lee_theme.LeeConfigBackgroundColor([Theme themeItemBGColor]);
            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
//            cell.selectedBackgroundView.lee_theme.LeeConfigBackgroundColor([Theme themeSelectedBGColor]);
            
            cell.Describelabel.text =@"价格";
            cell.InputTextfield.placeholder =@"请输入产品价格";
            cell.InputTextfield.keyboardType =UIKeyboardTypeNumberPad;
            //第四个界面 第0个cell 第一个按钮 第三个输入
            cell.InputTextfield.tag =4013;
            
            return cell;
        }else
        {
            StoreCell *cell =[tableView dequeueReusableCellWithIdentifier:@"StoreCell" forIndexPath:indexPath];
          //  cell.Storenlabel.lee_theme.LeeConfigTextColor(ThemeDarkTextColor);
          //  cell.Storefeiled.lee_theme.LeeConfigTextColor(ThemeDarkTextColor);
            
//            cell.lee_theme.LeeConfigBackgroundColor([Theme themeItemBGColor]);
//            cell.contentView.lee_theme.LeeConfigBackgroundColor([Theme themeItemBGColor]);
            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
//            cell.selectedBackgroundView.lee_theme.LeeConfigBackgroundColor([Theme themeSelectedBGColor]);
        
            cell.Storenlabel.textAlignment =NSTextAlignmentLeft;
            switch (indexPath.row) {
                case 0:
                    cell.Storenlabel.text =@"产品名称";
                    cell.Storefeiled.placeholder =@"请输入产品名称";
                    cell.Storefeiled.tag =4010;
                    break;
                case 1:
                    cell.Storenlabel.text =@"产品规格";
                    cell.Storefeiled.placeholder =@"请输入产品规格";
                    cell.Storefeiled.tag =4011;
                    break;
                    
                case 2:
                    cell.Storenlabel.text =@"品牌";
                    cell.Storefeiled.placeholder =@"请输入品牌";
                    cell.Storefeiled.tag =4012;
                    break;
                    
                default:
                    break;
            }
            return cell;
        }
        
    }else
    {
        DescribeCell *cell =[tableView dequeueReusableCellWithIdentifier:@"DescribeCell" forIndexPath:indexPath];
        
//        cell.lee_theme.LeeConfigBackgroundColor([Theme themeItemBGColor]);
//        cell.contentView.lee_theme.LeeConfigBackgroundColor([Theme themeItemBGColor]);
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
//        cell.selectedBackgroundView.lee_theme.LeeConfigBackgroundColor([Theme themeSelectedBGColor]);
        
        cell.productDescribe.text =@"产品描述";
        cell.producttextView.text =@"请输入产品描述";
        cell.producttextView.tag =4014;
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
}

- (NSMutableArray *)ImageArr{
    if (!_ImageArr) {
        _ImageArr  = [[NSMutableArray alloc]init];
    }
    return _ImageArr;
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
