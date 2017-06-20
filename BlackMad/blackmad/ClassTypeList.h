//
//  ClassTypeList.h
//  blackmad
//
//  Created by taobo on 17/6/20.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassTypeList : NSObject
/**
 *  类型的图片
 */
@property (nonatomic,copy) NSString * pictureAddress;
/**
 *  类型名称
 */
@property (nonatomic,copy) NSString * typeName;
/**
 *  类型ID
 */
@property (nonatomic,strong) NSNumber * ID;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
