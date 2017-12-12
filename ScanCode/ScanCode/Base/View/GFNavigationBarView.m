//
//  GFNavigationBarView.m
//  ScanCode
//
//  Created by lzq-psylife on 2017/12/8.
//  Copyright © 2017年 lizhongqiang. All rights reserved.
//

#import "GFNavigationBarView.h"
#import "UIImage+PSYTint.h"

@interface GFNavigationBarView ()
@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *photoBtn;

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
        
        [self addSubview:self.flashBtn];
        [self addSubview:self.photoBtn];
        [self.flashBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.left.equalTo(self.mas_left).with.offset(15);
            make.bottom.equalTo(self.mas_bottom);
        }];
        [self.photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.right.equalTo(self.mas_right).with.offset(-15);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }
    return self;
}

#pragma mark - event
- (void)flashBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectFlash)]) {
        [self.delegate didSelectFlash];
    }
}

- (void)photoBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectPhoto)]) {
        [self.delegate didSelectPhoto];
    }
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
        _titleLabel = [GFGeneralView createLabelFont:[UIFont boldSystemFontOfSize:17] labelColor:[UIColor whiteColor]];
        _titleLabel.text = @"扫描";
    }
    return _titleLabel;
}

- (UIButton *)flashBtn {
    if (_flashBtn == nil) {
        _flashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_flashBtn setImage:[[UIImage imageNamed:@"flash-open"] imageWithTintColor:kColorMain] forState:UIControlStateNormal];
        [_flashBtn setImage:[[UIImage imageNamed:@"flash-close"] imageWithTintColor:kColorMain] forState:UIControlStateSelected];
        [_flashBtn addTarget:self action:@selector(flashBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flashBtn;
}

- (UIButton *)photoBtn {
    if (_photoBtn == nil) {
        _photoBtn = [GFGeneralView createButtonFont:[UIFont systemFontOfSize:16] textColor:[UIColor whiteColor] btnTitle:@"相册"];
        [_photoBtn addTarget:self action:@selector(photoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _photoBtn;
}

@end
