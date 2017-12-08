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

@interface GFTabBarController ()

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
        scanVC.tabBarItem.title = @"扫描";
        
        GFMineViewController *mineVC = [[GFMineViewController alloc] init];
        mineVC.tabBarItem.title = @"设置";
        
        self.viewControllers = [NSArray arrayWithObjects:scanVC,mineVC,nil];
        self.selectedIndex = 0;
        self.tabBar.translucent = YES;
    }
    return self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
