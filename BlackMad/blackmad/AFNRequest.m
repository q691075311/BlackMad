//
//  AFNRequest.m
//  blackmad
//
//  Created by taobo on 17/3/20.
//  Copyright © 2017年 rongyun. All rights reserved.
//033a74e7e7c9a12593f6431b9019d9cc

#import "AFNRequest.h"

@implementation AFNRequest
//发送注册请求
+ (void)requestWithDataURL:(NSString *)URL WithUserName:(NSString *)userName WithPwsd:(NSString *)pwd WithComplete:(void (^)(NSDictionary *dic))block{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    //请求URL
    NSString * url = [[NSString stringWithFormat:@"%@%@",BASEURL,URL] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSDictionary * dic = @{@"username":userName,
                           @"password":pwd,
                          @"regDevice":@"ios"};
    NSString * parameter = [self dictionaryToJson:dic];
    //发起请求
    [manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        block(dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.userInfo);
    }];
    
}
//登录请求
+ (void)requestLoginWithURL:(NSString *)URL WithUserName:(NSString *)userName WithPwsd:(NSString *)pwd WithComplete:(void (^)(NSDictionary *dic))block{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    //请求URL
    NSString * url = [[NSString stringWithFormat:@"%@%@",BASEURL,URL] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSDictionary * dic = @{@"username":userName,
                           @"password":pwd};
    NSString * parameter = [self dictionaryToJson:dic];
    //发起请求
    [manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([self judgeStatusCodeWithDic:dic]) {
            block(dic);
        }else{
            return;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.userInfo);
    }];
}
//发送用户信息请求
+ (void)requestUserInfoWithURL:(NSString *)URL WithToken:(NSString *)token WithUid:(NSString *)uid WithComplete:(void (^)(NSDictionary *))block{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    //请求URL
    NSString * url = [[NSString stringWithFormat:@"%@%@",BASEURL,URL] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //设置请求头
    
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue:uid forHTTPHeaderField:@"uid"];
    //发起请求
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([self judgeStatusCodeWithDic:dic]) {
            block(dic);
        }else{
            return;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.userInfo);
    }];
}
//发送兴趣列表请求
+ (void)requestInterestWithUrl:(NSString *)URL WithToken:(NSString *)token WithUid:(NSString *)uid WithComplete:(void (^)(NSDictionary * dic))block{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    //请求URL
    NSString * url = [[NSString stringWithFormat:@"%@%@",BASEURL,URL] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //设置请求头
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue:uid forHTTPHeaderField:@"uid"];
    //发起请求
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([self judgeStatusCodeWithDic:dic]) {
            block(dic);
        }else{
            return;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.userInfo);
    }];
    
}
//发送保存兴趣的请求
+ (void)requestSaveInterestWithUrl:(NSString *)URL WithToken:(NSString *)token WithUid:(NSString *)uid WithBody:(NSString *)requestBody WithComplete:(void (^)(NSDictionary *))block{
    AFHTTPSessionManager * manager = [self getHttpManager];
    //请求URL
    NSString * url = [[NSString stringWithFormat:@"%@%@",BASEURL,URL] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //设置请求头
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue:uid forHTTPHeaderField:@"uid"];
    //设置请求body
    NSDictionary * body = @{@"interest":requestBody};
    NSString * parameters = [self dictionaryToJson:body];
    //发起请求
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([self judgeStatusCodeWithDic:dic]) {
            block(dic);
        }else{
            return;
        }
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
        if ([self judgeStatusCodeWithDic:dic]) {
            block(dic);
        }else{
            return;
        }
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
        if ([self judgeStatusCodeWithDic:dic]) {
            block(dic);
        }else{
            return;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.userInfo);
    }];
    
}
//字典转为Json字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    //去除Json字符串中的换行和空格
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    return mutStr;
}
//返回状态判断
+ (BOOL)judgeStatusCodeWithDic:(NSDictionary *)dic{
    //判断返回的状态码statusCode
    //0--登录成功
    //4301--用户不存在
    //4302--用户密码错误
    if (![dic[@"statusCode"] isEqualToString:@"0"]) {
        [SVProgressHUD dismiss];
        NSString * errorStr = dic[@"statusMessage"];
        [SVProgressHUD showErrorWithStatus:errorStr];
        return NO;
    }else{
        return YES;
    }
}
+ (AFHTTPSessionManager *)getHttpManager{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    return manager;
}
@end
