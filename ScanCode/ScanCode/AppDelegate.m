//
//  AppDelegate.m
//  ScanCode
//
//  Created by lizhongqiang on 2017/11/13.
//  Copyright © 2017年 lizhongqiang. All rights reserved.
//5a2e5697f43e483196000075

#import "AppDelegate.h"
#import "GFTabBarController.h"
#import "GFBaseNavigationController.h"
#import "GFScanViewController.h"
#import <UMMobClick/MobClick.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    [self firstRequest];
    
    
    GFTabBarController *tabbar = [[GFTabBarController alloc] init];
    GFBaseNavigationController *nav = [[GFBaseNavigationController alloc] initWithRootViewController:tabbar];
    self.window.rootViewController = nav;
    
    [self configUMengMobClick];
    
    
    return YES;
}


#pragma mark - UMeng
- (void)configUMengMobClick {
    UMConfigInstance.appKey = @"5a2e5697f43e483196000075";
    UMConfigInstance.channelId = @"App Store";
    [MobClick setAppVersion:[Utility getLocalAppVersion]];
    [MobClick startWithConfigure:UMConfigInstance];
    
#ifdef DEBUG
    [MobClick setLogEnabled:YES];
#else
    //nothing
#endif
    
}

- (void)firstRequest {
    //发送网络请求 用于第一次安装启动时弹出网络授权
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url];
    [task resume];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    UIViewController *viewController = [Utility getCurrentVC];
    if ([viewController isKindOfClass:[GFScanViewController class]]) {
        NSLog(@"执行动画");
        GFScanViewController *scanVC = (GFScanViewController *)viewController;
        [scanVC startAnimation];
    }
    
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
