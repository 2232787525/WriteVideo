//
//  RXJDButton.m
//  RXExtenstion
//
//  Created by srx on 16/8/8.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXJDButton.h"

@implementation RXJDButton


- (CGFloat)width_Text {
    return _width_Text;
}


- (void)setAddressName:(NSString *)addressName {
    _addressName = addressName;
    [self setTitle:addressName forState:UIControlStateNormal];

    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self setTitleColor:[UIColor PLColor33333] forState:UIControlStateNormal];
    
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.backgroundColor = [UIColor clearColor];
    
    CGRect rect = self.frame;

    [self sizeToFit];
    _width_Text = self.bounds.size.width;
    self.frame = CGRectMake(rect.origin.x, rect.origin.y, _width_Text, rect.size.height);
    
}

@end
