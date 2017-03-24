//
//  MainBtnListModle.h
//  blackmad
//
//  Created by taobo on 17/3/21.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainBtnListModle : NSObject
/**
 *  产品列表ID
 */
@property (nonatomic,strong) NSNumber *productListID;
/**
 *  产品列表图片
 */
@property (nonatomic,copy) NSString * productListImage;
/**
 *  产品列表标题
 */
@property (nonatomic,copy) NSString * productListTitle;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end
