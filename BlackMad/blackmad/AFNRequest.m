//
//  AFNRequest.m
//  blackmad
//
//  Created by taobo on 17/3/20.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "AFNRequest.h"

@implementation AFNRequest

+ (void)requestWithDataURL:(NSString *)URL WithUserName:(NSString *)userName WithPwsd:(NSString *)pwd WithComplete:(void (^)(NSArray *))block{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString * str = @"http://116.62.7.43/d/phone/register";
    NSString * url = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //设置参数
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    [dic setValue:userName forKey:@"username"];
    [dic setValue:pwd forKey:@"password"];
    [dic setValue:@"ios" forKey:@"regDevice"];
    //字典转为Json字符串
    NSString * parameters = [self dictionaryToJson:dic];
    //发起请求
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray * arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",arr);
        block(arr);
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
