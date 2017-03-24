
//
//  MainBtnListModle.m
//  blackmad
//
//  Created by taobo on 17/3/21.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "MainBtnListModle.h"

@implementation MainBtnListModle

- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.productListID = dic[@"id"];
        self.productListImage = dic[@"pictureAddress"];
        self.productListTitle = dic[@"typeName"];
    }
    return self;
}

@end
