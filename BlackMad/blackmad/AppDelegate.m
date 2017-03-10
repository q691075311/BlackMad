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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"%@",NSHomeDirectory());
//    NSDictionary * dic = [[NSBundle mainBundle] infoDictionary];
//    if ([dic[@"CFBundleVersion"] isEqualToString:[USERDEF objectForKey:@"version"]]) {
//        //不是第一次启动
//        [self everLaunch];
//    }else{
//        [USERDEF setObject:dic[@"CFBundleVersion"] forKey:@"version"];
//        [USERDEF synchronize];
//        [self firstLaunch];
//    }
    [self everLaunch];
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark--第一次启动
- (void)firstLaunch{
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    LaunchController * vc = [sb instantiateViewControllerWithIdentifier:@"LaunchController"];
//    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = vc;
}
#pragma mark--不是第一次启动
- (void)everLaunch{
    NSString * loginName = [USERDEF objectForKey:@"loginname"];
    NSString * pwd = [USERDEF objectForKey:@"pwd"];
    if (loginName && pwd) {
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        ViewController * vc = [sb instantiateViewControllerWithIdentifier:@"ViewController"];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
        self.window.rootViewController = nav;
    }else{
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        LoginController * vc = [sb instantiateViewControllerWithIdentifier:@"LoginController"];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
        self.window.rootViewController = nav;
    }
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
