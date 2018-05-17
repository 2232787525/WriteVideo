//
//  PLHOTDefine.m
//  Clanunity
//
//  Created by zfy_srf on 2017/4/14.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//

#import "PLHOTDefine.h"

@implementation PLHOTDefine

+(CGFloat)titleHeight{
    return 20;
}
+(CGFloat)textheight{
    return 36;
}
+(CGFloat)edgeText{
    return 10;
}
//左右距离
+(CGFloat)margeOut{
    return KScreenWidth/13.0;
}
+(CGFloat)margeIn{
    return 30;
}
//上下距离
+(CGFloat)edgeItemOut{
    return 30;
}
+(CGFloat)edgeItem{
    return 20;
}

+(CGSize)headSize{
    return CGSizeMake(40,40);
}
+(CGSize)QRcodeSize{
    CGFloat qrW = [PLHOTDefine backWeight]-2*[PLHOTDefine margeIn];
    return CGSizeMake(qrW, qrW);
}
+(CGFloat)btnHeight{
    return 40;
}


+(CGFloat)backHeight{
    
    return [PLHOTDefine edgeItemOut]+[PLHOTDefine titleHeight]+10+18+10+[PLHOTDefine edgeText]+[PLHOTDefine textheight]+[PLHOTDefine edgeText]+[PLHOTDefine QRcodeSize].height+[PLHOTDefine edgeItem]+[PLHOTDefine btnHeight]+[PLHOTDefine edgeItemOut];;
}
+(CGFloat)backWeight{
    return KScreenWidth - 2*[PLHOTDefine margeOut];
}

@end
