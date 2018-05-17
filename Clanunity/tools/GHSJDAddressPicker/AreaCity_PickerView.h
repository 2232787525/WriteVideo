//
//  AreaCity_PickerView.h
//  Clanunity
//
//  Created by wangyadong on 2017/8/11.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaCity_PickerView : UIView


@property(nonatomic,copy)void(^closeButtonBlock)(NSString*address,NSArray*idArray);

@end

@class City_List_Area_Model,RXJDButton;
@interface City_List_Model : PLBaseModel
/**当前级别的index */
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)NSArray<City_List_Area_Model*> * dataArray;
/**选中的index */
@property(nonatomic,assign)NSInteger selectedIndex;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,copy)NSString * cellIder;
@property(nonatomic,strong)RXJDButton * chooseButton;
+ (NSArray<City_List_Area_Model*> *)getLocalAreaArray;


@end

@interface City_List_Area_Model : PLBaseModel
@property(nonatomic,copy)NSString * code;
@property(nonatomic,copy)NSString * name;

/**
等级 省 1，市2，区3，社区4，小区5
 */
@property(nonatomic,assign)NSInteger  level;
@property(nonatomic,strong)NSArray<City_List_Area_Model*> * children;

@end
