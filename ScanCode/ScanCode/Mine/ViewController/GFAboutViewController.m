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
        _tipLabel.text = @"二维码给我们的生活提供了各种方便，但是扫描二维码造成资金损失的例子也有很多，在此告诫大家，千万不要随意扫描陌生人分享出来的二维码，如果遇到可疑的二维码，可先使用一些二维码扫描工具，扫描看看此二维码指向的链接是否正确，如果发现可疑链接，建议不要轻易进行登录、转账等等操作！在此环境下，我们开发了此款App，希望能给你们提供一点帮助。";
    }
    return _tipLabel;
}



@end
