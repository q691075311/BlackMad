//
//  ClassInfo.m
//  blackmad
//
//  Created by taobo on 17/6/14.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "ClassInfo.h"

@implementation ClassInfo

- (instancetype)initWithdic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.activityEndDate = dic[@"activityEndDate"];
        self.activityStartDate = dic[@"activityStartDate"];
        self.ID = dic[@"id"];
        self.productName = dic[@"productName"];
        self.productSubject = dic[@"productSubject"];
        self.promotionalPicturePath = dic[@"promotionalPicturePath"];
        self.promotionalWapLink = dic[@"promotionalWapLink"];
    }
    return self;
}

@end
