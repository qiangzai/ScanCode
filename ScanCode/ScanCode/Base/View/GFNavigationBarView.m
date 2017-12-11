//
//  GFNavigationBarView.m
//  ScanCode
//
//  Created by lzq-psylife on 2017/12/8.
//  Copyright © 2017年 lizhongqiang. All rights reserved.
//

#import "GFNavigationBarView.h"

@interface GFNavigationBarView ()
@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation GFNavigationBarView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.effectView];
        [self addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom).with.offset(-10);
        }];
        
    }
    return self;
}

#pragma mark - setter / getter
- (UIVisualEffectView *)effectView {
    if (_effectView == nil) {
        _effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        _effectView.frame = self.frame;
    }
    return _effectView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [GFGeneralView createLabelFont:[UIFont systemFontOfSize:16] labelColor:[UIColor whiteColor]];
        _titleLabel.text = @"扫描";
    }
    return _titleLabel;
}

@end
