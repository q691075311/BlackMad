//
//  BannerListModle.m
//  blackmad
//
//  Created by taobo on 17/3/21.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "BannerListModle.h"

@implementation BannerListModle
- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.bannerEndDate = dic[@"activityEndDate"];
        self.bannerStartDate = dic[@"activityStartDate"];
        self.bannerID = (int)dic[@"id"];
        self.bannerName = dic[@"productName"];
        self.bannerSubject = dic[@"productSubject"];
        self.bannerPicturePath = dic[@"promotionalPicturePath"];
        self.bannerWapLink = dic[@"promotionalWapLink"];
    }
    return self;
}
@end
