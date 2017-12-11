//
//  GFAlertController.h
//  ScanCode
//
//  Created by lzq-psylife on 2017/12/11.
//  Copyright © 2017年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFAlertController : NSObject

/**
 仅带一个按钮的提示框
 
 @param vc 由哪个VC模态出来（展示在哪个VC上）
 @param title 标题
 @param message 提示信息
 @param confirmTitle 按钮上的文字
 @param handler 按钮的事件回调
 */
+ (void)presentAlertViewForController:(UIViewController *)vc title:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle handler:(void(^)(void))handler;

/**
 带两个按钮的提示框
 
 @param vc 由哪个VC模态出来（展示在哪个VC上）
 @param title 标题
 @param message 提示信息
 @param cancelTitle 左按钮文字
 @param confirmTitle 右按钮文字
 @param cancel 左按钮回调
 @param confirm 右按钮回调
 */
+ (void)presentAlertViewForController:(UIViewController *)vc title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle cancel:(void(^)(void))cancel confirm:(void(^)(void))confirm;

/**
 多个按钮的提示框
 
 @param vc 由哪个VC模态出来（展示在哪个VC上）
 @param title 标题
 @param message 提示信息
 @param actionTitles 按钮名称数组
 @param preferredStyle 弹窗类型，只有UIAlertControllerStyleActionSheet和UIAlertControllerStyleAlert
 @param handler 点击按钮的回调
 */
+ (void)presentAlertViewForController:(UIViewController *)vc title:(NSString *)title message:(NSString *)message actionTitles:(NSArray<NSString *> *)actionTitles preferredStyle:(UIAlertControllerStyle)preferredStyle handler:(void(^) (NSUInteger buttonIndex, NSString *buttonTitle))handler;


@end
