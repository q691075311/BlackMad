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
 *  券内容
 */
@property (nonatomic,copy) NSString *cardContent;
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
 *  券的类型
 */
@property (nonatomic,strong) NSString *cardType;
/**
 *  券的原始价格
 */
@property (nonatomic,assign) NSNumber * cardVolumeOriginalPrice;
/**
 *  券的当前价格
 */
@property (nonatomic,assign) NSNumber * cardVolumePresentPrice;
/**
 *  券的ID
 */
@property (nonatomic,assign) NSNumber * ID;
/**
 *  券是否收藏
 */
@property (nonatomic,assign) BOOL collection;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
