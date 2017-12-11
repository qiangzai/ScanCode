//
//  GFAboutViewController.m
//  ScanCode
//
//  Created by lzq-psylife on 2017/12/11.
//  Copyright © 2017年 lizhongqiang. All rights reserved.
//

#import "GFAboutViewController.h"

@interface GFAboutViewController ()
@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation GFAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"关于安全二维码";
    
    [self.view addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(10);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - setter and getter
- (UILabel *)tipLabel {
    if (_tipLabel == nil) {
        _tipLabel = [GFGeneralView createLabelFont:[UIFont systemFontOfSize:16] labelColor:kColor333];
        _tipLabel.numberOfLines = 0;
        _tipLabel.text = @"二维码给我们的生活提供了方便，但是也有扫描二维码造成资金损失的案例，此App旨在解决直接扫描二维码";
    }
    return _tipLabel;
}



@end
