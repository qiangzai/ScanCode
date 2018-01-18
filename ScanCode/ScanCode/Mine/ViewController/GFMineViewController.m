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
#import <StoreKit/StoreKit.h>

@interface GFMineViewController ()<UITableViewDelegate, UITableViewDataSource, SKStoreProductViewControllerDelegate>
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
        NSString *urlStr = @"https://itunes.apple.com/cn/app/安全二维码/id1326611397?l=zh&ls=1&mt=8";
        NSURL *urlToShare = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSArray *activityItems = @[urlToShare,textToShare,imageToShare];
        
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
        [self presentViewController:activityVC animated:YES completion:nil];
    } else if (indexPath.row == 2) {
        
        NSString *appId = @"1326611397";
        // 创建对象
        SKStoreProductViewController *storeVC = [[SKStoreProductViewController alloc] init];
        // 设置代理
        storeVC.delegate = self;
        // 初始化参数
        NSDictionary *dict = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];
        // 跳转App Store页
        [storeVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError * _Nullable error) {
            if (error) {
                NSLog(@"错误信息：%@",error.userInfo);
            }
            else
            {
                // 弹出模态视图
                [self presentViewController:storeVC animated:YES completion:nil];
            }
        }];
    }
    
}

#pragma mark - SKStoreProductViewControllerDelegate
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
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
        _listArray = [[NSArray alloc] initWithObjects:@"关于安全二维码",@"告诉朋友",@"我要评分",strVersion, nil];
    }
    return _listArray;
}
@end
