//
//  MyTicketModle.m
//  blackmad
//
//  Created by taobo on 17/3/28.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "MyTicketModle.h"

@implementation MyTicketModle
- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.ID = (NSNumber *)dic[@"id"];
        self.cardContent = dic[@"cardContent"];
        self.cardName = dic[@"cardName"];
        self.cardPictureAddress = dic[@"cardPictureAddress"];
        self.cardRemark = dic[@"cardRemark"];
        self.cardType = dic[@"cardType"];
        self.cardVolumeOriginalPrice = (NSNumber *)dic[@"cardVolumeOriginalPrice"];
        self.cardVolumePresentPrice = (NSNumber *)dic[@"cardVolumePresentPrice"];
        self.collection = (BOOL)dic[@"collection"];
    }
    return self;
}


@end
