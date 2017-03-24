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
 *  发送兴趣列表请求
 */
+ (void)requestInterestWithUrl:(NSString *)URL WithToken:(NSString *)token WithUid:(NSString *)uid WithComplete:(void(^)(NSDictionary *dic))block;
/**
 *  发送保存兴趣的请求
 */
+ (void)requestSaveInterestWithUrl:(NSString *)URL WithToken:(NSString *)token WithUid:(NSString *)uid WithBody:(NSString *)requestBody WithComplete:(void(^)(NSDictionary *dic))block;
/**
 *  发送产品列表的请求
 */
+ (void)requestProductListWithURL:(NSString *)URL WithCurrentPage:(NSString *)currentPage WithProductTypeId:(NSString *)productTypeId WithComplete:(void(^)(NSDictionary *dic))block;
/**
 *  发送我的券的请求
 */
+ (void)requestMyTicketWithURL:(NSString *)URL WithpageNum:(NSString *)pageNum WithToken:(NSString *)token WithUID:(NSString *)uid WithComplete:(void (^)(NSDictionary *dic))block;
/**
 *  发送保存用户信息的请求
 */
+ (void)requestSaveUserInfoWithURL:(NSString *)URL WithUserInfo:(NSDictionary *)InfoDic WithComplete:(void (^)(NSDictionary *dic))block;
/**
 *  发送上传头像的请求
 */
+ (void)requestUpheadImageWithURL:(NSString *)URL WithImage:(UIImage *)image WithComplete:(void(^)(NSDictionary *dic))block;
/**
 *  发送产品类型请求
 */
+ (void)requestWithDataURL:(NSString *)URL WithComplete:(void(^)(NSDictionary *dic))block;
/**
 *  banber产品列表
 */
+ (void)requestWithBannerURL:(NSString *)URL WithComplete:(void (^)(NSDictionary *dic))block;
/**
 *  字典转为Json字符串
 */
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;
@end
