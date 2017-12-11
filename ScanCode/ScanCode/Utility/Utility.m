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

@end
