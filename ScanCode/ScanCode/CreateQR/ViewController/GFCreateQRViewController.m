//
//  GFCreateQRViewController.m
//  ScanCode
//
//  Created by lizhongqiang on 2018/1/18.
//  Copyright © 2018年 lizhongqiang. All rights reserved.
//

#import "GFCreateQRViewController.h"
#import <YYTextView.h>
#import "GFResultQRViewController.h"


@interface GFCreateQRViewController ()
@property (nonatomic, strong) YYTextView *txtView;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UIButton *bgBtn;

@end

@implementation GFCreateQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"生成二维码";
    
//    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
//    tapGes.numberOfTapsRequired = 1;
//    tapGes.numberOfTouchesRequired = 1;
//    [self.view addGestureRecognizer:tapGes];
    [self.view addSubview:self.bgBtn];
    [self.view addSubview:self.txtView];
    [self.view addSubview:self.confirmBtn];
    
    [self.txtView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(15);
        make.width.mas_equalTo(kPSYWidth - 80);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(kPSYWidth - 100);
    }];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kPSYWidth - 60, 45));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.txtView.mas_bottom).with.offset(80);
    }];
    [self.bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event
- (void)confirmBtnClick:(UIButton *)btn {
    NSString *str = self.txtView.text;
    if (str.length <= 0) {
        [GFAlertController presentAlertViewForController:self title:@"提示" message:@"请至少输入一个字符" confirmTitle:@"我知道了" handler:^{
            
        }];
        return ;
    }
    
    GFResultQRViewController *resultVC = [[GFResultQRViewController alloc] init];
    resultVC.code = str;
    [self.navigationController pushViewController:resultVC animated:YES];
    
}

- (void)bgBtnClick:(UIButton *)btn {
    [self.txtView resignFirstResponder];
}

- (void)tapGes:(UITapGestureRecognizer *)ges {
    [self.txtView resignFirstResponder];
}

- (void)textViewDidEndEditing:(YYTextView *)textView {
    [textView resignFirstResponder];
}

#pragma mark - setter and getter
- (UIButton *)bgBtn {
    if (_bgBtn == nil) {
        _bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgBtn.backgroundColor = [UIColor whiteColor];
        [_bgBtn addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgBtn;
}
- (YYTextView *)txtView {
    if (_txtView == nil) {
        _txtView = [[YYTextView alloc] init];
        _txtView.layer.borderWidth = 1.f;
        _txtView.layer.borderColor = kColor999.CGColor;
        _txtView.placeholderText = @"请输入要生成二维码的文字";
        _txtView.placeholderFont = [UIFont systemFontOfSize:15];
        _txtView.font = [UIFont systemFontOfSize:15];
//        _txtView.returnKeyType = UIReturnKeyDone;
    }
    return _txtView;
}

- (UIButton *)confirmBtn {
    if (_confirmBtn == nil) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"生成" forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:kColorMain];
        _confirmBtn.layer.cornerRadius = 5;
        _confirmBtn.layer.masksToBounds = YES;
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _confirmBtn;
}



@end
