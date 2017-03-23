//
//  InterestModel.m
//  blackmad
//
//  Created by taobo on 17/3/23.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "InterestModel.h"

@implementation InterestModel


- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.createBy = dic[@"createBy"];
        self.createDate = dic[@"createDate"];
        self.deleteTag = dic[@"deleteTag"];
        self.interestID = dic[@"id"];
        self.interestName = dic[@"interestName"];
        self.pictureAddress = dic[@"pictureAddress"];
        self.sort = dic[@"sort"];
        self.updateBy = dic[@"updateBy"];
        self.updateDate = dic[@"updateDate"];
    }
    return self;
}
@end
