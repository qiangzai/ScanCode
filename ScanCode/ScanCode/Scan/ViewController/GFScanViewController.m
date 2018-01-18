//
//  GFScanViewController.m
//  ScanCode
//
//  Created by lizhongqiang on 2017/12/6.
//  Copyright © 2017年 lizhongqiang. All rights reserved.
//

#import "GFScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "GFNavigationBarView.h"
#import "UIImage+PSYTint.h"

@interface GFScanViewController ()<AVCaptureMetadataOutputObjectsDelegate, GFNavigationBarViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
/**
 扫描框
 */
@property (nonatomic, strong) UIImageView *scanImgView;
/**
 扫描线 动画
 */
@property (nonatomic, strong) UIImageView *lineImgView;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) GFNavigationBarView *navBarView;

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIView *bottomView;

@end

static float scanWidth = 221.0f;


@implementation GFScanViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.session startRunning];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startAnimation];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.navBarView];
    [self startLoadScanView];
    
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        if (granted) {
            [self performSelectorOnMainThread:@selector(startScanWithCamera) withObject:nil waitUntilDone:NO];
        } else {
            [self performSelectorOnMainThread:@selector(cameraAuthDenied) withObject:nil waitUntilDone:NO];
        }
    }];
}

- (void)startLoadScanView {
    [self startScan];
    
    [self.view addSubview:self.scanImgView];
    [self.view addSubview:self.lineImgView];
    [self.view addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.scanImgView.mas_bottom).with.offset(30);
    }];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.leftView];
    [self.view addSubview:self.rightView];
    [self.view addSubview:self.bottomView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.scanImgView.mas_top);
        make.top.equalTo(self.navBarView.mas_bottom);
    }];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scanImgView.mas_top);
        make.bottom.equalTo(self.scanImgView.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.scanImgView.mas_left);
    }];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scanImgView.mas_top);
        make.bottom.equalTo(self.scanImgView.mas_bottom);
        make.left.equalTo(self.scanImgView.mas_right);
        make.right.equalTo(self.view.mas_right);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
//        make.bottom.left.and.right.equalTo(self.view);
        make.top.equalTo(self.scanImgView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(100);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event
- (void)startScan {
    if (![self.session canAddInput:self.input]) {
        return;
    }
    [self.session addInput:self.input];
    
    if (![self.session canAddOutput:self.output]) {
        return;
    }
    [self.session addOutput:self.output];
    
    self.output.metadataObjectTypes = self.output.availableMetadataObjectTypes;
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    self.previewLayer.frame = self.view.bounds;
}

- (void)startAnimation {
    self.lineImgView.center = CGPointMake(kPSYWidth / 2, (kPSYHeight - scanWidth) / 2);
    [UIView animateWithDuration:3.0f delay:0 options:UIViewAnimationOptionRepeat animations:^{
        self.lineImgView.center = CGPointMake(kPSYWidth / 2, (kPSYHeight + scanWidth - kPSYFitSize(7)) / 2);
    } completion:^(BOOL finished) {
        //                self.lineImgView.center = CGPointMake(kPSYWidth / 2, (kPSYHeight - scanWidth) / 2);
    }];
}

- (void)startScanWithCamera {
    [self.session startRunning];
}

- (void)cameraAuthDenied {
    [GFAlertController presentAlertViewForController:self title:nil message:@"请在手机的“设置-隐私-相机”选项中，允许使用相机。" confirmTitle:@"好" handler:^{
        
    }];
    
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    
    if (![[metadataObjects lastObject] isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
        [self.session startRunning];
        return;
    }
    
    AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
    if (object.stringValue == nil) {
        [self.session startRunning];
    }
    
    NSLog(@"code = %@",object.stringValue);
    NSString *code = object.stringValue;
    
//    [GFAlertController presentAlertViewForController:self title:@"扫描成功" message:code cancelTitle:@"取消" confirmTitle:@"复制此信息" cancel:^{
//
//    } confirm:^{
//        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//        pasteboard.string = code;
//
//    }];
    
  
    if ([Utility isInterNet:code]) {
        [GFAlertController presentAlertViewForController:self title:@"扫描成功" message:code actionTitles:@[@"打开链接",@"复制此信息"] preferredStyle:UIAlertControllerStyleActionSheet handler:^(NSUInteger buttonIndex, NSString *buttonTitle) {
            if (buttonIndex == 1) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:code]];
            } else if (buttonIndex == 2) {
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = code;
            }
        }];
    } else if ([Utility isNumber:code]) {
        [GFAlertController presentAlertViewForController:self title:@"扫描成功" message:code actionTitles:@[@"打电话",@"查快递",@"复制此信息"] preferredStyle:UIAlertControllerStyleActionSheet handler:^(NSUInteger buttonIndex, NSString *buttonTitle) {
            if (buttonIndex == 1) {
                NSString *phone = [NSString stringWithFormat:@"telprompt:%@",code];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
            } else if (buttonIndex == 2) {
//                https://www.baidu.com/s?wd=123456343
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.baidu.com/s?wd%@",code]]];
            } else if (buttonIndex == 3) {
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = code;
            }
        }];
    } else {
        [GFAlertController presentAlertViewForController:self title:@"扫描成功" message:code actionTitles:@[@"打电话",@"打开链接",@"查快递",@"复制此信息"] preferredStyle:UIAlertControllerStyleActionSheet handler:^(NSUInteger buttonIndex, NSString *buttonTitle) {
            if (buttonIndex == 1) {
                NSString *phone = [NSString stringWithFormat:@"telprompt:%@",code];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
            } else if (buttonIndex == 2) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:code]];
            } else if (buttonIndex == 3) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.baidu.com/s?wd%@",code]]];
            } else if (buttonIndex == 4) {
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = code;
            }
        }];
    }
    
    
    
    
//    [self.session stopRunning];
}

#pragma mark - GFNavigationBarViewDelegate
- (void)didSelectFlash {
//    self.navBarView.flashBtn
    if ([self.device hasTorch] && [self.device hasFlash]) {
        [self.device lockForConfiguration:nil];
        self.navBarView.flashBtn.selected = !self.navBarView.flashBtn.selected;
        if (self.navBarView.flashBtn.selected) {
            [self.device setTorchMode:AVCaptureTorchModeOn];
            [self.device setFlashMode:AVCaptureFlashModeOn];
        } else {
            [self.device setTorchMode:AVCaptureTorchModeOff];
            [self.device setFlashMode:AVCaptureFlashModeOff];
        }
        [self.device unlockForConfiguration];
    } else {
        [GFAlertController presentAlertViewForController:self title:@"提示" message:@"当前设备没有闪光灯" confirmTitle:@"我知道了" handler:^{
            
        }];
    }
}

- (void)didSelectPhoto {
    
    UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
    pickerVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pickerVC.delegate = self;
    [self presentViewController:pickerVC animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    CIImage *ciImage = [[CIImage alloc] initWithCGImage:image.CGImage];
    if (ciImage) {
        CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
        NSArray *features = [detector featuresInImage:ciImage];
        if ([features count] > 0) {
            for (CIFeature *feature in features) {
                if (![feature isKindOfClass:[CIQRCodeFeature class]]) {
                    continue;
                }
                CIQRCodeFeature *qrFeature = (CIQRCodeFeature *)feature;
                NSString *code = qrFeature.messageString;
                NSLog(@"读取到的数据是 = %@",code);
                [GFAlertController presentAlertViewForController:self title:@"读取成功" message:code cancelTitle:@"取消" confirmTitle:@"复制此信息" cancel:^{
                    
                } confirm:^{
                    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                    pasteboard.string = code;
                    
                }];
            }
        } else {
            [GFAlertController presentAlertViewForController:self title:@"提示" message:@"未读取到信息" confirmTitle:@"我知道了" handler:^{
                
            }];
        }
    } else {
        [GFAlertController presentAlertViewForController:self title:@"提示" message:@"未读取到信息" confirmTitle:@"我知道了" handler:^{
            
        }];
    }
    
}

#pragma mark - setter and getter
- (AVCaptureDevice *)device {
    if (_device == nil) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}

- (AVCaptureDeviceInput *)input {
    if (_input == nil) {
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }
    return _input;
}

- (AVCaptureMetadataOutput *)output {
    if (_output == nil) {
        _output = [[AVCaptureMetadataOutput alloc] init];
        
        CGRect viewRect = self.view.frame;
        
        CGRect containerRect = self.scanImgView.frame;
        /* 假如你的屏幕的frame 为  x , y,  w, h,  你要设置的矩形快的frame  为  x1, y1, w1, h1.   那么你的 rectOfInterest 应该设置为   CGRectMake(y1/y, x1/x, h1/h, w1/w)
         */
        CGFloat x = containerRect.origin.y / viewRect.size.height;
        CGFloat y = containerRect.origin.x / viewRect.size.width;
        CGFloat width = containerRect.size.height / viewRect.size.height;
        CGFloat height = containerRect.size.width / viewRect.size.width;
        
        _output.rectOfInterest = CGRectMake(x, y, width, height);
    }
    return _output;
}

- (AVCaptureSession *)session {
    if (_session == nil) {
        _session = [[AVCaptureSession alloc] init];
        [_session setSessionPreset:AVCaptureSessionPreset1920x1080];
    }
    return _session;
}

- (AVCaptureVideoPreviewLayer *)previewLayer {
    if (_previewLayer == nil) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return _previewLayer;
}

- (UIImageView *)scanImgView {
    if (_scanImgView == nil) {
        _scanImgView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"badge-scan"] imageWithTintColor:kColorMain]];
        _scanImgView.frame = CGRectMake((kPSYWidth - scanWidth) / 2, (kPSYHeight - scanWidth) / 2, scanWidth, scanWidth);
    }
    return _scanImgView;
}

- (UIImageView *)lineImgView {
    if (_lineImgView == nil) {
        _lineImgView = [[UIImageView alloc] init];
        _lineImgView.image = [[UIImage imageNamed:@"badge-scan-line"] imageWithTintColor:kColorMain];
        _lineImgView.frame = CGRectMake(0, 0, scanWidth, kPSYFitSize(7));
        _lineImgView.center = CGPointMake(kPSYWidth / 2, (kPSYHeight - scanWidth) / 2);
    }
    return _lineImgView;
}

- (UILabel *)tipLabel {
    if (_tipLabel == nil) {
        _tipLabel = [GFGeneralView createLabelFont:[UIFont systemFontOfSize:16] labelColor:[UIColor whiteColor]];
        _tipLabel.text = @"请对准二维码进行扫描";
    }
    return _tipLabel;
}

- (GFNavigationBarView *)navBarView {
    if (_navBarView == nil) {
        _navBarView = [[GFNavigationBarView alloc] initWithFrame:CGRectMake(0, 0, kPSYWidth, 64)];
        _navBarView.delegate = self;
    }
    return _navBarView;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor blackColor];
        _topView.alpha = 0.3f;
    }
    return _topView;
}

- (UIView *)leftView {
    if (_leftView == nil) {
        _leftView = [[UIView alloc] init];
        _leftView.backgroundColor = [UIColor blackColor];
        _leftView.alpha = 0.3f;
    }
    return _leftView;
}

- (UIView *)rightView {
    if (_rightView == nil) {
        _rightView = [[UIView alloc] init];
        _rightView.backgroundColor = [UIColor blackColor];
        _rightView.alpha = 0.3f;
    }
    return _rightView;
}

- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor blackColor];
        _bottomView.alpha = 0.3f;
    }
    return _bottomView;
}


@end
