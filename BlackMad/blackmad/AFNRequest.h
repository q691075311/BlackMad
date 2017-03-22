//
//  AFNRequest.h
//  blackmad
//
//  Created by taobo on 17/3/20.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface AFNRequest : NSObject
/**
 *  发送注册请求
 */
+ (void)requestWithDataURL:(NSString *)URL WithUserName:(NSString *)userName WithPwsd:(NSString *)pwd WithComplete:(void(^)(NSDictionary *dic))block;
/**
 *  发送登录请求
 */
+ (void)requestLoginWithURL:(NSString *)URL WithUserName:(NSString *)userName WithPwsd:(NSString *)pwd WithComplete:(void(^)(NSDictionary *dic))block;
/**
 *  发送用户信息请求
 */
+ (void)requestUserInfoWithURL:(NSString *)URL WithToken:(NSString *)token WithUid:(NSString *)uid WithComplete:(void(^)(NSDictionary *dic))block;

/**
 *  发送产品类型请求
 *
 *  @param URL
 *  @param block 回调
 */
+ (void)requestWithDataURL:(NSString *)URL WithComplete:(void(^)(NSDictionary *dic))block;
/**
 *  banber产品列表
 *
 *  @param URL   URL
 *  @param block 回调
 */
+ (void)requestWithBannerURL:(NSString *)URL WithComplete:(void (^)(NSDictionary *dic))block;
/**
 *  字典转为Json字符串
 *
 *  @param dic
 *
 *  @return
 */
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;
@end
