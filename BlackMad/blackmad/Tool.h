//
//  Tool.h
//  blackmad
//
//  Created by taobo on 17/5/31.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject

/**
 *  模态弹出登录界面
 *
 *  @param str 登录类型
 */
+ (void)presentLoginViewWithStr:(NSString *)str WithViewController:(UIViewController *)viewController;

/**
 *  初始化一个tabbar
 */
+ (UITabBarController *)initTabbarBaseInfo;
/**
 *  设置tabBarItem的字体图片
 */
+ (void)setTabBarItemPropertyWithController:(UIViewController *)viewController withImage:(UIImage *)image withSelecterImage:(UIImage *)selecterImage;
/**
 *  主题红色
 */
+ (UIColor *)appRedColor;
/**
 *  黑色字体
 */
+ (UIColor *)appBlackTextColor;
/**
 *  灰色
 */
+ (UIColor *)appGrayColor;
/**
 *  动态计算lable的高度
 */
+ (CGFloat)getLableHeigthWithText:(NSString *)str withLableWidth:(float)width withTextFontOfSize:(float)size;
/**
 *  配置TabBarItem
 */
+ (void)configTabBarItem;


@end
