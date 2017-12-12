//
//  GFDefine.h
//  ScanCode
//
//  Created by lzq-psylife on 2017/12/11.
//  Copyright © 2017年 lizhongqiang. All rights reserved.
//

#ifndef GFDefine_h
#define GFDefine_h

#define kScale          ([UIScreen mainScreen].scale)
#define kPSYWidth       ([[UIScreen mainScreen] bounds].size.width)
#define kPSYHeight      ([[UIScreen mainScreen] bounds].size.height)

#define kScreenRate     ([UIScreen mainScreen].bounds.size.width / 375.0f)      //屏幕比例
#define kPSYFitSize(value)     ((value) * kScreenRate)                          //得到对应尺寸

#define kPSYColorWithHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]
#define kPSYColorWithAlphaHex(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:a]


#define kColor333           kPSYColorWithHex(0x333333)
#define kColor666           kPSYColorWithHex(0x666666)
#define kColor999           kPSYColorWithHex(0x999999)
#define kColorMain          kPSYColorWithHex(0x1e9e2e)

#endif /* GFDefine_h */
