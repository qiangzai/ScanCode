//
//  GFAlertController.m
//  ScanCode
//
//  Created by lzq-psylife on 2017/12/11.
//  Copyright © 2017年 lizhongqiang. All rights reserved.
//

#import "GFAlertController.h"

@implementation GFAlertController

+ (void)presentAlertViewForController:(UIViewController *)vc title:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle handler:(void (^)(void))handler {
    
    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (handler) {
            handler();
        }
    }];
    
    [alertCtr addAction:action];
    dispatch_async(dispatch_get_main_queue(), ^{
        [vc presentViewController:alertCtr animated:YES completion:nil];
    });
    
}

+ (void)presentAlertViewForController:(UIViewController *)vc title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle cancel:(void (^)(void))cancel confirm:(void (^)(void))confirm {
    
    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancel) {
            cancel();
        }
    }];
    [alertCtr addAction:cancelAction];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm();
        }
    }];
    [alertCtr addAction:confirmAction];
    dispatch_async(dispatch_get_main_queue(), ^{
        [vc presentViewController:alertCtr animated:YES completion:nil];
    });
    
}

+ (void)presentAlertViewForController:(UIViewController *)vc title:(NSString *)title message:(NSString *)message actionTitles:(NSArray<NSString *> *)actionTitles preferredStyle:(UIAlertControllerStyle)preferredStyle handler:(void(^) (NSUInteger buttonIndex, NSString *buttonTitle))handler {
    
    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (handler) {
            handler(0,@"取消");
        }
    }];
    [alertCtr addAction:cancelAction];
    
    for (int i = 0; i < actionTitles.count; i ++) {
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:actionTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (handler) {
                handler((i + 1), actionTitles[i]);
            }
        }];
        [alertCtr addAction:confirmAction];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [vc presentViewController:alertCtr animated:YES completion:nil];
    });
    
}

@end
