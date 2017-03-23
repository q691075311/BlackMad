//
//  UserInfo.m
//  blackmad
//
//  Created by 陶博 on 2017/3/22.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.birthday = dic[@"birthday"];
        self.city = dic[@"city"];
        self.country = dic[@"country"];
        self.headImage = dic[@"headImage"];
        self.userID = dic[@"id"];
        self.nickname = dic[@"nickname"];
        self.realName = dic[@"realName"];
        self.sex = dic[@"sex"];
    }
    return self;
}

@end
