//
//  PLGlobalClass.m
//  PlamLive
//
//  Created by wangyadong on 2016/10/31.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import "PLGlobalClass.h"

@implementation PLGlobalClass
//计算文字所占区域大小
+(CGSize)sizeWithText:(NSString*)text font:(UIFont*)fonnt width:(CGFloat)width height:(CGFloat)height{
    NSDictionary *attribute = @{NSFontAttributeName: fonnt};
    
    CGSize size =[text boundingRectWithSize:CGSizeMake(width, height) options:
                  NSStringDrawingTruncatesLastVisibleLine |
                  NSStringDrawingUsesLineFragmentOrigin |
                  NSStringDrawingUsesFontLeading attributes:attribute
                                    context:nil].size;
    CGFloat w = 0.0;
    CGFloat h = 0.0;
    if (!isnan(size.width)) {
        w = size.width;
    }
    if (!isnan(size.height)) {
        h = size.height;
    }
    return CGSizeMake(w, h);
    
}

+(CGSize)sizeAttributeTextWithLineSpaceForLabel:(UILabel*)label textString:(NSString*)textString textFont:(UIFont*)font lineSpaceing:(CGFloat)lineSpace labelWidth:(CGFloat)width{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:textString];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,textString.length)];
    label.attributedText = attributedString;
    label.numberOfLines = 0;
    label.font = font;
    //调节高度
    CGSize size = [label sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    
    CGFloat w = 0.0;
    CGFloat h = 0.0;
    if (!isnan(size.width)) {
        w = size.width;
    }
    if (!isnan(size.height)) {
        h = size.height;
    }
    return CGSizeMake(w, h);
    
}
+(CGSize)sizeForParagraphWithText:(NSString*)text weight:(CGFloat)weight fontSize:(CGFloat)fonts lineSpacing:(CGFloat)lineSpace numberline:(NSInteger)numberline{
    //调节高度
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.font = [UIFont systemFontOfSize:fonts];
    descLabel.numberOfLines = numberline;
    descLabel.attributedText = attributedString;
    CGSize size = [descLabel sizeThatFits:CGSizeMake(weight , MAXFLOAT)];
    CGFloat w = 0.0;
    CGFloat h = 0.0;
    if (!isnan(size.width)) {
        w = size.width;
    }
    if (!isnan(size.height)) {
        h = size.height;
    }
    return CGSizeMake(w, h);
}

+(void)paragraphForlabel:(UILabel*)label lineSpace:(CGFloat)lineSpace{
    //调节高度
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
    [label setAttributedText:attributedString];
}

+ (BOOL)valiMobilePhone:(NSString *)mobile{
    if (IsEmptyStr(mobile) && mobile.length < 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(173)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }

}
+(void)alertActionSheetWithTitle:(NSString*)title message:(NSString*)msg defaultTitles:(NSArray*)titles cancelTitle:(NSString*)cancel forDelegate:(id)controller defaultActionBlock:(void (^)(NSInteger index))titlesblock cancelBlock:(void(^)())cancelBlock{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: title.length>0?title:nil                                                                             message: msg.length>0?msg:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSInteger i = 0; i < titles.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:titles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            titlesblock(i);
            
        }];
        [alertController addAction:action];
    }
    [alertController addAction:[UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        cancelBlock();
    }]];
    
    [controller presentViewController:alertController animated:YES completion:nil];
}

+(void)alertActionSheetWithDefaultTitles:(NSArray*)titles cancelTitle:(NSString*)cancel forDelegate:(id)controller defaultActionBlock:(void (^)(NSInteger index))titlesblock cancelBlock:(void(^)())cancelBlock{
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil                                                                             message: nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:titles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            titlesblock(i);
        }];
        [alertController addAction:action];
    }
    [alertController addAction:[UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancelBlock();
    }]];
    
    [controller presentViewController:alertController animated:YES completion:nil];
}


+(void)aletWithTitle:(NSString *)title Message:(NSString *)message  sureTitle:(NSString*)sureTitle CancelTitle:(NSString *)cancelTitle SureBlock:(void(^)())sure andCancelBlock:(void(^)()) cancel andDelegate:(id)controller{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelTitle && cancelTitle.length > 0) {
        [alert addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancel) {
                cancel();
            }
        }]];
    }
    
   
    
    if (sureTitle && sureTitle.length> 0) {
        [alert addAction:[UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (sure) {
                sure();
            }
        }]];
    }
    [controller presentViewController:alert animated:YES completion:nil];
    
}

+(NSInteger)timesIntervalOne:(id)timeOne other:(id)timeOther{
    NSDate *dateOne = nil;
    NSDate *dateOther = nil;
    NSInteger interval = -1;
    //
    if ([timeOne isKindOfClass:[NSDate class]]) {
        dateOne = (NSDate*)timeOne;
    }else if([timeOne isKindOfClass:[NSString class]] &&[NSString isPureNumandCharacters:(NSString*)timeOne]){
        dateOne = [NSDate dateWithTimeIntervalSince1970:[(NSString*)timeOne integerValue]];
    }
    //
    if ([timeOther isKindOfClass:[NSDate class]]) {
        dateOther = (NSDate*)timeOther;
    }else if([timeOther isKindOfClass:[NSString class]]&&[NSString isPureNumandCharacters:(NSString*)timeOne]){
        dateOther =[NSDate dateWithTimeIntervalSince1970:[(NSString*)timeOther integerValue]];
    }
    //
    if (dateOne != nil && dateOther != nil) {
        interval = (NSInteger)[dateOne timeIntervalSinceDate:dateOther];
    }
    
    return interval;
}
+(NSAttributedString *)attributedStringCombinationFirstPart:(AttributeModel *)firstModel anotherPart:(AttributeModel *)secondModel{
    firstModel.text = firstModel.text.length > 0 ? firstModel.text : @"";
    secondModel.text = secondModel.text.length > 0 ? secondModel.text : @"";

    UILabel *lb = nil;
    lb.textColor = nil;
    NSInteger str1Num = [firstModel.text length];
    NSString * linkStr = [NSString stringWithFormat:@"%@%@",firstModel.text,secondModel.text];
    NSInteger strNum = [linkStr length];
    NSMutableAttributedString *linkedString = [[NSMutableAttributedString alloc] initWithString:linkStr];
    if (firstModel.textFont != nil) {
        [linkedString addAttribute:NSFontAttributeName value:firstModel.textFont range:NSMakeRange(0,str1Num)];
    }
    if (firstModel.textColor != nil) {
        [linkedString addAttribute:NSForegroundColorAttributeName value:firstModel.textColor range:NSMakeRange(0,str1Num)];
    }
//
    if (secondModel.textColor != nil) {
        [linkedString addAttribute:NSFontAttributeName value:secondModel.textFont range:NSMakeRange(str1Num,strNum-str1Num)];
    }
    if (secondModel.textFont != nil) {
        [linkedString addAttribute:NSForegroundColorAttributeName value:secondModel.textColor range:NSMakeRange(str1Num,strNum-str1Num)];
    }
    
//    return [PLGlobalClass attributedStringWithColorOneStr:firstModel.text andColorOne:firstModel.textColor andFontOne:firstModel.textFont andColorTwoStr:secondModel.text andColorTwo:secondModel.textColor andFontTwo:secondModel.textFont];
    
    return linkedString;
}

+(NSAttributedString *)attributedStringWithColorOneStr:(NSString *)oneStr andColorOne:(UIColor *)colorOne andFontOne:(UIFont*)fontOne andColorTwoStr:(NSString *)twoStr andColorTwo:(UIColor *)colorTwo andFontTwo:(UIFont*)fontTwo{
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",oneStr,twoStr]];
    NSRange range1=[[hintString string]rangeOfString:oneStr];
    [hintString addAttribute:NSForegroundColorAttributeName value:colorOne range:range1];
    [hintString addAttribute:NSFontAttributeName value:fontOne range:range1];
    //
    NSRange range2=[[hintString string]rangeOfString:twoStr];
    [hintString addAttribute:NSForegroundColorAttributeName value:colorTwo range:range2];
    [hintString addAttribute:NSFontAttributeName value:fontTwo range:range2];

    return hintString;
}



/**设置btn图片和文字的排列类型 **/
/**0-image在上 lable在下 1-image在左 lable在右**/
/**2-image在下 lable在上 3-image在右 lable在左**/
/**space 图片和文字间距 一般写2**/
+(void)setBtnStyle:(UIButton *)btn style:(ButtonEdgeInsetsStyleReferToImage)style space:(float)space
{
    CGFloat imageWith = btn.imageView.frame.size.width;
    CGFloat imageHeight = btn.imageView.frame.size.height;
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = btn.titleLabel.intrinsicContentSize.width;
        labelHeight = btn.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = btn.titleLabel.frame.size.width;
        labelHeight = btn.titleLabel.frame.size.height;
    }
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    switch (style) {
        case ButtonEdgeInsetsStyleImageTop:
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space, 0);
            break;
        case ButtonEdgeInsetsStyleImageLeft:
            imageEdgeInsets = UIEdgeInsetsMake(0, -space, 0, space);
            labelEdgeInsets = UIEdgeInsetsMake(0, space, 0, -space);
            break;
        case ButtonEdgeInsetsStyleImageBottom:
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space, -imageWith, 0, 0);
            break;
        case ButtonEdgeInsetsStyleImageRight:
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space, 0, -labelWidth-space);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space, 0, imageWith+space);
            break;
        default:
            break;
    }
    btn.titleEdgeInsets = labelEdgeInsets;
    btn.imageEdgeInsets = imageEdgeInsets;
}



/**
 *  验证身份证号码是否正确的方法
 *
 *  @param IDNumber 传进身份证号码字符串
 *
 *  @return 返回YES或NO表示该身份证号码是否符合国家标准
 */
+ (BOOL)validateIdentityCard:(NSString *)IDNumber
{
    
    if ([NSString trimString:IDNumber].length != 18) {
        return NO;
    }
    
    NSMutableArray *IDArray = [NSMutableArray array];
    // 遍历身份证字符串,存入数组中
    for (int i = 0; i < 18; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [IDNumber substringWithRange:range];
        [IDArray addObject:subString];
    }
    // 系数数组
    NSArray *coefficientArray = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
    // 余数数组
    NSArray *remainderArray = [NSArray arrayWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", nil];
    // 每一位身份证号码和对应系数相乘之后相加所得的和
    int sum = 0;
    for (int i = 0; i < 17; i++) {
        int coefficient = [coefficientArray[i] intValue];
        int ID = [IDArray[i] intValue];
        sum += coefficient * ID;
    }
    // 这个和除以11的余数对应的数
    NSString *str = remainderArray[(sum % 11)];
    // 身份证号码最后一位
    NSString *string = [IDNumber substringFromIndex:17];
    // 如果这个数字和身份证最后一位相同,则符合国家标准,返回YES
    if ([str isEqualToString:string]) {
        return YES;
    } else {
        return NO;
    }
}



@end


@implementation AttributeModel



@end
