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
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}


@end
