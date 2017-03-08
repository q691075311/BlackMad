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
 *  NavBar
 */
- (void)touchLeftBtn;
- (void)touchRigthBtn;

@end
