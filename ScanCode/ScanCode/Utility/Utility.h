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

@end
