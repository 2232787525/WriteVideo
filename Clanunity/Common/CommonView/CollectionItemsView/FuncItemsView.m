//
//  FuncItemsView.m
//  PlamLive
//
//  Created by wangyadong on 2017/2/23.
//  Copyright © 2017年 wangyadong. All rights reserved.
//

#import "FuncItemsView.h"
@implementation FuncItemsView

-(void)setDataArray:(NSArray<PLFuncModel *> *)dataArray{
    _dataArray = dataArray;
    [self removeAllSubviews];
    
    NSInteger cellNumber = dataArray.count%4==0?dataArray.count/4:dataArray.count/4+1;
    CGFloat itemW = KScreenWidth/4.0;
    CGFloat itemH = 85;
    if (cellNumber == 1) {
        itemW = KScreenWidth/(dataArray.count*1.0);
    }
    __weak typeof(self)weakSelf = self;

    for (NSInteger i = 0; i < dataArray.count; i++) {
        PLFuncItemView *item = [[PLFuncItemView alloc] initWithFrame:CGRectMake(itemW*(i%4),i/4*itemH,itemW,itemH)];
        item.model = dataArray[i];
        [self addSubview:item];
        self.viewHieght = item.bottom_sd;
        
        [item setItemClickedBlock:^(PLFuncModel *model) {
            if (weakSelf.itemClickedBlock) {
                weakSelf.itemClickedBlock(model);
            }
        }];
    }
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor PLColorContentBack];
    }
    return self;
}

@end

