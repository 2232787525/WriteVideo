//
//  RXJDButton.h
//  RXExtenstion
//
//  Created by srx on 16/8/8.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RXJDButton : UIButton
@property(nonatomic,strong)NSNumber * showKey;
@property (nonatomic, assign) NSInteger  tagJD;
@property (nonatomic, copy)   NSString * addressName;

@property (nonatomic, assign) CGFloat    width_Text;

@end

/*
        外部不掉用此文件
 */
