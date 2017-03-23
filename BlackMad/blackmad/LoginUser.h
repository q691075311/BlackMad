//
//  LoginUser.h
//  blackmad
//
//  Created by 陶博 on 2017/3/22.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
@interface LoginUser : NSObject
/**
 *  存储用户信息
 */
@property (nonatomic,strong) UserInfo * user;
/**
 *  用户token
 */
@property (nonatomic,copy) NSString * token;
/**
 *  用户的ID
 */
@property (nonatomic,copy) NSString * uid;
/**
 *  用户是否需要兴趣调查
 */
@property (nonatomic,strong) NSNumber * isSelectInterest ;

+ (LoginUser *)shareUser;

@end
