//
//  LoginUser.m
//  blackmad
//
//  Created by 陶博 on 2017/3/22.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "LoginUser.h"

@implementation LoginUser

static LoginUser * loginUser = nil;
//获取类对象
+ (LoginUser *)shareUser{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginUser = [[LoginUser alloc] init];
    });
    return loginUser;
}
//重写alloc方法
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginUser = [super allocWithZone:zone];
    });
    return loginUser;
}
//初始化属性
- (instancetype)init{
    self = [super init];
    if (self) {
        self.user = [[UserInfo alloc] init];
        self.token = [[NSString alloc] init];
        self.uid = [[NSString alloc] init];
        self.isSelectInterest = [[NSNumber alloc] init];
    }
    return self;
}

@end
