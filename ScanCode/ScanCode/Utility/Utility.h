//
//  Utility.h
//  ScanCode
//
//  Created by lizhongqiang on 2017/12/6.
//  Copyright © 2017年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

/**
 获得当前版本号

 @return 当前版本号
 */
+ (NSString *)getLocalAppVersion;

/**
 获取当前显示的VC

 @return 当前显示的VC
 */
+ (UIViewController *)getCurrentVC;

/**
 是否是网络链接

 @param url 传入要验证的字符
 @return YES是网络链接 NO不是
 */
+ (BOOL)isInterNet:(NSString *)url;

/**
 是否是纯数字

 @param url 传入要验证的字符
 @return YES是纯数字 NO不是
 */
+ (BOOL)isNumber:(NSString *)url;


@end
