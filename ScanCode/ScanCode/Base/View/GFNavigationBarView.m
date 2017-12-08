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
//        _titleLabel = [PSYGeneralView createLabelFont:kPSYFont18 labelColor:kColorFFF];
        _titleLabel.text = @"扫描徽章";
    }
    return _titleLabel;
}

@end
