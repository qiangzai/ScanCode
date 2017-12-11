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
    cell.nameLabel.text = self.listArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        GFAboutViewController *abountVC = [[GFAboutViewController alloc] init];
        [self.navigationController pushViewController:abountVC animated:YES];
    } else if (indexPath.row == 1) {
//        UIImage *image = [UIImage imageNamed:@"Icon180.png"];
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[[NSURL URLWithString:@"www.baidu.com"],@"我发现一个好玩的App"] applicationActivities:nil];
        activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
            if (completed) {
                NSLog(@"确定分享");
            }
        };
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
