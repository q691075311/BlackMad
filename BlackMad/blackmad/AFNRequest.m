//
//  AFNRequest.m
//  blackmad
//
//  Created by taobo on 17/3/20.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "AFNRequest.h"

@implementation AFNRequest
//发送注册请求
+ (void)requestWithDataURL:(NSString *)URL WithUserName:(NSString *)userName WithPwsd:(NSString *)pwd WithComplete:(void (^)(NSArray *))block{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
<<<<<<< HEAD
    NSString * str = @"http://116.62.7.43/d/phone/register";
    NSString * url = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //设置参数
=======
    //请求URL
    NSString * url = [[NSString stringWithFormat:@"%@%@",BASEURL,URL] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //设置请求参数
>>>>>>> 8e37b5bb3d505ffba5a7fccbbc30e4d2db7a77a0
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    [dic setValue:userName forKey:@"username"];
    [dic setValue:pwd forKey:@"password"];
    [dic setValue:@"ios" forKey:@"regDevice"];
<<<<<<< HEAD
    //字典转为Json字符串
    NSString * parameters = [self dictionaryToJson:dic];
    //发起请求
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@",uploadProgress);
=======
    NSString * parameters = [self dictionaryToJson:dic];
    //发起请求
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
>>>>>>> 8e37b5bb3d505ffba5a7fccbbc30e4d2db7a77a0
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray * arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",arr);
        block(arr);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.userInfo);
    }];
    
}
//发送产品类型请求
+ (void)requestWithDataURL:(NSString *)URL WithComplete:(void (^)(NSDictionary *dic))block{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //请求URL
    NSString * url = [[NSString stringWithFormat:@"%@%@",BASEURL,URL] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //发起请求
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        block(dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.userInfo);
    }];
}
//发送banber产品列表
+ (void)requestWithBannerURL:(NSString *)URL WithComplete:(void (^)(NSDictionary * dic))block{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //请求URL
    NSString * url = [[NSString stringWithFormat:@"%@%@",BASEURL,URL] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //发起请求
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        block(dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.userInfo);
    }];
    
}
//字典转为Json字符串
+ (NSString *)dictionaryToJson:(NSMutableDictionary *)dic
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    //去除Json字符串中的换行和空格
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" "withString:@""options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n"withString:@""options:NSLiteralSearch range:range2];
    return mutStr;
}

@end
