//
//  GFNavigationBarView.h
//  ScanCode
//
//  Created by lzq-psylife on 2017/12/8.
//  Copyright © 2017年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GFNavigationBarViewDelegate <NSObject>

- (void)didSelectFlash;

- (void)didSelectPhoto;

@end

@interface GFNavigationBarView : UIView

@property (nonatomic, strong) UIButton *flashBtn;
@property (nonatomic, assign) id<GFNavigationBarViewDelegate> delegate;


@end
