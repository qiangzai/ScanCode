//
//  GFGeneralView.h
//  ScanCode
//
//  Created by lzq-psylife on 2017/12/11.
//  Copyright © 2017年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFGeneralView : NSObject
/**
 生成Label
 
 @param fontSize 字体大小
 @param labelColor 字体颜色
 @return 通用生成的Label
 */
+ (UILabel *)createLabelFont:(UIFont *)fontSize labelColor:(UIColor *)labelColor;

/**
 生成Button
 
 @param fontSize 字体大小
 @param textColor 文字颜色
 @param btnTitle 文字
 @return 通用生成的Button
 */
+ (UIButton *)createButtonFont:(UIFont *)fontSize textColor:(UIColor *)textColor btnTitle:(NSString *)btnTitle;

@end

