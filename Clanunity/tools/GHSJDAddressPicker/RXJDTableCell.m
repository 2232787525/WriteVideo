//
//  RXJDTableCell.m
//  RXExtenstion
//
//  Created by srx on 16/8/8.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXJDTableCell.h"

@interface RXJDTableCell ()
{
    UILabel     * _titleLabel;
    UIImageView * _selectImgView;
}
@end

@implementation RXJDTableCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self configUI];
    }
    return self;
}
- (void)configUI {
    [self ifViewAlloc];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0,100, 20)];
    _titleLabel.centerY_sd = [[self class] cell_Height]/2.0;
    _titleLabel.text = @"";
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor PLColor666666];
    [self.contentView addSubview:_titleLabel];
    
    _selectImgView = [[UIImageView alloc] initWithFrame:CGRectMake(_titleLabel.right_sd+5, 0, 14, 9)];
    _selectImgView.centerY_sd = _titleLabel.centerY_sd;
    _selectImgView.image = [UIImage imageNamed:@"address_create_selected"];
    _selectImgView.hidden = YES;
    [self.contentView addSubview:_selectImgView];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)ifViewAlloc {
    if(_titleLabel) {
        [_titleLabel removeFromSuperview];
        _titleLabel = nil;
    }
    
    if(_selectImgView) {
        [_selectImgView removeFromSuperview];
        _selectImgView = nil;
    }
}

+(CGFloat)cell_Height{
    return 35*kScreenScale;
}
- (void)setCellTitle:(NSString *)title isSelected:(BOOL)isSelected {
    if(isSelected) {
        _titleLabel.textColor = [UIColor PLColor12B06B_Theme];
        _titleLabel.text = title;
        CGSize size = [PLGlobalClass sizeWithText:title font:[UIFont PLFont14] width:MAXFLOAT height:20];
        _titleLabel.width_sd = size.width+1;
        _selectImgView.left_sd = _titleLabel.right_sd+5;
        _selectImgView.hidden = NO;
    }
    else {
        _titleLabel.textColor = [UIColor PLColor666666];
        _titleLabel.text = title;
        CGSize size = [PLGlobalClass sizeWithText:title font:[UIFont PLFont14] width:MAXFLOAT height:20];
        _titleLabel.width_sd = size.width+1;
        _selectImgView.hidden = YES;
    }
}

@end
