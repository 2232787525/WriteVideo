//
//  NewStoreVC.m
//  PlamLive
//
//  Created by Mac on 16/12/2.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "NewStoreVC.h"

#import "StoreClassModel.h"

#import "StoreCell.h"
#import "PickerCell.h"
#import "SelectAlert.h"
#import "UWDatePickerView.h"
#import "PLReleaseBabyVC.h"
//地图相关
//#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
//#import "JZLocationConverter.h"

#import "PLLocationManager.h"
#import "PLTools.h"
#import "MyStoreVC.h"

@interface NewStoreVC ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UWDatePickerViewDelegate,MAMapViewDelegate,AMapLocationManagerDelegate>
{
    UWDatePickerView *_pikerView;
    MAMapView *_mapView;
    CLGeocoder *_geocoder;
}

@property (nonatomic,weak)StoreClassModel *classModel;

@property (nonatomic,strong) UITableView *tableView;

//各界面button
@property (nonatomic,strong) UIButton *logoButton;
@property (nonatomic,strong) UIButton *photoButton;
@property (nonatomic,strong) UIButton *UploadButton;
@property (nonatomic,strong) UIButton *leftButton;

@property (nonatomic,strong) UIView *mapView;
@property (nonatomic,strong) UILabel *mapLabel;

//图片数组
@property (nonatomic,strong)NSMutableArray *imageArr;
//店铺分类数组
@property (nonatomic,strong)NSMutableArray *StoreClassArr;
//店铺了id数组
@property (nonatomic,strong)NSMutableArray *ClassidArr;
//接收id
@property (nonatomic,weak)NSString *Classid;

//创建成功后返回
@property (nonatomic,weak)NSString *datauuid;
//地图属性
@property (nonatomic, strong) MAPointAnnotation *pointAnnotaiton;

@property (nonatomic, strong) AMapLocationManager *locationManager;

//自带地图定位
@property(nonatomic,strong)CLLocation * requestLocation;

@end

@implementation NewStoreVC

@synthesize pointAnnotaiton = _pointAnnotaiton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pl_navigationItem.title = @"新建店铺";
    self.pl_navigationItem.titleColor = [UIColor whiteColor];
    self.view.lee_theme.LeeConfigBackgroundColor([Theme themeBGColor]);
    
    
    [self parseDateStoreClass];
    
    [self createNavLeftButton];
    
    [self createStoreTableView];

    self.nextStepbutton.layer.cornerRadius =10;
    self.nextStepbutton.layer.masksToBounds =YES;    
    self.nextStepbutton.tag =401;
    [self.nextStepbutton setBackgroundColor:[UIColor colorWithRed:1/255.f green:154/255.f blue:228/254.f alpha:1]];
    [self.nextStepbutton addTarget:self action:@selector(uploadLogoNext) forControlEvents:UIControlEventTouchUpInside];
    
}
//请求店铺分类列表
-(void)parseDateStoreClass
{
  
    __weak typeof(self)weakSelf = self;
    
    NetworkParameter *parModel =[[NetworkParameter alloc]init];
    parModel.parameter =@{@"dtdi":@"5"};
    
    [NetService GET_NetworkParameter:parModel url:Dict_listbytype successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSArray class]])
        {
            NSArray * responseObjectArray = responseObject;
            
            NSMutableArray *testArr =[StoreClassModel mj_objectArrayWithKeyValuesArray:responseObjectArray];
            
            for (_classModel in testArr)
            {
                //名字数组
                [weakSelf.StoreClassArr addObject:_classModel.dictname];
                //id数组
                [weakSelf.ClassidArr addObject:_classModel.id];
            }
            
        }
        
        [weakSelf.tableView reloadData];
        
    } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [WFHudView showMsg:@"出错了" inView:weakSelf.view];
        
    }];
    
}

//下一步点击事件
-(void)uploadLogoNext
{
    //开始时间
    UIButton *startBtn =(id)[self.view viewWithTag:301];
    //结束时间
    UIButton *stopBtn =(id)[self.view viewWithTag:302];
    //店铺名称
    UITextField *name =(id)[self.view viewWithTag:1000];
    //营业地址
    UITextField *address =(id)[self.view viewWithTag:1001];
    //店铺分类
    UITextField *class =(id)[self.view viewWithTag:2001];
    //电话
    UITextField *telePhone =(id)[self.view viewWithTag:1004];
    //简介
    UITextField *introduce =(id)[self.view viewWithTag:1005];
    
    if (self.nextStepbutton.tag ==401) {
        
        if (name.text.length >0 && address.text.length >0 && class.text.length >0 && telePhone.text.length >0 && introduce.text.length >0 && ![startBtn.titleLabel.text isEqual:@"起始"] && ![stopBtn.titleLabel.text isEqual:@"结束"]) {

            self.tableView.hidden =YES;
             self.leftButton.hidden =YES;
            
            [self createLoGo];
            self.StoreinformationImage.image =[UIImage imageNamed:@"Thehook"];
            self.logoImage.image =[UIImage imageNamed:@"uploadlogo_s"];
            self.nextStepbutton.tag =402;
            
        }else
        {
            [WFHudView showMsg:@"输入完整的信息" inView:self.view];
        }
        
    }else if (self.nextStepbutton.tag ==402)
    {
        self.logoButton.hidden =YES;

        [self createPhoto];
        self.logoImage.image =[UIImage imageNamed:@"Thehook"];
        self.StorephotoImage.image =[UIImage imageNamed:@"Storephoto_s"];
        self.nextStepbutton.tag =403;
        
    }else if (self.nextStepbutton.tag ==403)
    {
        self.photoButton.hidden =YES;
        self.UploadButton.hidden =YES;
        [self.nextStepbutton setTitle:@"完成" forState:UIControlStateNormal];
        
        [self.nextStepbutton addTarget:self action:@selector(completeUpload) forControlEvents:UIControlEventTouchUpInside];

        [self createpostitioning];
        self.StorephotoImage.image =[UIImage imageNamed:@"Thehook"];
        self.positionimgImage.image =[UIImage imageNamed:@"positionimgImage_s"];
        self.nextStepbutton.tag =404;
    }else
    {
        self.nextStepbutton.tag =404;
        self.nextStepbutton.hidden =YES;
        self.mapView.hidden =YES;
        self.mapLabel.hidden =YES;
        self.leftButton.hidden =YES;
        
        [self createcomplete];
        self.positionimgImage.image =[UIImage imageNamed:@"Thehook"];
    }

}
//完成的点击 上传 事件
-(void)completeUpload
{
    __weak typeof(self)weakSelf = self;
    [[PLLocationManager shareLocatonManager] locationGetSingleOnceLocation:^(PLCoordinate *coor) {
        weakSelf.requestLocation = [[CLLocation alloc] initWithLatitude:coor.latitude longitude:coor.longitude];
        [weakSelf requestForcompleteWithLocation: weakSelf.requestLocation];
    }];
}


-(void)requestForcompleteWithLocation:(CLLocation *)location
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    /*
     uuid, String, 商铺唯一标识
     type, int, 商铺类型
     sellername, String, 商铺名称
     address, String, 地址
     tele, String, 电话
     lati, Double, 维度
     lon, String, 经度l
     opents, String, 开业时间
     closets, String, 结业时间
     introduction, String, 简介
     asd, String, sessionid
     logo, file, 商铺logo
     imgfile, file, 商铺实景图片
     */
    
    //开始时间
    UIButton *startBtn =(id)[self.view viewWithTag:301];
    NSString *start =[NSString stringWithFormat:@"%@ %@",@"2016-1-1",startBtn.titleLabel.text];
    NSString *startDate =  [PLTools transTotimeSp:start];
    
    //结束时间
    UIButton *stopBtn =(id)[self.view viewWithTag:302];
    NSString *stop =[NSString stringWithFormat:@"%@ %@",@"2016-1-1",stopBtn.titleLabel.text];
    NSString *stopDate  = [PLTools transTotimeSp:stop];
    
    UITextField *name =(id)[self.view viewWithTag:1000];
    UITextField *address =(id)[self.view viewWithTag:1001];
    UITextField *class =(id)[self.view viewWithTag:2001];
    UITextField *telePhone =(id)[self.view viewWithTag:1004];
    UITextField *introduce =(id)[self.view viewWithTag:1005];
    
    NSString *lati = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    NSString *lon = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    
    NSString *session = [LOGIN_USER loginGetSessionModel].session_asd;
    
    NSString *url =[NSString stringWithFormat:@"%@%@",Url_header,Sellercommit_submit];
    
    NSDictionary *dicUrl =@{@"uuid":@"",
                            @"asd":(session.length>0?session:@""),
                            @"type":self.Classid,
                            @"sellername":name.text,
                            @"address":address.text,
                            @"tele":telePhone.text,
                            @"opents":startDate,
                            @"closets":stopDate,
                            @"introduction":introduce.text,
                            @"lati":lati,
                            @"lon":lon,
                            };

    //公共参数获取
    NSDictionary *cmpmsDic =[PLHttpTool parmsPost];
    
    //可变字典  接受公共参数 + 经纬度
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [params setValuesForKeysWithDictionary:cmpmsDic];
    
    [params setObject:lati forKey:@"lati"];
    
    [params setObject:lon forKey:@"lon"];
    
    //可变字典  带经纬度的公共参数 + 一般参数
    NSMutableDictionary *paramsDic =[NSMutableDictionary dictionaryWithCapacity:0];
    
    [paramsDic setValuesForKeysWithDictionary:dicUrl];
    
    [paramsDic setObject:cmpmsDic forKey:@"cmpms"];
    
    
    
    //获取字典转字符串后的字符串
    NSString *dicStr =[PLHttpTool dictionaryToJson:paramsDic];
    
    //字符串base64编码
    NSString *encodeStr =[PLHttpTool base64EncodeString:dicStr];
    
    //获取时间戳
    NSString *timeStr = [PLHelp timestamp];
    
    NSString *urlzfyEncode =[PLHttpTool encodeToPercentEscapeString:encodeStr];
    
    
    NSString *url2 =[NSString stringWithFormat:@"%@",url];
    
    NSDictionary *zfyDic =@{@"zfy":urlzfyEncode,
                            @"ts":timeStr,
                            };
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [PLHttpTool registerRequestHeader:manager];
    
    manager.requestSerializer.timeoutInterval =60.0f;
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",nil];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [manager POST:url2 parameters:zfyDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //上传的图片数据
        NSData *imageData =UIImagePNGRepresentation(self.imageArr[0]);
        //上传的图片数据
        NSData *imageData1 =UIImagePNGRepresentation(self.imageArr[1]);
        
        [formData appendPartWithFileData:imageData name:@"imgfile" fileName:@"imgfileImg.png" mimeType:@"image/png"];
        
        [formData appendPartWithFileData:imageData1 name:@"logo" fileName:@"logoImg.png" mimeType:@"image/png"];
        

    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [WFHudView showMsg:@"创建成功" inView:self.view];
        self.datauuid =responseObject[@"data"];
//        [center postNotificationName:@"data" object:nil userInfo:@{@"data":self.datauuid}];
        SellerModel *model = [[SellerModel alloc] init];
        model.uuid = responseObject[@"data"];
        [LOGIN_USER loginCreateStoreSuccess:model];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [WFHudView showMsg:@"创建失败" inView:self.view];
    }];
    
}


//导航取消按钮
-(void)createNavLeftButton
{
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake(0,0,30,44);
    [self.leftButton setTitle:@"取消" forState:UIControlStateNormal];
    self.leftButton.titleLabel.font =[UIFont systemFontOfSize:13];
    
    [self.leftButton addTarget:self action:@selector(goBackTo) forControlEvents:UIControlEventTouchUpInside];
    
    self.pl_navigationItem.leftBarButtonItem = [[PLBarButtonItem alloc] initWithCustomView:self.leftButton];
    
    [self.leftButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
}
//取消点击事件
-(void)goBackTo
{
    if (self.nextStepbutton.tag ==401) {
        [self.navigationController popViewControllerAnimated:YES];
        self.nextStepbutton.tag =402;
    }else if (self.nextStepbutton.tag ==402)
    {
        self.UploadButton.hidden =YES;
        self.logoButton.hidden =YES;
        
        self.tableView.hidden =NO;
        
        self.logoImage.image =[UIImage imageNamed:@"uploadlogo_n"];
        self.StoreinformationImage.image =[UIImage imageNamed:@"Storeinformation_n"];
        self.nextStepbutton.tag =401;
        
    }else if (self.nextStepbutton.tag ==403)
    {
        self.UploadButton.hidden =NO;
        self.logoButton.hidden =NO;
        
        self.photoButton.hidden =YES;
        
        self.StorephotoImage.image =[UIImage imageNamed:@"Storephoto_n"];
        self.logoImage.image =[UIImage imageNamed:@"uploadlogo_s"];
        
        self.nextStepbutton.tag =402;
    }else
    {
        self.photoButton.hidden =NO;
        self.UploadButton.hidden =NO;
        
        self.mapView.hidden =YES;
        self.mapLabel.hidden =YES;
        
        self.positionimgImage.image =[UIImage imageNamed:@"positionimgImage_n"];
        self.StorephotoImage.image =[UIImage imageNamed:@"Storephoto_s"];
        
        [self.nextStepbutton setTitle:@"下一步" forState:UIControlStateNormal];
        self.nextStepbutton.tag =403;
       
    }
}


#pragma mark --创建店铺信息 TableView
-(void)createStoreTableView
{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(10, 162, KScreenWidth-20, KScreenHeight-162-116) style:UITableViewStylePlain];
    
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
  
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset: UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins: UIEdgeInsetsZero];
    }
    
    
    self.tableView.layer.borderColor = [[UIColor colorWithRed:222/255.f green:222/255.f blue:222/255.f alpha:1] CGColor];
    
   // self.tableView.layer.borderColor =[[UIColor blackColor]CGColor];
    self.tableView.layer.borderWidth = 1;
    
    self.tableView.scrollEnabled =NO;
    
    self.tableView.lee_theme.LeeConfigBackgroundColor([Theme themeBGColor]);
    
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator   = NO;
    
    self.tableView.lee_theme.LeeConfigSeparatorColor([Theme themeLineUnObviousColor]);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreCell" bundle:nil] forCellReuseIdentifier:@"StoreCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PickerCell" bundle:nil] forCellReuseIdentifier:@"PickerCell"];
    
    
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
  
    return 48;
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
    
    
    if (indexPath.row ==3)
    {
        PickerCell *cell =[tableView dequeueReusableCellWithIdentifier:@"PickerCell" forIndexPath:indexPath];
        
        cell.lee_theme.LeeConfigBackgroundColor([Theme themeItemBGColor]);
        cell.contentView.lee_theme.LeeConfigBackgroundColor([Theme themeItemBGColor]);
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.lee_theme.LeeConfigBackgroundColor([Theme themeSelectedBGColor]);
        
        switch (indexPath.row) {
            
            case 3:
                cell.timelabel.text =@"营业时间";
                [cell.startbutton setTitle:@"起始" forState:UIControlStateNormal];
                [cell.startbutton addTarget:self action:@selector(startDateClick) forControlEvents:UIControlEventTouchUpInside];
                cell.startbutton.tag =301;
                [cell.stopbutton setTitle:@"结束" forState:UIControlStateNormal];
                [cell.stopbutton addTarget:self action:@selector(endDateClick) forControlEvents:UIControlEventTouchUpInside];
                cell.stopbutton.tag =302;
                break;
                
            default:
                break;
        }
        
        return cell;
        
    }else
    {
        StoreCell *cell =[tableView dequeueReusableCellWithIdentifier:@"StoreCell" forIndexPath:indexPath];
        
        cell.lee_theme.LeeConfigBackgroundColor([Theme themeItemBGColor]);
        cell.contentView.lee_theme.LeeConfigBackgroundColor([Theme themeItemBGColor]);
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.lee_theme.LeeConfigBackgroundColor([Theme themeSelectedBGColor]);
        
        switch (indexPath.row) {
            case 0:
                cell.Storenlabel.text =@"店铺名称";
                cell.Storefeiled.placeholder=@"请输入店铺名称";
                cell.Storefeiled.tag =1000;
                break;
            case 1:
                cell.Storenlabel.text =@"营业地址";
                cell.Storefeiled.placeholder=@"请输入营业地址";
                cell.Storefeiled.tag =1001;
                break;
            case 2:
                cell.Storenlabel.text =@"店铺分类";
                cell.Storefeiled.userInteractionEnabled =NO;
                cell.Storefeiled.tag =2001;
                cell.Storefeiled.placeholder=@"请选择店铺类别";
                break;
            case 4:
                cell.Storenlabel.text =@"营业电话";
                cell.Storefeiled.placeholder=@"请输入营业电话";
                cell.Storefeiled.tag =1004;
                cell.Storefeiled.keyboardType =UIKeyboardTypeNumberPad;
                break;
            case 5:
                cell.Storenlabel.text =@"店铺简介";
                cell.Storefeiled.placeholder=@"请输入店铺简介";
                cell.Storefeiled.tag =1005;
                break;
                
            default:
                break;
        }
        
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 2:
            [self StoreClass];
            break;
        case 3:
         //   [self showPickertime];
            break;
        default:
            break;
    }
}

-(void)StoreClass
{
    
    [SelectAlert showWithTitle:@"选择你的店铺类型" titles:self.StoreClassArr selectIndex:^(NSInteger selectIndex) {
        
        self.Classid =_ClassidArr[selectIndex];
        
        
    } selectValue:^(NSString *selectValue) {
        
        UITextField *storeclass =(id)[self.view viewWithTag:2001];
        storeclass.text =selectValue;
       
    } showCloseButton:YES];
}

#pragma mark --时间选择器
//开始点击
-(void)startDateClick
{
    [self setupDateView:DateTypeOfStart];
}
//结束点击
-(void)endDateClick
{
    [self setupDateView:DateTypeOfEnd];
}

- (void)setupDateView:(DateType)type {
    
    _pikerView = [UWDatePickerView instanceDatePickerView];
    _pikerView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight + 20);
    [_pikerView setBackgroundColor:[UIColor clearColor]];
    _pikerView.delegate = self;
    _pikerView.type = type;
    [self.view addSubview:_pikerView];
    
}

//时间赋值
- (void)getSelectDate:(NSString *)date type:(DateType)type {
    NSLog(@"%d - %@", type, date);
    
    UIButton *startBtn =(id)[self.view viewWithTag:301];
    UIButton *stopBtn =(id)[self.view viewWithTag:302];
    
    switch (type) {
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

#pragma mark -- 上传logo
-(void)createLoGo
{
    self.logoButton =[UIButton buttonWithType:UIButtonTypeCustom];
    self.logoButton.frame =CGRectMake(KScreenWidth/2-90, 223, 180, 180);
    
    
    [self.logoButton setBackgroundImage:[UIImage imageNamed:@"uploadlogo"] forState:UIControlStateNormal];
    [self.logoButton addTarget:self action:@selector(chickUplogo) forControlEvents:UIControlEventTouchUpInside];
    self.logoButton.tag =4002;
    
    [self.view addSubview:self.logoButton];

    
    self.UploadButton =[UIButton buttonWithType:UIButtonTypeCustom];
    self.UploadButton.frame =CGRectMake(KScreenWidth/2-30, KScreenHeight -40, 60, 20);
    self.UploadButton.titleLabel.font =[UIFont systemFontOfSize:13];
    [self.UploadButton setTitleColor:[UIColor colorWithRed:1/255.f green:154/255.f blue:228/254.f alpha:1] forState:UIControlStateNormal];
    [self.UploadButton setTitle:@"稍后上传" forState:UIControlStateNormal];
    
    [self.UploadButton addTarget:self action:@selector(skipUp) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.UploadButton];
}
//稍后上传点击
-(void)skipUp
{
    if (self.nextStepbutton.tag ==402)
    {
        self.logoButton.hidden =YES;
        [self createPhoto];
        self.logoImage.image =[UIImage imageNamed:@"Thehook"];
        self.StorephotoImage.image =[UIImage imageNamed:@"Storephoto_s"];
        self.nextStepbutton.tag =403;
        
    }else if (self.nextStepbutton.tag ==403)
    {
        self.photoButton.hidden =YES;
        self.UploadButton.hidden =YES;
        [self.nextStepbutton setTitle:@"完成" forState:UIControlStateNormal];
        
        [self.nextStepbutton addTarget:self action:@selector(completeUpload) forControlEvents:UIControlEventTouchUpInside];
        
        [self createpostitioning];
        self.StorephotoImage.image =[UIImage imageNamed:@"Thehook"];
        self.positionimgImage.image =[UIImage imageNamed:@"positionimgImage_s"];
        self.nextStepbutton.tag =404;
    }
}

-(void)chickUplogo
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
    
    [self.imageArr addObject:image];

    UIButton *logoBtn =(id)[self.view viewWithTag:4002];
    [logoBtn setBackgroundImage:image forState:UIControlStateNormal];
    logoBtn.layer.cornerRadius =90;
    logoBtn.layer.masksToBounds =YES;
    logoBtn.userInteractionEnabled =NO;
    
    UIButton *photoBtn =(id)[self.view viewWithTag:4003];
    [photoBtn setBackgroundImage:image forState:UIControlStateNormal];
    photoBtn.layer.cornerRadius =20;
    photoBtn.layer.masksToBounds =YES;
    photoBtn.userInteractionEnabled =NO;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//取消选择
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 上传店铺照片
-(void)createPhoto
{
    self.photoButton =[UIButton buttonWithType:UIButtonTypeCustom];
    self.photoButton.frame =CGRectMake(KScreenWidth/2-110, KScreenHeight/2-60, 220, 140);
   
    [self.photoButton setBackgroundImage:[UIImage imageNamed:@"Storephoto"] forState:UIControlStateNormal];
    self.photoButton.tag =4003;
    
    [self.photoButton addTarget:self action:@selector(chickUplogo) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.photoButton];
}

#pragma mark -- 定位 地图
-(void)createpostitioning
{
    self.mapLabel =[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth/2-100,  KScreenHeight/2-90, 200, 20)];
    self.mapLabel.text =@"请在地图上确定您的位置";
    self.mapLabel.textColor =[UIColor colorWithRed:1/255.f green:154/255.f blue:228/254.f alpha:1];
    
    [self.view addSubview:self.mapLabel];
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(KScreenWidth/2-110, KScreenHeight/2-20, 220, 160)];
    
    _mapView.delegate = self;
    
    [self.view addSubview:_mapView];
    
    //设置地图类型
    _mapView.mapType=MAMapTypeStandard;
    
    //显示用户的位置
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode=MAUserTrackingModeFollow;//跟随用户移动
    
    [self configLocationManager];
    
    //开始定位
    [self.locationManager startUpdatingLocation];
    
    //设置每隔多少米定位一次
    self.locationManager.distanceFilter=1000.0f;
    // 设置定位精确度到米
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    //设置缩放
    [_mapView setZoomLevel:15.1 animated:YES];

    //后台定位
    _mapView.pausesLocationUpdatesAutomatically = NO;
    
    _mapView.allowsBackgroundLocationUpdates = NO;
    
    _mapView.showsScale = YES;
//    _mapView.scaleOrigin = CGPointMake(60, self.view.frame.size.height - 290);//比例尺的位置
    
    //地图手势
    _mapView.zoomEnabled = YES; //NO表示禁用手势
    //滑动手势
    _mapView.scrollEnabled = YES;
    
//    UIImageView * imageView= [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 20, 20)];
//    imageView.backgroundColor = [UIColor redColor];
//    [_mapView addSubview:imageView];
    
}

- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    
}

//点击蓝点跳出地理位置信息
-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    NSLog(@"%f",mapView.userLocation.coordinate.latitude);
    self.pointAnnotaiton = view.annotation;
    
    _geocoder = [[CLGeocoder alloc]init];
    
    CLLocation * location1 = [[CLLocation alloc]initWithLatitude:[JZLocationConverter gcj02ToWgs84:_mapView.userLocation.location.coordinate].latitude longitude:[JZLocationConverter gcj02ToWgs84:_mapView.userLocation.location.coordinate].longitude];
    [_geocoder reverseGeocodeLocation:location1 completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placemark=[placemarks firstObject];
        NSLog(@"详细信息:name = %@",placemark.name);
        
        self.pointAnnotaiton.title = placemark.name;
        self.pointAnnotaiton.subtitle = [NSString stringWithFormat:@"%@%@",placemark.locality,placemark.subLocality];
    }];
}

#pragma mark - AMapLocationManager Delegate

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    
    [_mapView setCenterCoordinate:location.coordinate];

// 定位一次 结束定位
    
//    [self.locationManager stopUpdatingLocation];
    
}

- (void)clearMapView
{
    _mapView.showsUserLocation = NO;
    
    [_mapView removeAnnotations:_mapView.annotations];
    
    [_mapView removeOverlays:_mapView.overlays];
    
    _mapView.delegate = nil;
}

#pragma mark --完成
-(void)createcomplete
{
    UIImageView *hookImageView =[[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth/2-60, KScreenHeight/2-100, 120, 120)];
    hookImageView.image =[UIImage imageNamed:@"complete"];
    
    [self.view addSubview:hookImageView];
    
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth/2-52.5, KScreenHeight/2+30, 105, 40)];
    label.text =@"店铺创建完成  您可以上传商品啦";
    label.numberOfLines = 2;
    label.textAlignment = NSTextAlignmentCenter;
    label.font =[UIFont systemFontOfSize:13];
    
    [self.view addSubview:label];
    
    UIButton *upStore =[UIButton buttonWithType:UIButtonTypeCustom];
    upStore.frame =CGRectMake(KScreenWidth/2-65, KScreenHeight-120, 130, 30);
    upStore.backgroundColor =[UIColor colorWithRed:1/255.f green:154/255.f blue:228/254.f alpha:1];
    [upStore setTitle:@"上传商品" forState:UIControlStateNormal];
    upStore.titleLabel.font =[UIFont systemFontOfSize:15];
    upStore.layer.cornerRadius =10;
    upStore.layer.masksToBounds =YES;
    
    [upStore handleEventTouchUpInsideWithBlock:^{
        PLReleaseBabyVC *releaseV =[[PLReleaseBabyVC alloc]init];
        [self.navigationController pushViewController:releaseV animated:YES];
    }];
    
    [self.view addSubview:upStore];
    
    UIButton *MyStore =[UIButton buttonWithType:UIButtonTypeCustom];
    MyStore.frame =CGRectMake(KScreenWidth/2-65, KScreenHeight-80, 130, 30);
    [MyStore setTitle:@"进入我的店铺" forState:UIControlStateNormal];
    [MyStore setTitleColor:[UIColor colorWithRed:1/255.f green:154/255.f blue:228/254.f alpha:1] forState:UIControlStateNormal];
    MyStore.titleLabel.font =[UIFont systemFontOfSize:15];
    
    [MyStore addTarget:self action:@selector(goMyStore) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:MyStore];
    
}
-(void)goMyStore
{
    MyStoreVC *storeV =[[MyStoreVC alloc]init];
    
    [self.navigationController pushViewController:storeV animated:YES];
}


#pragma mark --数组懒加载

- (NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [[NSMutableArray alloc]init];
    }
    return _imageArr;
}

- (NSMutableArray *)StoreClassArr{
    if (!_StoreClassArr) {
       _StoreClassArr  = [[NSMutableArray alloc]init];
    }
    return _StoreClassArr;
}

- (NSMutableArray *)ClassidArr{
    if (!_ClassidArr) {
        _ClassidArr  = [[NSMutableArray alloc]init];
    }
    return _ClassidArr;
}



-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    //开始定位
 //   [self.locationManager startUpdatingLocation];
    
    
    
//    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
//    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
//    pointAnnotation.title = @"方恒国际";
//    pointAnnotation.subtitle = @"阜通东大街6号";
//    
//    [_mapView addAnnotation:pointAnnotation];
    
    
}

-(void)dealloc{
    
    //移除监听者(通知)
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
    //退出  结束定位
    [self.locationManager stopUpdatingLocation];
    
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
