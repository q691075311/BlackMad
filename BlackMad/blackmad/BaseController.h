//
//  BaseController.h
//  blackmad
//
//  Created by taobo on 17/3/8.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavBar.h"


@interface BaseController : UIViewController
/**
 *  接收上个界面传的数据
 */
@property (nonatomic,strong) NSDictionary * userInfo;
/**
 *  导航栏
 */
@property (nonatomic,strong) NavBar * navBar;
/**
 *  跳转页面
 */
- (BaseController *)pushToController:(NSString *)controllerID
                      WithStoyBordID:(NSString *)stoyBordID
                            WithForm:(BaseController *)formController
                            WithInfo:(NSDictionary *)info;
/**
 *  NavBar
 */
- (void)touchLeftBtn;
- (void)touchRigthBtn;

@end
