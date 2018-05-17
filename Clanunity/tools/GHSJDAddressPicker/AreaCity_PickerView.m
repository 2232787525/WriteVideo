//
//  AreaCity_PickerView.m
//  Clanunity
//
//  Created by wangyadong on 2017/8/11.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

#import "AreaCity_PickerView.h"
#import "RXJDTableCell.h"
#import "RXJDButton.h"

#define ChooseHeight 39

@interface AreaCity_PickerView ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView * headerScroll;
@property(nonatomic,strong)UIScrollView * backScrollView;
@property(nonatomic,strong)NSMutableArray * showListArray;
@property(nonatomic,strong)NSMutableDictionary * showListDic;
@property(nonatomic,strong)UIButton * closeButton;
@property(nonatomic,strong)RXJDButton * chooseBtn;
@property(nonatomic,strong)UIView * sliderLine;
@property(nonatomic,strong)NSMutableArray<RXJDButton*> * chooseBtnArray;
    

@end


@implementation AreaCity_PickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self makeView];
        [self makefirstLevelView];
    }
    return self;
}
-(void)makeView{
    //标题
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, KScreenWidth, 20)];
    titleLabel.text = @"所在地区";
    titleLabel.font = [UIFont PLFont16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor =[UIColor PLColor33333];
    titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:titleLabel];
    
    //关闭
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(0, 0, 35, 35);
    closeBtn.right_sd = self.right_sd-5;
    closeBtn.centerY_sd = titleLabel.centerY_sd;
//    closeBtn.contentVerticalAlignment   = UIControlContentVerticalAlignmentBottom;
//    closeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [closeBtn setImage:[UIImage imageNamed:@"guanbianniu"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(clickedClose) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:closeBtn];
    self.closeButton = closeBtn;

    self.headerScroll = [self configScrollWithFrame:CGRectMake(0, titleLabel.bottom_sd+15,KScreenWidth, 40)];
    [self addSubview:self.headerScroll];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.headerScroll.bottom_sd, KScreenWidth, 0.5)];
    line.backgroundColor = [UIColor PLColorDFDFDF_Cutline];
    [self addSubview:line];
    
    self.sliderLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 1)];
    self.sliderLine.backgroundColor = [UIColor PLColor12B06B_Theme];
    self.sliderLine.hidden = NO;
    self.sliderLine.bottom_sd = self.headerScroll.height_sd;
    [self.headerScroll addSubview:self.sliderLine];
    self.backScrollView = [self configScrollWithFrame:CGRectMake(0, line.bottom_sd, KScreenWidth, self.height_sd-line.bottom_sd)];
    self.backScrollView.pagingEnabled = YES;
    [self addSubview:self.backScrollView];
}

-(void)makefirstLevelView{
    //需要创建新的tableView
    City_List_Model *newNextModel = [[City_List_Model alloc] init];
    newNextModel.index = 0;
    newNextModel.selectedIndex = -1;
    newNextModel.dataArray = [self getNewListWithFatherModel:nil];
    
    UITableView *newNextTab = [self makeTableView];
    newNextTab.left_sd = newNextModel.index*KScreenWidth;
    //        newNextTab.keyString = [NSString stringWithFormat:@"%@",@(newNextModel.index)];
    newNextTab.tag = 12306+newNextModel.index;
    newNextModel.tableView = newNextTab;

    newNextModel.chooseButton = [self makeButtonWithFrame:CGRectMake(12,0, 60, 39)];
    newNextModel.chooseButton.addressName = @"请选择";
    [newNextModel.chooseButton setTitleColor:[UIColor PLColor12B06B_Theme] forState:UIControlStateNormal];
    self.sliderLine.left_sd = newNextModel.chooseButton.left_sd;
    self.sliderLine.width_sd = newNextModel.chooseButton.width_sd;
    [self.headerScroll addSubview:newNextModel.chooseButton];
    self.headerScroll.contentSize = CGSizeMake(newNextModel.chooseButton.right_sd+20, self.headerScroll.height_sd);

    [self.showListDic setObject:newNextModel forKey:@(newNextTab.tag)];
    newNextModel.chooseButton.showKey =@(newNextTab.tag);
    [self.showListArray addObject:newNextModel];
    [self.backScrollView addSubview:newNextTab];
    self.backScrollView.contentSize = CGSizeMake(newNextTab.right_sd, self.backScrollView.height_sd);
    [self.backScrollView setContentOffset:CGPointMake(newNextTab.left_sd, 0) animated:YES];
    [newNextTab reloadData];
}

-(void)clickedClose{
    if (self.closeButtonBlock) {
        self.closeButtonBlock(nil,nil);
    }
}

- (UIScrollView *)configScrollWithFrame:(CGRect)frame{
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor clearColor];
    return scrollView;
}
-(UITableView*)makeTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,KScreenWidth,self.backScrollView.height_sd) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    //ios8
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    return tableView;
}

-(RXJDButton*)makeButtonWithFrame:(CGRect)frame{
    RXJDButton *btn = [[RXJDButton alloc] initWithFrame:frame];
    [btn setTitleColor:[UIColor PLColor12B06B_Theme] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont PLFont13];
    WeakSelf;
    [btn handleEventTouchUpInsideWithBlock:^{
        City_List_Model *tabModel = weakSelf.showListDic[btn.showKey];
        [weakSelf.backScrollView setContentOffset:CGPointMake(tabModel.tableView.left_sd, 0) animated:YES];
    }];
    return btn;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    City_List_Model *model = self.showListDic[@(tableView.tag)];
    return model.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [RXJDTableCell cell_Height];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    City_List_Model *model = self.showListDic[@(tableView.tag)];
    
    RXJDTableCell *cell = [tableView dequeueReusableCellWithIdentifier:model.cellIder];
    if (cell == nil) {
        cell = [[RXJDTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:model.cellIder];
    }
    City_List_Area_Model *areaModel = model.dataArray[indexPath.row];
    [cell setCellTitle:areaModel.name isSelected: indexPath.row==model.selectedIndex?YES:NO];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    City_List_Model *tabModel = self.showListDic[@(tableView.tag)];
    City_List_Area_Model *cellModel = tabModel.dataArray[indexPath.row];
    tabModel.chooseButton.addressName = cellModel.name;
    self.sliderLine.left_sd = tabModel.chooseButton.left_sd;
    self.sliderLine.width_sd = tabModel.chooseButton.width_sd;
    if (tabModel.index == 4) {//最后一级
        //点击完之后可以确定数据
        if (tabModel.selectedIndex != indexPath.row) {
            [self reloadCurrentTable:tabModel forSelectedIndex:indexPath];
        }
        [self getString];
        [self reloadHiddenTableWithCurrentTable:tabModel];

    }else if (tabModel.index == 0){//当前列表是 省级
        if (cellModel.children.count>0) {//展示 市级列表
            if (tabModel.selectedIndex != indexPath.row) {
                [self reloadCurrentTable:tabModel forSelectedIndex:indexPath];
                [self selectedTableModel:tabModel withIndexPath:indexPath];
            }else{
                [self reloadCurrentTable:tabModel showNextTableWithSelectedIndex:indexPath];
            }
            
        }
    }else if (tabModel.index == 1){//当前是 市级列表
        if (cellModel.children.count > 0) {//展示 县/区级列表
            if (tabModel.selectedIndex != indexPath.row) {
                [self reloadCurrentTable:tabModel forSelectedIndex:indexPath];
                [self selectedTableModel:tabModel withIndexPath:indexPath];
            }else{
                [self reloadCurrentTable:tabModel showNextTableWithSelectedIndex:indexPath];
            }
        }
        
    }else if (tabModel.index == 2){//当前是 县/区级列表
        //展示 社区列表
        if (tabModel.selectedIndex != indexPath.row) {
            [self reloadCurrentTable:tabModel forSelectedIndex:indexPath];
            //请求社区数据
            [self requestForCommunityWithCityModel:cellModel listReturn:^(NSArray<City_List_Area_Model *> *result) {
                if (result.count >0 ) {
                    cellModel.children = result;
                    [self selectedTableModel:tabModel withIndexPath:indexPath];
                }else{
                    //无数据，最后返回
                    [self getString];
                    [self reloadHiddenTableWithCurrentTable:tabModel];
                }
            }];
            
        }else{
            [self reloadCurrentTable:tabModel showNextTableWithSelectedIndex:indexPath];
        }

    }else if (tabModel.index == 3){//当前是 社区级列表
        //展示的是 小区列表--->最后一级列表
        if (tabModel.selectedIndex != indexPath.row) {//
            [self reloadCurrentTable:tabModel forSelectedIndex:indexPath];
            //请求小区数据
            [self requestForVillageWithCityModel:cellModel listReturn:^(NSArray<City_List_Area_Model *> *result) {
                if (result.count >0 ) {
                    cellModel.children = result;
                    [self selectedTableModel:tabModel withIndexPath:indexPath];
                }else{
                    //无数据，最后返回
                    [self getString];
                    [self reloadHiddenTableWithCurrentTable:tabModel];
                    
                }
            }];
        }else{
            //获取到最后一级数据
            [self reloadCurrentTable:tabModel showNextTableWithSelectedIndex:indexPath];
        }
    }
}
-(void)getString{
    NSMutableArray *idArray = [NSMutableArray arrayWithCapacity:0];
    NSMutableString *array = [NSMutableString stringWithCapacity:0];
    for (City_List_Model *tabModel in self.showListArray) {
        if (tabModel.selectedIndex != -1) {
            City_List_Area_Model *cellModel = tabModel.dataArray[tabModel.selectedIndex];
            [array appendString:cellModel.name];
            [idArray addObject:cellModel.code];
        }
    }
    NSLog(@"%@",array);
    if (self.closeButtonBlock) {
        self.closeButtonBlock(array,idArray);
    }
}
-(void)reloadHiddenTableWithCurrentTable:(City_List_Model *)tabModel{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.headerScroll.contentSize = CGSizeMake(tabModel.chooseButton.right_sd+20, self.headerScroll.height_sd);
        self.backScrollView.contentSize = CGSizeMake(tabModel.tableView.right_sd, self.backScrollView.height_sd);
        //把后面的table置空
        for (City_List_Model  *listModel in self.showListArray) {
            if (listModel.index>tabModel.index) {
                listModel.tableView.hidden = YES;
                listModel.selectedIndex = -1;
                listModel.dataArray = nil;
                [listModel.chooseButton removeFromSuperview];
                listModel.chooseButton = nil;
            }
        }
    });

}


/**当前table，选中的是跟之前选中的一样，展示下一级table 默认之前已有 */
-(void)reloadCurrentTable:(City_List_Model *)tabModel showNextTableWithSelectedIndex:(NSIndexPath*)indexPath{
    if (tabModel.selectedIndex == indexPath.row) {
        //展示下一级列表
        if (self.showListArray.count>tabModel.index+1) {
            City_List_Model *oldNextModel = self.showListArray[tabModel.index+1];
            //出现列表
            [self.backScrollView setContentOffset:CGPointMake(oldNextModel.tableView.left_sd, 0) animated:YES];
            //滑块到搭该按钮下
            self.sliderLine.left_sd = oldNextModel.chooseButton.left_sd;
            self.sliderLine.width_sd = oldNextModel.chooseButton.width_sd;
        }
    }
}
/**当前table，选中的是跟之前选中的不一样 刷新的cell */
-(void)reloadCurrentTable:(City_List_Model *)tabModel forSelectedIndex:(NSIndexPath*)indexPath{
    if (tabModel.selectedIndex != indexPath.row) {
        //选择了新的cell
        NSInteger tempIndex = tabModel.selectedIndex;
        tabModel.selectedIndex = indexPath.row;
        [tabModel.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        if (tempIndex != -1) {
            [tabModel.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:tempIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
        
        
        
        
    }
}

-(void)selectedTableModel:(City_List_Model *)tabModel withIndexPath:(NSIndexPath*)indexPath{
    if (tabModel.index >=self.showListArray.count-1) {//之前没有已经 创建好的下一级礼拜
        [self makeNewTableWithCurrentTableModel:tabModel forIndexPath:indexPath];
    }else{
        [self loadOldTableWithCurrentTableModel:tabModel forIndexPath:indexPath];
    }
}
/**创建新的TableModel */
-(void)makeNewTableWithCurrentTableModel:(City_List_Model*)tabModel forIndexPath:(NSIndexPath*)indexPath{
    City_List_Area_Model *cellModel = tabModel.dataArray[indexPath.row];
    
    //需要创建新的tableView
    City_List_Model *newNextModel = [[City_List_Model alloc] init];
    newNextModel.index = tabModel.index + 1;
    newNextModel.selectedIndex = -1;
    newNextModel.dataArray = [self getNewListWithFatherModel:cellModel];
    UITableView *newNextTab = [self makeTableView];
    newNextTab.left_sd = tabModel.tableView.right_sd;
    newNextTab.tag = 12306+newNextModel.index;
    newNextModel.tableView = newNextTab;
    newNextModel.chooseButton = [self makeButtonWithFrame:CGRectMake(tabModel.chooseButton.right_sd+30,0, 60, 39)];
    newNextModel.chooseButton.addressName = @"请选择";
    [newNextModel.chooseButton setTitleColor:[UIColor PLColor12B06B_Theme] forState:UIControlStateNormal];
    self.sliderLine.left_sd = newNextModel.chooseButton.left_sd;
    self.sliderLine.width_sd = newNextModel.chooseButton.width_sd;
    [self.headerScroll addSubview:newNextModel.chooseButton];
    self.headerScroll.contentSize = CGSizeMake(newNextModel.chooseButton.right_sd+20, self.headerScroll.height_sd);
    
    [self.showListDic setObject:newNextModel forKey:@(newNextTab.tag)];
    newNextModel.chooseButton.showKey =@(newNextTab.tag);
    [self.showListArray addObject:newNextModel];
    [self.backScrollView addSubview:newNextTab];
    self.backScrollView.contentSize = CGSizeMake(newNextTab.right_sd, self.backScrollView.height_sd);
    [self.backScrollView setContentOffset:CGPointMake(newNextTab.left_sd, 0) animated:YES];
    [newNextTab reloadData];
}
/**加载就的tableModel */
-(void)loadOldTableWithCurrentTableModel:(City_List_Model*)tabModel forIndexPath:(NSIndexPath*)indexPath{
    City_List_Area_Model *cellModel = tabModel.dataArray[indexPath.row];
    //不需要创建--在之前的View上刷新数据
    City_List_Model *oldNextModel = self.showListArray[tabModel.index+1];
    oldNextModel.tableView.hidden = NO;
    oldNextModel.dataArray =  [self getNewListWithFatherModel:cellModel];//拿到新的数组
    oldNextModel.selectedIndex = -1;//未选中
    [oldNextModel.chooseButton removeFromSuperview];
    oldNextModel.chooseButton = nil;
    oldNextModel.chooseButton = [self makeButtonWithFrame:CGRectMake(tabModel.chooseButton.right_sd+30,0, 60, 39)];
    oldNextModel.chooseButton.addressName = @"请选择";
    [oldNextModel.chooseButton setTitleColor:[UIColor PLColor12B06B_Theme] forState:UIControlStateNormal];
    self.sliderLine.left_sd = oldNextModel.chooseButton.left_sd;
    self.sliderLine.width_sd = oldNextModel.chooseButton.width_sd;
    [self.headerScroll addSubview:oldNextModel.chooseButton];
    self.headerScroll.contentSize = CGSizeMake(oldNextModel.chooseButton.right_sd+20, self.headerScroll.height_sd);
    
    //更细字典中的model
    [self.showListDic removeObjectForKey:@(oldNextModel.tableView.tag)];
    [self.showListDic setObject:oldNextModel forKey:@(oldNextModel.tableView.tag)];
    oldNextModel.chooseButton.showKey =@(oldNextModel.tableView.tag);
    [oldNextModel.tableView reloadData];//页面刷新
    self.backScrollView.contentSize = CGSizeMake(oldNextModel.tableView.right_sd, self.backScrollView.height_sd);//偏移量变化
    //把table展示出来
    [self.backScrollView setContentOffset:CGPointMake(oldNextModel.tableView.left_sd, 0) animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //把后面的table置空
        for (City_List_Model  *listModel in self.showListArray) {
            if (listModel.index>oldNextModel.index) {
                listModel.tableView.hidden = YES;
                listModel.selectedIndex = -1;
                listModel.dataArray = nil;
                [listModel.chooseButton removeFromSuperview];
                listModel.chooseButton = nil;
            }
        }
    });

}
-(void)reloadNewLoadTableModel:(City_List_Model*)tabModel forIndexPath:(NSIndexPath*)indexPath{


}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    if (scrollView == self.backScrollView) {
        CGFloat page = offsetX / KScreenWidth;
        //floor 取整函数
        CGFloat page_point = (page - floor(page));
        //lroundf 四舍五入，取最接近的整数
        if(lroundf(page_point * 1000) == 0) {
            NSInteger pageNum = floor(page);
            City_List_Model *tabModel = self.showListArray[pageNum];
            self.sliderLine.left_sd = tabModel.chooseButton.left_sd;
            self.sliderLine.width_sd = tabModel.chooseButton.width_sd;
        }
    }
    
}

-(void)requestForCommunityWithCityModel:(City_List_Area_Model*)cellModel listReturn:(void (^)(NSArray<City_List_Area_Model*> *result))block;{

    NetworkParameter *par = [[NetworkParameter alloc] init];
    par.parameter = @{@"areaid":cellModel.code};
    [NetService GET_NetworkParameter:par url:URL_area_getcommunitylist successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *data = responseObject[@"data"];
        NSMutableArray *list = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in data) {
            City_List_Area_Model *model = [[City_List_Area_Model alloc] init];
            model.code = dic[@"id"];
            model.name = dic[@"name"];
            [list addObject:model];
        }
        block(list);
    } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        block(nil);
    }];
}
-(void)requestForVillageWithCityModel:(City_List_Area_Model*)cellModel listReturn:(void (^)(NSArray<City_List_Area_Model*> *result))block;{
    
    NetworkParameter *par = [[NetworkParameter alloc] init];
    par.parameter = @{@"commid":cellModel.code};
    [NetService GET_NetworkParameter:par url:URL_area_getupdownlist successBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *data = responseObject[@"data"];
        NSMutableArray *list = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in data) {
            City_List_Area_Model *model = [[City_List_Area_Model alloc] init];
            model.code = dic[@"id"];
            model.name = dic[@"name"];
            [list addObject:model];
        }
        block(list);
    } failureBlock:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        block(nil);
    }];
}

-(NSArray<City_List_Area_Model*>*)getNewListWithFatherModel:(City_List_Area_Model*)model{
    if (model == nil) {
        //返回最高级别的数据
        return [City_List_Model getLocalAreaArray];
    }else{
        return model.children;
    }
    return nil;
}


-(NSMutableArray*)showListArray{
    if (!_showListArray) {
        _showListArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _showListArray;
}

-(NSMutableDictionary *)showListDic{
    if (!_showListDic) {
        _showListDic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _showListDic;
}
-(NSMutableArray<RXJDButton *> *)chooseBtnArray{
    if (_chooseBtnArray) {
        _chooseBtnArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _chooseBtnArray;
}


@end


@implementation City_List_Model


//获取本地地址
+ (NSArray<City_List_Area_Model*> *)getLocalAreaArray {
    NSString* path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
    if(path.length <= 0) {
        return nil;
    }
    NSData* data = [NSData dataWithContentsOfFile:path];
    id JsonObject =
    [NSJSONSerialization JSONObjectWithData:data
                                    options:NSJSONReadingAllowFragments
                                      error:nil];
    
    NSArray * arr = [[NSArray arrayWithObject:JsonObject] objectAtIndex:0];
    arr = [City_List_Area_Model mj_objectArrayWithKeyValuesArray:arr];
    
    NSMutableArray * _allCitiesArr = [[NSMutableArray alloc] initWithArray:arr];
    
    for(NSInteger i = 0; i < _allCitiesArr.count; i++) {
        City_List_Area_Model *model = _allCitiesArr[i];
        NSString * code = model.code;
        model.level = 1;
        if([self screenmaskArea:code]) {
            [_allCitiesArr removeObjectAtIndex:i];
        }
    }
    return _allCitiesArr;
}

///屏蔽 哪些 省份
+ (BOOL)screenmaskArea:(NSString *)nameCode {
    NSArray * screenMaskArr = @[
                                @"630000", //青海省
                                @"540000", //西藏自治区
                                @"150303" //海南区
                                ];
    
    if([screenMaskArr containsObject:nameCode]) {
        return YES;
    }
    return NO;
}





@end

@implementation City_List_Area_Model

+(NSDictionary *)mj_objectClassInArray{
    return @{@"children":[City_List_Area_Model class]};
}


@end
