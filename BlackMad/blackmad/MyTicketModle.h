//
//  MyTicketModle.h
//  blackmad
//
//  Created by taobo on 17/3/28.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTicketModle : NSObject
/**
 *  券code
 */
@property (nonatomic,copy) NSString *cardCode;
/**
 *  券名字
 */
@property (nonatomic,copy) NSString *cardName;
/**
 *  券的图片地址
 */
@property (nonatomic,copy) NSString *cardPictureAddress;
/**
 *  券的备注
 */
@property (nonatomic,copy) NSString *cardRemark;
/**
 *  券的数量
 */
@property (nonatomic,strong) NSNumber *cardVolumeAmount;
/**
 *  券的过期状态    0是未过期  1是未开始  2是已过期
 */
@property (nonatomic,copy) NSString *cardVolumeStatus;
/**
 *  券的结束时间
 */
@property (nonatomic,copy) NSString *effectiveEndDate;
/**
 *  券的开始时间
 */
@property (nonatomic,copy) NSString *effectiveStartDate;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
