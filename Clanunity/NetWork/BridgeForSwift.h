//
//  BridgeForSwift.h
//  Clanunity
//
//  Created by wangyadong on 2017/9/29.
//  Copyright © 2017年 zfy_srf. All rights reserved.
//


// 这个类是桥接OC跟swift的
#import <Foundation/Foundation.h>


#pragma mark - 网络请求声明的block
/**成功的回调 */
typedef void(^SuccessfulHandle) (NSURLSessionDataTask * _Nonnull task, id  _Nullable responseAny);
/**失败的回调 */
typedef void(^FailedHandle) (NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);
/**进度 */
typedef void(^ProgressHandle) (NSProgress * _Nonnull downloadProgress);
/**线程 */
typedef void(^DispathMainHandle) (id  _Nullable sender);

#define ToolService [NetworkTools shareInstance]







