//
//  PLGlobalClass.h
//  PlamLive
//
//  Created by wangyadong on 2016/10/31.
//  Copyright © 2016年 wangyadong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AttributeModel;
@interface PLGlobalClass : NSObject
typedef NS_OPTIONS(NSUInteger, ButtonEdgeInsetsStyleReferToImage) {
    ButtonEdgeInsetsStyleImageTop    = 0,// image在上，label在下
    ButtonEdgeInsetsStyleImageLeft  = 1,// image在左，label在右
    ButtonEdgeInsetsStyleImageBottom = 2,// image在下，label在上
    ButtonEdgeInsetsStyleImageRight  = 3,// image在右，label在左
};
/**
 计算文字所占label的大小
 */
+(CGSize)sizeWithText:(NSString*)text font:(UIFont*)fonnt width:(CGFloat)width height:(CGFloat)height;
/**
 *  给label的文本显示增加行间距
 *
 *  @param label      文本显示的label
 *  @param textString 显示的文本内容
 *  @param font       文本字体
 *  @param lineSpace  行间距
 *  @param width      文本显示给定的宽
 *
 *  @return 文本显示的size
 */
+(CGSize)sizeAttributeTextWithLineSpaceForLabel:(UILabel*)label textString:(NSString*)textString textFont:(UIFont*)font lineSpaceing:(CGFloat)lineSpace labelWidth:(CGFloat)width;

//设置行距的label

/**
 对一个label添加的行间距之后需要显示的label的size大小
和下面的paragraphForlabel 方法成对出现
 @param text 文字
 @param weight 固定宽
 @param fonts  字体大小
 @param lineSpace 行间距大小

 @return label的大小
 */
+(CGSize)sizeForParagraphWithText:(NSString*)text weight:(CGFloat)weight fontSize:(CGFloat)fonts lineSpacing:(CGFloat)lineSpace  numberline:(NSInteger)numberline;
//label，行间距


/**
 对label设置行间距
和上面的sizeForParagraphWithText成对使用
 @param label     显示文本的label
 @param lineSpace 行家就
 */
+(void)paragraphForlabel:(UILabel*)label lineSpace:(CGFloat)lineSpace;



/**
 *  判断是否是手机号
 */
+ (BOOL)valiMobilePhone:(NSString *)mobile;


/**
 *  验证身份证号码是否正确的方法
 *
 *  @param IDNumber 传进身份证号码字符串
 *
 *  @return 返回YES或NO表示该身份证号码是否符合国家标准
 */
+ (BOOL)validateIdentityCard:(NSString *)IDNumber;

/**
 actionSheet
 
 @param titles      标题数组
 @param cancel      底部“取消”
 @param controller  显示VC
 @param titlesblock 回调index
 @param cancelBlock 取消回调
 */
+(void)alertActionSheetWithDefaultTitles:(NSArray*)titles cancelTitle:(NSString*)cancel forDelegate:(id)controller defaultActionBlock:(void (^)(NSInteger index))titlesblock cancelBlock:(void(^)())cancelBlock;
+(void)alertActionSheetWithTitle:(NSString*)title message:(NSString*)msg defaultTitles:(NSArray*)titles cancelTitle:(NSString*)cancel forDelegate:(id)controller defaultActionBlock:(void (^)(NSInteger index))titlesblock cancelBlock:(void(^)())cancelBlock;


/**
 便捷提示
 
 @param title <#title description#>
 @param message <#message description#>
 @param sureTitle <#sureTitle description#>
 @param cancelTitle <#cancelTitle description#>
 @param sure <#sure description#>
 @param cancel <#cancel description#>
 @param controller <#controller description#>
 */
+(void)aletWithTitle:(NSString *_Nullable)title Message:(NSString *_Nullable)message  sureTitle:(NSString*_Nullable)sureTitle CancelTitle:(NSString *_Nullable)cancelTitle SureBlock:(void(^_Nonnull)())sure andCancelBlock:(void(^_Nonnull)()) cancel andDelegate:(id _Nonnull )controller;




/**
 两个时间戳字符串，或NSDate之间的时间间隔
 
 @param timeOne   时间戳string，或者NSDate
 @param timeOther <#timeOther description#>
 
 @return 如果两个时间戳不合规格或者传nil会返回-1
 */
+(NSInteger)timesIntervalOne:(id)timeOne other:(id)timeOther;
/**字符串 带颜色 */

+(NSAttributedString*)attributedStringCombinationFirstPart:(AttributeModel*)firstModel anotherPart:(AttributeModel*)secondModel;

/**设置btn图片和文字的排列类型 **/
/**0-image在上 lable在下 1-image在左 lable在右**/
/**2-image在下 lable在上 3-image在右 lable在左**/
/**space 图片和文字间距 一般写2**/
+(void)setBtnStyle:(UIButton *)btn style:(ButtonEdgeInsetsStyleReferToImage)style space:(float)space;

@end

@interface AttributeModel : NSObject

@property(nonatomic,copy)NSString * text;
@property(nonatomic,strong)UIFont * textFont;
@property(nonatomic,strong)UIColor * textColor;
@end

