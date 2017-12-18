//
//  GFMineViewController.m
//  ScanCode
//
//  Created by lizhongqiang on 2017/12/6.
//  Copyright © 2017年 lizhongqiang. All rights reserved.
//

#import "GFMineViewController.h"
#import "GFMineTableViewCell.h"
#import "GFAboutViewController.h"

@interface GFMineViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSArray *listArray;

@end

@implementation GFMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置";
    //关于  版本号
    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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



#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GFMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[GFMineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (indexPath.row + 1 == self.listArray.count) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.nameLabel.text = self.listArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        GFAboutViewController *abountVC = [[GFAboutViewController alloc] init];
        [self.navigationController pushViewController:abountVC animated:YES];
    } else if (indexPath.row == 1) {
        NSString *textToShare = @"安全二维码";
        UIImage *imageToShare = [UIImage imageNamed:@"Icon180.png"];
        NSURL *urlToShare = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/安全二维码/id1326611397?l=zh&ls=1&mt=8"];
        NSArray *activityItems = @[urlToShare,textToShare,imageToShare];
        
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
        [self presentViewController:activityVC animated:YES completion:nil];
    }
    
}

#pragma mark - setter and getter
- (UITableView *)mainTableView {
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.rowHeight = 45.f;
        [_mainTableView registerClass:[GFMineTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _mainTableView;
}

- (NSArray *)listArray {
    if (_listArray == nil) {
        NSString *strVersion = [NSString stringWithFormat:@"版本： %@",[Utility getLocalAppVersion]];
        _listArray = [[NSArray alloc] initWithObjects:@"关于安全二维码",@"告诉朋友",strVersion, nil];
    }
    return _listArray;
}
@end
