//
//  UIFont+PLFont.m
//  Clanunity
//
//  Created by wangyadong on 2017/6/6.
//  Copyright © 2017年 duolaimi. All rights reserved.
//

#import "UIFont+PLFont.h"

@implementation UIFont (PLFont)

+(UIFont *)PLFont17{
    
    return [UIFont systemFontOfSize:17];
}


+(UIFont *)PLFont16{
    
    return [UIFont systemFontOfSize:PLFONT_HUGE];
}

+(UIFont *)PLFont15{
    return [UIFont systemFontOfSize:PLFONT_BIG];
}

+(UIFont *)PLFont13{
    return [UIFont systemFontOfSize:13];
}

+(UIFont *)PLFont14{
    return [UIFont systemFontOfSize:PLFONT_MEDIUM];
}
+(UIFont *)PLFont12{
    return [UIFont systemFontOfSize:PLFONT_SMALL];
}

+(UIFont *)PLFont11{
    return [UIFont systemFontOfSize:PLFONT_LITTLE];
}
+(UIFont*)PLFont10{
    return [UIFont systemFontOfSize:PLFONT_MIN];

}

+(UIFont *)PLFontbold14{
    return [UIFont boldSystemFontOfSize:14];
}

+(UIFont *)PLFontbold15{
    return [UIFont boldSystemFontOfSize:PLFONT_BIG];
}

+(UIFont *)PLFontbold16{
    return [UIFont boldSystemFontOfSize:16];
}

+(UIFont *)PLFontbold17{
    return [UIFont boldSystemFontOfSize:17];
}
+(UIFont *)PLFontbold18{
    return [UIFont boldSystemFontOfSize:18];
}
+(UIFont *)PLFontbold19{
    return [UIFont boldSystemFontOfSize:19];
}
+(UIFont *)PLFontbold20{
    return [UIFont boldSystemFontOfSize:20];
}

@end
