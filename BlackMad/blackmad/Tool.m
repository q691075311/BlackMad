//
//  Tool.m
//  blackmad
//
//  Created by taobo on 17/5/31.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "Tool.h"
#import "LoginController.h"
#import "ViewController.h"
#import "UserInfoController.h"
#import "ClassController.h"



@implementation Tool

+(void)presentLoginViewWithStr:(NSString *)str WithViewController:(UIViewController *)viewController{
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    LoginController * vc = [sb instantiateViewControllerWithIdentifier:@"LoginController"];
    if ([str isEqualToString:@"isReg"]) {
        vc.fromFlag = @"ad";
    }
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [viewController.navigationController presentViewController:nav animated:YES completion:nil];
}

+ (UITabBarController *)initTabbarBaseInfo{
    //初始化一个tabBar控制器
    UITabBarController *tb=[[UITabBarController alloc]init];
    //设置字体大小颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[self appgrayColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:10],NSFontAttributeName,nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[self appRedColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:10],NSFontAttributeName,nil] forState:UIControlStateSelected];
    return tb;
}

+ (void)setTabBarItemPropertyWithController:(UIViewController *)viewController withImage:(UIImage *)image withSelecterImage:(UIImage *)selecterImage{
    //设置选中图片
    viewController.tabBarItem.selectedImage = [selecterImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIColor *)appRedColor{
    UIColor * red = [UIColor colorWithRed:205/255.0 green:48/255.0 blue:44/255.0 alpha:1];
    return red;
}
+ (UIColor *)appgrayColor{
    UIColor * red = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    return red;
}
+ (void)configTabBarItem{
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    //获取Storyboard
    UIStoryboard * mainsb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIStoryboard * classsb = [UIStoryboard storyboardWithName:@"class" bundle:[NSBundle mainBundle]];
    UIStoryboard * usersb = [UIStoryboard storyboardWithName:@"User" bundle:[NSBundle mainBundle]];
    //创建TabBar
    UITabBarController * tb = [Tool initTabbarBaseInfo];
    //创建精选视图
    ViewController * mainVC = [mainsb instantiateViewControllerWithIdentifier:@"ViewController"];
    UINavigationController * mainNav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    mainVC.tabBarItem.title = @"精选";
    [Tool setTabBarItemPropertyWithController:mainVC
                                    withImage:[UIImage imageNamed:@"mainnotselecter"]
                            withSelecterImage:[UIImage imageNamed:@"mainselecter"]];
    //创建分类的视图
    ClassController * classVC = [classsb instantiateViewControllerWithIdentifier:@"ClassController"];
    UINavigationController * classNav = [[UINavigationController alloc] initWithRootViewController:classVC];
    classVC.tabBarItem.title=@"分类";
    [Tool setTabBarItemPropertyWithController:classVC
                                    withImage:[UIImage imageNamed:@"classnotselecter"]
                            withSelecterImage:[UIImage imageNamed:@"classselecter"]];
    //创建个人中心的视图
    UserInfoController * userVC = [usersb instantiateViewControllerWithIdentifier:@"UserInfoController"];
    UINavigationController * userNav = [[UINavigationController alloc] initWithRootViewController:userVC];
    userVC.tabBarItem.title=@"我";
    [Tool setTabBarItemPropertyWithController:userVC
                                    withImage:[UIImage imageNamed:@"usernotselecter"]
                            withSelecterImage:[UIImage imageNamed:@"userselecter"]];
    
    [tb addChildViewController:mainNav];
    [tb addChildViewController:classNav];
    [tb addChildViewController:userNav];
    window.rootViewController = tb;
}

@end
