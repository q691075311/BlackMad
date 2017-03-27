//
//  MainProductModle.m
//  blackmad
//
//  Created by taobo on 17/3/27.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "MainProductModle.h"

@implementation MainProductModle

- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.activityEndDate = dic[@"activityEndDate"];
        self.activityStartDate = dic[@"activityStartDate"];
        self.productID = dic[@"id"];
        self.productName = dic[@"productName"];
        self.productSubject = dic[@"productSubject"];
        self.promotionalPicturePath = dic[@"promotionalPicturePath"];
        self.promotionalWapLink = dic[@"promotionalWapLink"];
    }
    return self;
}

@end
