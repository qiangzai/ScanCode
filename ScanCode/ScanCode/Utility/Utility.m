//
//  Utility.m
//  ScanCode
//
//  Created by lizhongqiang on 2017/12/6.
//  Copyright © 2017年 lizhongqiang. All rights reserved.
//

#import "Utility.h"

@implementation Utility

//获取当前版本号
+ (NSString *)getLocalAppVersion {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *version = [dict objectForKey:@"CFBundleShortVersionString"];
    return version;
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}

+ (BOOL)isInterNet:(NSString *)url {
    if ([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"] || [url hasPrefix:@"www."]) {
        return YES;
    } else {
        return NO;
    }
    
}

+ (BOOL)isNumber:(NSString *)url {
    NSString * regex        = @"^[0-9]*$";
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch            = [pred evaluateWithObject:url];
    if (isMatch) {
        return YES;
    }else{
        return NO;
    }
}

@end
