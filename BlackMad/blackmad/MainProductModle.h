//
//  MainProductModle.h
//  blackmad
//
//  Created by taobo on 17/3/27.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainProductModle : NSObject
/**
 *  活动结束时间
 */
@property (nonatomic,copy) NSString * activityEndDate;
/**
 *  活动开始时间
 */
@property (nonatomic,copy) NSString * activityStartDate;
/**
 *  产品ID
 */
@property (nonatomic,strong) NSNumber * productID;
/**
 *  产品名字
 */
@property (nonatomic,copy) NSString * productName;
/**
 *  产品主题
 */
@property (nonatomic,copy) NSString * productSubject;
/**
 *  产品图片
 */
@property (nonatomic,copy) NSString * promotionalPicturePath;
/**
 *  产品宣传链接
 */
@property (nonatomic,copy) NSString * promotionalWapLink;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
