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
+ (void)requestWithDataURL:(NSString *)URL WithUserName:(NSString *)userName WithPwsd:(NSString *)pwd withVerifyId:(NSString *)verifyId withVerifyCode:(NSString *)verifyCode withSMSCode:(NSString *)smsCode WithComplete:(void(^)(NSDictionary *dic))block;
/**
 *  发送登录请求
 */
+ (void)requestLoginWithURL:(NSString *)URL withVerifyID:(NSString *)verifyID withVerifyCode:(NSString *)verifyCode WithUserName:(NSString *)userName WithPwsd:(NSString *)pwd WithComplete:(void(^)(NSDictionary *dic))block;
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
+ (void)requestUpheadImageWithURL:(NSString *)URL WithImage:(NSString *)imageStr WithComplete:(void(^)(NSDictionary *dic))block;
/**
 *  发送产品类型请求
 */
+ (void)requestWithDataURL:(NSString *)URL WithComplete:(void(^)(NSDictionary *dic))block;
/**
 *  banber产品列表
 */
+ (void)requestWithBannerURL:(NSString *)URL WithComplete:(void (^)(NSDictionary *dic))block;
/**
 *  获取图形验证码    注释:Using 0 :新用户注册，3：登录
 */
+ (void)getImageVerifyCodeWithUseingID:(NSString *)useingID WithComplete:(void (^)(NSDictionary *dic))block;

/**
 *  短信验证码请求
 */
+ (void)getSMSVerifyCodeWithUsering:(NSString *)usering withPhone:(NSString *)phone withUserId:(NSString *)userId withComplete:(void (^)(NSDictionary *dic))block;
/**
 *  推荐-产品Item
 */
+ (void)recommendProductItemWithCurrentPage:(NSString *)currentPage withOrderGuize:(NSString *)orderGuize withProductTypeId:(NSString *)productTypeId withComplete:(void (^)(NSDictionary *dic))block;


/**
 *  投诉建议
 */
+ (void)complaintsWithContent:(NSString *)content withComplete:(void (^)(NSDictionary *dic))block;
/**
 *  分类-活动
 */
+ (void)classActWithComplete:(void (^)(id))block;



/**
 *  字典转为Json字符串
 */
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;

@end
