//
//  ClassTypeList.m
//  blackmad
//
//  Created by taobo on 17/6/20.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "ClassTypeList.h"

@implementation ClassTypeList

- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.pictureAddress = dic[@"pictureAddress"];
        self.typeName = dic[@"typeName"];
        self.ID = dic[@"id"];
    }
    return self;
}

@end
