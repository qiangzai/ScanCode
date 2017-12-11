//
//  UIImage+PSYTint.h
//  Tour
//
//  Created by 林兴栋 on 2017/6/22.
//  Copyright © 2017年  lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (PSYTint)
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;
- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;
- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;
@end
