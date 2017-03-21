//
//  BannerListModle.h
//  blackmad
//
//  Created by taobo on 17/3/21.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerListModle : NSObject
/**
 *  结束时间
 */
@property (nonatomic,copy) NSString * bannerEndDate;
/**
 *  开始时间
 */
@property (nonatomic,copy) NSString * bannerStartDate;
/**
 *  bannerID
 */
@property (nonatomic,assign) int bannerID;
/**
 *  banner名字
 */
@property (nonatomic,copy) NSString * bannerName;
/**
 *  banner主题
 */
@property (nonatomic,copy) NSString * bannerSubject;
/**
 *  banner图片
 */
@property (nonatomic,copy) NSString * bannerPicturePath;
/**
 *  banner宣传链接
 */
@property (nonatomic,copy) NSString * bannerWapLink ;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end
