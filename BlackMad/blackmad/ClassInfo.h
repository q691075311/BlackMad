//
//  ClassInfo.h
//  blackmad
//
//  Created by taobo on 17/6/14.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassInfo : NSObject
/**
 *  活动结束时间
 */
@property (nonatomic,copy) NSString * activityEndDate;
/**
 *  活动开始时间
 */
@property (nonatomic,copy) NSString * activityStartDate;
/**
 *  活动ID
 */
@property (nonatomic,copy) NSString * ID;
/**
 *  活动名字
 */
@property (nonatomic,copy) NSString * productName;
/**
 *  活动的介绍
 */
@property (nonatomic,copy) NSString * productSubject;
/**
 *  活动的图片地址
 */
@property (nonatomic,copy) NSString * promotionalPicturePath;
/**
 *  活动的链接
 */
@property (nonatomic,copy) NSString * promotionalWapLink;

- (instancetype)initWithdic:(NSDictionary *)dic;

@end
