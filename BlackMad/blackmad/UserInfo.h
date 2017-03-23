//
//  UserInfo.h
//  blackmad
//
//  Created by 陶博 on 2017/3/22.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
/**
 *  生日
 */
@property (nonatomic,copy) NSString * birthday;
/**
 *  城市
 */
@property (nonatomic,copy) NSString * city;
/**
 *  国家
 */
@property (nonatomic,copy) NSString * country;
/**
 *  头像地址
 */
@property (nonatomic,copy) NSString * headImage;
/**
 *  用户ID
 */
@property (nonatomic,strong) NSNumber * userID;
/**
 *  昵称
 */
@property (nonatomic,copy) NSString * nickname;
/**
 *  真是姓名
 */
@property (nonatomic,copy) NSString * realName;
/**
 *  性别
 */
@property (nonatomic,copy) NSString * sex;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
