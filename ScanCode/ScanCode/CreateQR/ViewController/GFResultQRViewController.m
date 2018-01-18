//
//  GFResultQRViewController.m
//  ScanCode
//
//  Created by lizhongqiang on 2018/1/18.
//  Copyright © 2018年 lizhongqiang. All rights reserved.
//

#import "GFResultQRViewController.h"

@interface GFResultQRViewController ()
@property (nonatomic, strong) UIImage *resultImage;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation GFResultQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"生成二维码";
    
    self.resultImage = [self createQRImageWithString:self.code size:CGSizeMake(400, 400)];
//    UIImage *lastImg = [self changeColorForQRImage:image backColor:[UIColor grayColor] frontColor:kColorMain];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:self.resultImage];
    [self.view addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kPSYWidth - 100, kPSYWidth - 100));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(40);
    }];
    
    [self.view addSubview:self.shareBtn];
    [self.view addSubview:self.saveBtn];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kPSYWidth / 2 - 20, 45));
        make.top.equalTo(imgView.mas_bottom).with.offset(80);
        make.left.equalTo(self.view.mas_left).with.offset(10);
    }];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kPSYWidth / 2 - 20, 45));
        make.top.equalTo(imgView.mas_bottom).with.offset(80);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event
- (void)shareBtnClick:(UIButton *)btn {
    NSString *textToShare = @"我生成了一个二维码，来看看吧！";
//    UIImage *imageToShare = [UIImage imageNamed:@"Icon180.png"];
    NSArray *activityItems = @[textToShare,self.resultImage];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (void)saveBtnClick:(UIButton *)btn {
    UIImageWriteToSavedPhotosAlbum(self.resultImage, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        NSLog(@"保存成功");
        [GFAlertController presentAlertViewForController:self title:@"提示" message:@"二维码已保存到相册" confirmTitle:@"我知道了" handler:^{
            
        }];
    } else {
        [GFAlertController presentAlertViewForController:self title:@"提示" message:@"二维码保存失败" confirmTitle:@"我知道了" handler:^{
            
        }];
    }
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}

#pragma mark - private
/** 生成指定大小的黑白二维码 */
- (UIImage *)createQRImageWithString:(NSString *)string size:(CGSize)size
{
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //    NSLog(@"%@",qrFilter.inputKeys);
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    CIImage *qrImage = qrFilter.outputImage;
    //放大并绘制二维码 (上面生成的二维码很小，需要放大)
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    //翻转一下图片 不然生成的QRCode就是上下颠倒的
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    return codeImage;
}

/** 为二维码改变颜色 */
- (UIImage *)changeColorForQRImage:(UIImage *)image backColor:(UIColor *)backColor frontColor:(UIColor *)frontColor
{
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",[CIImage imageWithCGImage:image.CGImage],
                             @"inputColor0",[CIColor colorWithCGColor:frontColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:backColor.CGColor],
                             nil];
    
    return [UIImage imageWithCIImage:colorFilter.outputImage];
}




#pragma mark - setter and getter
- (UIButton *)shareBtn {
    if (_shareBtn == nil) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setBackgroundColor:[UIColor whiteColor]];
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:kColorMain forState:UIControlStateNormal];
        _shareBtn.layer.cornerRadius = 5;
        _shareBtn.layer.masksToBounds = YES;
        _shareBtn.layer.borderWidth = 1.f;
        _shareBtn.layer.borderColor = kColorMain.CGColor;
        [_shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (UIButton *)saveBtn {
    if (_saveBtn == nil) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setBackgroundColor:kColorMain];
        [_saveBtn setTitle:@"保存到相册" forState:UIControlStateNormal];
        _saveBtn.layer.cornerRadius = 5;
        _saveBtn.layer.masksToBounds = YES;
        [_saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}



@end
