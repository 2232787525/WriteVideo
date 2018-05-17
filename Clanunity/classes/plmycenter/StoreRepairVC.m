//
//  StoreRepairVC.m
//  PlamLive
//
//  Created by Mac on 16/12/13.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "StoreRepairVC.h"
#import "DescribeCell.h"
#import "StoreCell.h"
#import "ProductCell.h"
#import "PickerCell.h"
#import "UWDatePickerView.h"
#import "UIImageView+EMWebCache.h"
#import "UIButton+EMWebCache.h"
#import "PLTools.h"
#import "PLLocationManager.h"

@interface StoreRepairVC ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UWDatePickerViewDelegate>
{
    UWDatePickerView *_pikerV;
}
@property (nonatomic,strong) UITableView *tableView;

//图片数组
@property (nonatomic,strong)NSMutableArray *imageArr;

@property (nonatomic,strong)NSMutableArray *logoArr;


//自带地图定位
@property(nonatomic,strong)CLLocation * requestLocation;

//文件图片
@property(nonatomic,strong)UIImage *imagefilePhoto;
//logo图片
@property(nonatomic,strong)UIImage *logoePhoto;

@property(nonatomic,weak)id sender;

@end

@implementation StoreRepairVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.pl_navigationItem.title = @"编辑店铺信息";
    self.pl_navigationItem.titleColor = [UIColor whiteColor];

//导航栏button
    [self navigationControllerButton];
//店铺信息tableview
    [self createStoreRepairTableView];
}


#pragma mark --导航按钮
-(void)navigationControllerButton
{
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    leftBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    [leftBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    self.pl_navigationItem.leftBarButtonItem = [[PLBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    rightBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
    self.pl_navigationItem.rightBarButtonItem = [[PLBarButtonItem alloc] initWithCustomView:rightBtn];
}
-(void)cancelClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//保存点击事件
-(void)saveClick
{
    __weak typeof(self)weakSelf = self;
    
    [[PLLocationManager shareLocatonManager] locationGetSingleOnceLocation:^(PLCoordinate *coor) {
        weakSelf.requestLocation = [[CLLocation alloc] initWithLatitude:coor.latitude longitude:coor.longitude];
        [weakSelf requestForcompleteWithLocation: weakSelf.requestLocation];
    }];

}
-(void)requestForcompleteWithLocation:(CLLocation *)location
{
    
    [self showGifView];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    NSString *url =[NSString stringWithFormat:@"%@%@",Url_header,Sellercommit_submit];

    NSString *uuid =[LOGIN_USER loginGetResult].sellerModel.uuid;
    NSString *session =[LOGIN_USER loginGetSessionModel].session_asd;
    
    UIButton *startBtn =(id)[self.view viewWithTag:1031];
    NSString *start =[NSString stringWithFormat:@"%@ %@",@"2016-1-1",startBtn.titleLabel.text];
    NSString *startDate =  [PLTools transTotimeSp:start];
    UIButton *stopBtn =(id)[self.view viewWithTag:1032];
    NSString *stop =[NSString stringWithFormat:@"%@ %@",@"2016-1-1",stopBtn.titleLabel.text];
    NSString *stopDate  = [PLTools transTotimeSp:stop];
    
    UITextField *storename =(id)[self.view viewWithTag:1011];
    UITextField *storeintroduction =(id)[self.view viewWithTag:1021];
    UITextField *storetele =(id)[self.view viewWithTag:1041];
    UITextField *storeaddress =(id)[self.view viewWithTag:1051];
    NSString *lati = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    NSString *lon = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
   
    NetworkParameter *parMdel =[[NetworkParameter alloc]init];
    parMdel.parameter =@{@"uuid":uuid,
                         @"asd":session,
                         @"type":self.repairUserModel.type,
                         @"sellername":storename.text,
                         @"address":storeaddress.text,
                         @"tele":storetele.text,
                         @"lati":lati,
                         @"lon":lon,
                         @"opents":startDate,
                         @"closets":stopDate,
                         @"introduction":storeintroduction.text,
                         };
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    if (self.imageArr.count > 0) {
        [dic setObject:self.imageArr forKey:@"imgfile"];
    }
    
    if (self.logoArr.count > 0) {
        [dic setObject:self.logoArr forKey:@"logo"];
    }
    __weak typeof(self)weakSelf = self;
    
    [NetService POST_UpdateFilesNetworkParameter:parMdel url:Sellercommit_submit withFileParameter:dic successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [weakSelf hiddenGifView];
        
        [WFHudView  showMsg:@"修改成功" inView:weakSelf.view];
        
        [center postNotificationName:@"Repair" object:nil];
        
        [self.navigationController popViewControllerAnimated:YES];

    } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [weakSelf hiddenGifView];
        
       [WFHudView  showMsg:@"修改成功" inView:weakSelf.view];
        
    }];
    
    
//    NSDictionary *dicUrl =@{@"uuid":uuid,
//                         @"asd":session,
//                         @"type":self.repairUserModel.type,
//                         @"sellername":storename.text,
//                         @"address":storeaddress.text,
//                         @"tele":storetele.text,
//                         @"lati":lati,
//                         @"lon":lon,
//                         @"opents":startDate,
//                         @"closets":stopDate,
//                         @"introduction":storeintroduction.text,
//                         };
//    //公共参数获取
//    NSDictionary *cmpmsDic =[PLHttpTool parmsPost];
//
//    //可变字典  带经纬度的公共参数 + 一般参数
//    NSMutableDictionary *paramsDic =[NSMutableDictionary dictionaryWithCapacity:0];
//    [paramsDic setValuesForKeysWithDictionary:dicUrl];
//    [paramsDic setObject:cmpmsDic forKey:@"cmpms"];
//    //获取字典转字符串后的字符串
//    NSString *dicStr =[PLHttpTool dictionaryToJson:paramsDic];
//    //字符串base64编码
//    NSString *encodeStr =[PLHttpTool base64EncodeString:dicStr];
//    //获取时间戳
//    NSString *timeStr = [PLHelp timestamp];
//    NSString *urlzfyEncode =[PLHttpTool encodeToPercentEscapeString:encodeStr];
//    NSString *url2 =[NSString stringWithFormat:@"%@",url];
//
//    NSDictionary *zfyDic =@{@"zfy":urlzfyEncode,
//                            @"ts":timeStr,
//                            };
//    
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    
//    [PLHttpTool registerRequestHeader:manager];
//    
//    manager.requestSerializer.timeoutInterval =60.0f;
//    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",nil];
//    
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    
//    [manager POST:url2 parameters:zfyDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        if (self.imageArr.count ==1 )
//        {
//            if (self.imagefilePhoto)
//            {
//                NSData *imgFileData =UIImageJPEGRepresentation(self.imagefilePhoto, 0.5);
//                [formData appendPartWithFileData:imgFileData name:@"imgfile" fileName:@"imgfileImg.png" mimeType:@"image/png"];
//            }else
//            {
//                NSData *logoDta =UIImagePNGRepresentation(self.logoePhoto);
//                [formData appendPartWithFileData:logoDta name:@"logo" fileName:@"logoImg.png" mimeType:@"image/png"];
//            }
//            
//        }else if (self.imageArr.count ==2)
//        {
//            NSData *imgFileData =UIImageJPEGRepresentation(self.imagefilePhoto, 0.5);
//            [formData appendPartWithFileData:imgFileData name:@"imgfile" fileName:@"imgfileImg.png" mimeType:@"image/png"];
//           
//            NSData *logoDta =UIImagePNGRepresentation(self.logoePhoto);
//            [formData appendPartWithFileData:logoDta name:@"logo" fileName:@"logoImg.png" mimeType:@"image/png"];
//        }else
//        {
//            
//        }
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        [WFHudView  showMsg:@"修改成功" inView:self.view];
//        
//        [center postNotificationName:@"Repair" object:nil];
//        
//        [self.navigationController popViewControllerAnimated:YES];
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        [WFHudView  showMsg:@"修改失败" inView:self.view];
//    }];
    
    
}
#pragma mark --店铺维修
-(void)createStoreRepairTableView
{
    UIView *topView =[[UIView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, 150)];
//    topView.lee_theme.LeeConfigBackgroundColor([Theme themeBGColor]);
    
    UIImageView *imageV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 130)];
    imageV.userInteractionEnabled =YES;
    [imageV sd_setImageWithURL:[NSURL URLWithString:self.repairUserModel.imgurl] placeholderImage:[UIImage imageNamed:PLACE_HEADIMG]];
    [topView addSubview:imageV];
    
    imageV.tag =1001;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chickUpphoto:)];
    [imageV addGestureRecognizer:tap];
    
    
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(KScreenWidth-140, topView.height_sd-80, 120, 80);
    btn.tag =1002;
    [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.repairUserModel.logo] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(chickUpphoto:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:btn];
    
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-64) style:UITableViewStylePlain];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset: UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins: UIEdgeInsetsZero];
    }
//  self.tableView.scrollEnabled =NO;
//    self.tableView.lee_theme.LeeConfigBackgroundColor([Theme themeBGColor]);
    self.tableView.tableHeaderView =topView;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator   = NO;
    
//    self.tableView.lee_theme.LeeConfigSeparatorColor([Theme themeLineUnObviousColor]);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreCell" bundle:nil] forCellReuseIdentifier:@"StoreCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellReuseIdentifier:@"ProductCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"PickerCell" bundle:nil] forCellReuseIdentifier:@"PickerCell"];
    
    [self.view addSubview:self.tableView];
}

-(void)chickUpphoto:(id)sender
{
    self.sender = sender;
    
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
   // [self.imageArr addObject:image];
    
    if ([self.sender isKindOfClass:[UIButton class]] && [(UIButton*)self.sender tag] == 1002 ) {
        self.logoePhoto=image;
        
        NSData *logoData =UIImageJPEGRepresentation(image, 0.5);
        [self.logoArr addObject:logoData];
        
        UIButton *logoBtn =(id)[self.view viewWithTag:1002];
        [logoBtn setBackgroundImage:image forState:UIControlStateNormal];
        logoBtn.userInteractionEnabled =NO;
    }else{
        self.imagefilePhoto =image;
        
        NSData *imageData =UIImageJPEGRepresentation(image, 0.5);
        [self.imageArr addObject:imageData];
        
        UIImageView *photoImage =(id)[self.view viewWithTag:1001];
        photoImage.image =image;
        photoImage.userInteractionEnabled =NO;
    }
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
    
    return 60;
}
/***********************UITableViewDatasoure**********************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *open =  [PLTools transToTime:self.repairUserModel.opentime];
    
    NSString *stop =  [PLTools transToTime:self.repairUserModel.closetime];
 
    if (indexPath.row ==2) {
        PickerCell *cell =[tableView dequeueReusableCellWithIdentifier:@"PickerCell" forIndexPath:indexPath];
        
//        cell.lee_theme.LeeConfigBackgroundColor([Theme themeItemBGColor]);
//        cell.contentView.lee_theme.LeeConfigBackgroundColor([Theme themeItemBGColor]);
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
//        cell.selectedBackgroundView.lee_theme.LeeConfigBackgroundColor([Theme themeSelectedBGColor]);
        
        [cell.startbutton  setTitle:open forState:UIControlStateNormal];
        cell.startbutton.tag =1031;
        [cell.startbutton addTarget:self action:@selector(DatestartClick) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.stopbutton  setTitle:stop forState:UIControlStateNormal];
        [cell.stopbutton addTarget:self action:@selector(DatestopClick) forControlEvents:UIControlEventTouchUpInside];
        cell.stopbutton.tag =1032;
        
        cell.timelabel.text =@"营业时间";
        return cell;
        
    }else if (indexPath.row ==5)
    {
        ProductCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ProductCell" forIndexPath:indexPath];
        
//        cell.lee_theme.LeeConfigBackgroundColor([Theme themeItemBGColor]);
//        cell.contentView.lee_theme.LeeConfigBackgroundColor([Theme themeItemBGColor]);
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
//        cell.selectedBackgroundView.lee_theme.LeeConfigBackgroundColor([Theme themeSelectedBGColor]);
        
        cell.Describelabel.text =@"营业定位";
        cell.InputTextfield.text =@"太原市小店区体育西路108号";
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =CGRectMake(0, 0, 25, 21);
        [button setBackgroundImage:[UIImage imageNamed:@"positionimgImage_n"] forState:UIControlStateNormal];
        [cell.iconLabel addSubview:button];
        
        return cell;

    }else
    {
        StoreCell *cell =[tableView dequeueReusableCellWithIdentifier:@"StoreCell" forIndexPath:indexPath];
        
//        cell.lee_theme.LeeConfigBackgroundColor([Theme themeItemBGColor]);
//        cell.contentView.lee_theme.LeeConfigBackgroundColor([Theme themeItemBGColor]);
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
//        cell.selectedBackgroundView.lee_theme.LeeConfigBackgroundColor([Theme themeSelectedBGColor]);
        
        switch (indexPath.row) {
            case 0:
                cell.Storenlabel.text =@"店铺名称";
                cell.Storefeiled.text =self.repairUserModel.sellername;
                cell.Storefeiled.tag =1011;
                break;
            case 1:
                cell.Storenlabel.text =@"店铺简介";
                cell.Storefeiled.text =self.repairUserModel.introduction;
                cell.Storefeiled.tag =1021;
                break;
            case 3:
                cell.Storenlabel.text =@"营业电话";
                cell.Storefeiled.text =self.repairUserModel.tele;
                cell.Storefeiled.keyboardType =UIKeyboardTypeNumberPad;
                cell.Storefeiled.tag =1041;
                break;
            case 4:
                cell.Storenlabel.text =@"营业地址";
                cell.Storefeiled.text =self.repairUserModel.address;
                cell.Storefeiled.tag =1051;
                break;
                
            default:
                break;
        }
        return cell;
    }
}
#pragma mark --时间选择器
//开始点击
-(void)DatestartClick
{
    [self setupDateView:DateTypeOfStart];
}
//结束点击
-(void)DatestopClick
{
    [self setupDateView:DateTypeOfEnd];
}

- (void)setupDateView:(DateType)type {
    
    _pikerV = [UWDatePickerView instanceDatePickerView];
    _pikerV.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight + 20);
    [_pikerV setBackgroundColor:[UIColor clearColor]];
    _pikerV.delegate = self;
    _pikerV.type = type;
    [self.view addSubview:_pikerV];
    
}
//时间赋值
- (void)getSelectDate:(NSString *)date type:(DateType)type {
    NSLog(@"%d - %@", type, date);

    UIButton *startBtn =(id)[self.view viewWithTag:1031];
    UIButton *stopBtn  =(id)[self.view viewWithTag:1032];
    
    switch (type)
    {
        case DateTypeOfStart:
            [startBtn setTitle:date forState:UIControlStateNormal];
            break;
            
        case DateTypeOfEnd:
            [stopBtn setTitle:date forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
}
-(void)dealloc{
    //移除监听者(通知)
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [[NSMutableArray alloc]init];
    }
    return _imageArr;
}
- (NSMutableArray *)logoArr{
    if (!_logoArr) {
        _logoArr = [[NSMutableArray alloc]init];
    }
    return _logoArr;
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
