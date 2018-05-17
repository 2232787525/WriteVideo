//
//  RealNameVC.m
//  PlamLive
//
//  Created by Mac on 17/1/19.
//  Copyright © 2017年 wangyadong. All rights reserved.
//

#import "RealNameVC.h"
#import "RealNameView.h"
#import "SelectAlert.h"
#import "StoreClassModel.h"

@interface RealNameVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)UIScrollView *scrollV;

@property (nonatomic,strong) UILabel *topLabel;
@property (nonatomic,strong) UILabel *centerLabel;
@property (nonatomic,strong) UIButton *imageButon;
@property (nonatomic,strong) UIButton *warningButton;
@property (nonatomic,strong) UILabel *bottomLabel;
@property (nonatomic,strong) UIButton *submitButton;
@property (nonatomic,strong) RealNameView *realnameV;
@property (nonatomic,strong) NSMutableArray *imageArr;

@property (nonatomic,strong)UIImage *submitImage;
@property (nonatomic,strong)NSString *storeStr;
@property (nonatomic,strong)NSString *propertyStr;

//分类数组
@property (nonatomic,strong)NSMutableArray *StoreClassArr;
//id数组
@property (nonatomic,strong)NSMutableArray *ClassidArr;
//接收id
@property (nonatomic,weak)NSString *Classid;
@property (nonatomic,weak)StoreClassModel *classModel;


@end

@implementation RealNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.pl_navigationItem.title = @"企业认证";
    self.pl_navigationItem.titleColor = [UIColor whiteColor];
    
    [self createNav];
    
    [self addScrollView];
    
    [self requestRealNameClass];
}

-(void)requestRealNameClass
{
    [self showGifView];
    
    NetworkParameter *parModel =[[NetworkParameter alloc]init];
    parModel.parameter =@{@"dtdi":@"20"};
    
    __weak typeof(self)weakSelf = self;
    
    [NetService GET_NetworkParameter:parModel url:Dict_listbytype successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [weakSelf hiddenGifView];
        
        if ([responseObject isKindOfClass:[NSArray class]])
        {
            NSArray * responseObjectArray = responseObject;
            
            NSMutableArray *testArr = [[NSMutableArray alloc]init];
            
            for (int i = 0; i<responseObjectArray.count; i++) {
                
                [testArr addObject:[StoreClassModel pl_initWithDictionary:[responseObjectArray objectAtIndex:i]]];
            }
            for (_classModel in testArr)
            {
                //名字数组
                [weakSelf.StoreClassArr addObject:_classModel.dictname];
                //id数组
                [weakSelf.ClassidArr addObject:_classModel.id];
            }
            
        }
        
        
    } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [weakSelf hiddenGifView];
        [WFHudView showMsg:@"出错了" inView:weakSelf.view];
        
    }];
}


-(void)createNav
{
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    rightBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    [rightBtn addTarget:self action:@selector(submitrealName) forControlEvents:UIControlEventTouchUpInside];
    self.pl_navigationItem.rightBarButtonItem = [[PLBarButtonItem alloc] initWithCustomView:rightBtn];
}
-(void)submitrealName
{
    __weak typeof(self)weakSelf = self;
    
    if (_realnameV.nameTextfileld.text.length==0 ) {
        [WFHudView  showMsg:@"请输入姓名" inView:self.view];
        return;
    }
    
    if ( _realnameV.phoneTextfield.text.length==0  ) {
        [WFHudView  showMsg:@"请输入手机号" inView:self.view];
        return;
    }
    
    if (_realnameV.cardTextfileld.text.length==0  ) {
        [WFHudView  showMsg:@"请输入证件号" inView:self.view];
        return;
    }
    
    if ( self.imageArr.count ==0 ) {
        [WFHudView  showMsg:@"请上传营业执照" inView:self.view];
        return;
    }
    
    if ( [PLHttpTool isCorrect:_realnameV.cardTextfileld.text] ==NO) {
        [WFHudView  showMsg:@"请输入正确的身份证号" inView:self.view];
        return;
    }
    
    if ([PLGlobalClass valiMobilePhone:_realnameV.phoneTextfield.text] ==  NO) {
        [WFHudView showMsg:@"请输入正确的手机号" inView:self.view];
        return ;
    }
    

    [self showGifView];

    NSString *session =[LOGIN_USER loginGetSessionModel].session_asd;
    
    NetworkParameter *parModel =[[NetworkParameter alloc]init];

    parModel.parameter =@{@"asd":session,
                          @"rn":_realnameV.nameTextfileld.text,
                          @"phe":_realnameV.phoneTextfield.text,
                          @"idcard":_realnameV.cardTextfileld.text,
                          @"type":weakSelf.Classid,
                          };
    
    NSDictionary *dic =nil;
    
    if (self.imageArr) {
        dic = @{@"imgfile":self.imageArr};
    }
    
    [NetService POST_UpdateFilesNetworkParameter:parModel url:userauthcommit_submit withFileParameter:dic successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        [weakSelf hiddenGifView];
        NSString * responseStr =responseObject[@"status"];
        if ([responseStr isEqualToString:@"OK"])
        {
            [WFHudView  showMsg:@"提交成功" inView:weakSelf.view];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NoticeSignSuccess object:nil];
            
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                
        }else
        {
            NSString *backStr = [PLHttpTool StateTo:responseStr];
            [WFHudView  showMsg:backStr inView:weakSelf.view];
            if ([responseStr isEqualToString:@"107"])
            {
                [WFHudView  showMsg:@"登录过期" inView:weakSelf.view];
                [LOGIN_USER showLoginVCFromVC:self WithBackBlock:^(BOOL successBack, id modle) {
                        
                }];
            }
        }
            
        } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [weakSelf hiddenGifView];
            [WFHudView  showMsg:@"出错了" inView:weakSelf.view];
            
        }];
    

}

-(void)addScrollView
{
    _scrollV =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-64)];
    _scrollV.backgroundColor =[UIColor PLColorContentBack];
    
    [self.view addSubview:_scrollV];
    
    _topLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 55)];
    _topLabel.text =@"完成实名认证获得更多特权";
    _topLabel.font =[UIFont systemFontOfSize:15];
    _topLabel.textColor =[UIColor PLColorBlack];
    _topLabel.textAlignment =NSTextAlignmentCenter;
    _topLabel.backgroundColor =[UIColor PLColorShare];
    
    [_scrollV addSubview:_topLabel];
    
    NSArray* nibView = [[NSBundle mainBundle] loadNibNamed:@"RealNameView" owner:nil options:nil];
    _realnameV = [nibView firstObject];
    _realnameV.frame =CGRectMake(0, _topLabel.bottom_sd, KScreenWidth, 176);
    
    __weak typeof(self)weakSelf = self;
    
    [_realnameV.classButton handleEventTouchUpInsideWithBlock:^{
        
        [SelectAlert showWithTitle:@"选择你的圈子类型" titles:self.StoreClassArr selectIndex:^(NSInteger selectIndex) {
            weakSelf.Classid =_ClassidArr[selectIndex];
            
        } selectValue:^(NSString *selectValue) {
            
            [_realnameV.classButton setTitle:selectValue forState:UIControlStateNormal];
            
            [_realnameV.classButton setTitleColor:[UIColor PLColorBlack] forState:UIControlStateNormal];
            
        } showCloseButton:YES];
        
    }];
    
    
    [_scrollV addSubview:_realnameV];
    
    _centerLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, _realnameV.bottom_sd, KScreenWidth, 55)];
    _centerLabel.text =@"营业执照";
    _centerLabel.font =[UIFont systemFontOfSize:15];
    _centerLabel.textColor =[UIColor PLColorBlack];
    _centerLabel.textAlignment =NSTextAlignmentCenter;
    _centerLabel.backgroundColor =[UIColor PLColorShare];
    
    [_scrollV addSubview:_centerLabel];
    
    _imageButon =[[UIButton alloc]initWithFrame:CGRectMake(15, _centerLabel.bottom_sd+20, KScreenWidth-30, (KScreenWidth-30)/2.0)];
    [_imageButon setImage:[UIImage imageNamed:@"Photo"] forState:UIControlStateNormal];
    _imageButon.backgroundColor =[UIColor PLColorShare];
    [_imageButon addTarget:self action:@selector(Uploadphotos) forControlEvents:UIControlEventTouchUpInside];
    _imageButon.tag =10;
    
    [_scrollV addSubview:_imageButon];
    
    _warningButton =[UIButton buttonWithType:UIButtonTypeCustom];
    _warningButton.frame =CGRectMake(15, _imageButon.bottom_sd+20, KScreenWidth-30, 30);
    [_warningButton setTitle:@"温馨提示" forState:UIControlStateNormal];
    _warningButton.titleLabel.font =[UIFont systemFontOfSize:14];
    [_warningButton setImage:[UIImage imageNamed:@"warning"] forState:UIControlStateNormal];
    _warningButton.titleEdgeInsets =UIEdgeInsetsMake(0, 10, 0, 0);
    [_warningButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _warningButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [_scrollV addSubview:_warningButton];
    
    _bottomLabel =[[UILabel alloc]initWithFrame:CGRectMake(15, _warningButton.bottom_sd, KScreenWidth-30, 50)];
    _bottomLabel.text =@"掌方圆不会再任何地方泄露您的信息，请放心认证";
    _bottomLabel.font =[UIFont systemFontOfSize:13];
    _bottomLabel.textColor =[UIColor PLColorGrayDark];
    _bottomLabel.numberOfLines =2;
    
    [_scrollV addSubview:_bottomLabel];
    
    
    if (_bottomLabel.bottom_sd+20 >= _scrollV.height_sd)
    {
        _scrollV.contentSize =CGSizeMake(KScreenWidth, _bottomLabel.bottom_sd+20);
    }

}

-(void)Uploadphotos
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

    
    _submitImage =image;
    
    NSData *imageData =UIImageJPEGRepresentation(image, 0.5);
    [self.imageArr addObject:imageData];
    
    UIButton *button =(id)[self.view viewWithTag:10];
    [button setImage:image forState:UIControlStateNormal];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//取消选择
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

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
