//
//  LoginController.h
//  blackmad
//
//  Created by taobo on 17/3/10.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "BaseController.h"

@interface LoginController : BaseController
/**
 *  跳转来源 （@"ad"为广告页跳转）
 */
@property (nonatomic,copy) NSString * fromFlag;

@end
