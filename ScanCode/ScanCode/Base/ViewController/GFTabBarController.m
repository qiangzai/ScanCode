//
//  GFTabBarController.m
//  ScanCode
//
//  Created by lzq-psylife on 2017/12/6.
//  Copyright © 2017年 lizhongqiang. All rights reserved.
//

#import "GFTabBarController.h"
#import "GFScanViewController.h"
#import "GFMineViewController.h"
#import "UIImage+PSYTint.h"
#import "GFCreateQRViewController.h"


@interface GFTabBarController ()<UITabBarControllerDelegate>

@end

@implementation GFTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)init {
    self = [super init];
    if (self) {
        GFScanViewController *scanVC = [[GFScanViewController alloc] init];
        scanVC.tabBarItem.image = [UIImage imageNamed:@"scan"];
        scanVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"scan"] imageWithTintColor:kColorMain];
        scanVC.tabBarItem.title = @"扫描";
        
        GFCreateQRViewController *QRVC = [[GFCreateQRViewController alloc] init];
        QRVC.tabBarItem.image = [UIImage imageNamed:@"QR"];
        QRVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"QR"] imageWithTintColor:kColorMain];
        QRVC.tabBarItem.title = @"生成二维码";
        
        GFMineViewController *mineVC = [[GFMineViewController alloc] init];
        mineVC.tabBarItem.image = [UIImage imageNamed:@"setup"];
        mineVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"setup"] imageWithTintColor:kColorMain];
        mineVC.tabBarItem.title = @"设置";
        
        self.viewControllers = [NSArray arrayWithObjects:scanVC,QRVC,mineVC,nil];
        self.selectedIndex = 0;
        self.tabBar.translucent = YES;
        self.delegate = self;
        self.tabBar.tintColor = kColorMain;
    }
    return self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (tabBarController.selectedIndex == 0) {
        self.navigationItem.title = nil;
    } else if (tabBarController.selectedIndex == 1) {
        self.navigationItem.title = @"生成二维码";
    } else if (tabBarController.selectedIndex == 2) {
        self.navigationItem.title = @"设置";
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
