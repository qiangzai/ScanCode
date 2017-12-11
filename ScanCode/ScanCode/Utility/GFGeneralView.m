//
//  GFGeneralView.m
//  ScanCode
//
//  Created by lzq-psylife on 2017/12/11.
//  Copyright © 2017年 lizhongqiang. All rights reserved.
//

#import "GFGeneralView.h"

@implementation GFGeneralView

+ (UILabel *)createLabelFont:(UIFont *)fontSize labelColor:(UIColor *)labelColor {
    UILabel *label = [[UILabel alloc] init];
    label.font = fontSize;
    label.textColor = labelColor;
    return label;
}

+ (UIButton *)createButtonFont:(UIFont *)fontSize textColor:(UIColor *)textColor btnTitle:(NSString *)btnTitle {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    [btn.titleLabel setFont:fontSize];
    return btn;
}

@end
