//
//  InterestModel.h
//  blackmad
//
//  Created by taobo on 17/3/23.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InterestModel : NSObject
@property (nonatomic,copy) NSString *createBy;
@property (nonatomic,copy) NSString *createDate;
@property (nonatomic,copy) NSString *deleteTag;
@property (nonatomic,strong) NSNumber *interestID;
/**
 *  兴趣名字
 */
@property (nonatomic,copy) NSString *interestName;
/**
 *  兴趣图片地址
 */
@property (nonatomic,copy) NSString *pictureAddress;
@property (nonatomic,strong) NSNumber *sort;
@property (nonatomic,copy) NSString *updateBy;
@property (nonatomic,copy) NSString *updateDate;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end
