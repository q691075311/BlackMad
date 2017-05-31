//
//  AppDelegate.m
//  blackmad
//
//  Created by taobo on 17/3/8.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LaunchController.h"
#import "LoginController.h"
#import "BaseController.h"
#import "IQKeyboardManager.h"
#import "ClassController.h"
#import "UserInfoController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"%@",NSHomeDirectory());
    [self initIQKeyboard];
    NSDictionary * dic = [[NSBundle mainBundle] infoDictionary];
    if ([dic[@"CFBundleVersion"] isEqualToString:[USERDEF objectForKey:@"version"]]) {
        //不是第一次启动
        [self everLaunch];
    }else{
        [USERDEF setObject:dic[@"CFBundleVersion"] forKey:@"version"];
        [USERDEF synchronize];
        [self firstLaunch];
    }
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark--第一次启动
- (void)firstLaunch{
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    LaunchController * vc = [sb instantiateViewControllerWithIdentifier:@"LaunchController"];
    self.window.rootViewController = vc;
}
#pragma mark--不是第一次启动
- (void)everLaunch{
    [Tool configTabBarItem];
//    //获取Storyboard
//    UIStoryboard * mainsb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    UIStoryboard * classsb = [UIStoryboard storyboardWithName:@"class" bundle:[NSBundle mainBundle]];
//    UIStoryboard * usersb = [UIStoryboard storyboardWithName:@"User" bundle:[NSBundle mainBundle]];
//    self.window.backgroundColor = [UIColor whiteColor];
//    //创建TabBar
//    UITabBarController * tb = [Tool initTabbarBaseInfo];
//    //创建精选视图
//    ViewController * mainVC = [mainsb instantiateViewControllerWithIdentifier:@"ViewController"];
//    UINavigationController * mainNav = [[UINavigationController alloc] initWithRootViewController:mainVC];
//    mainVC.tabBarItem.title = @"精选";
//    [Tool setTabBarItemPropertyWithController:mainVC
//                                    withImage:[UIImage imageNamed:@"mainnotselecter"]
//                            withSelecterImage:[UIImage imageNamed:@"mainselecter"]];
//    //创建分类的视图
//    ClassController * classVC = [classsb instantiateViewControllerWithIdentifier:@"ClassController"];
//    UINavigationController * classNav = [[UINavigationController alloc] initWithRootViewController:classVC];
//    classVC.tabBarItem.title=@"分类";
//    [Tool setTabBarItemPropertyWithController:classVC
//                                    withImage:[UIImage imageNamed:@"classnotselecter"]
//                            withSelecterImage:[UIImage imageNamed:@"classselecter"]];
//    //创建个人中心的视图
//    UserInfoController * userVC = [usersb instantiateViewControllerWithIdentifier:@"UserInfoController"];
//    UINavigationController * userNav = [[UINavigationController alloc] initWithRootViewController:userVC];
//    userVC.tabBarItem.title=@"我";
//    [Tool setTabBarItemPropertyWithController:userVC
//                                    withImage:[UIImage imageNamed:@"usernotselecter"]
//                            withSelecterImage:[UIImage imageNamed:@"userselecter"]];
//    
//    [tb addChildViewController:mainNav];
//    [tb addChildViewController:classNav];
//    [tb addChildViewController:userNav];
//    self.window.rootViewController = tb;
}
#pragma mark--控制键盘弹出的三方库
- (void)initIQKeyboard{
    IQKeyboardManager * manger = [IQKeyboardManager sharedManager];
    manger.enable = YES;
    manger.shouldResignOnTouchOutside = YES;
    manger.shouldToolbarUsesTextFieldTintColor = NO;
    manger.enableAutoToolbar = NO;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
