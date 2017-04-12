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
        if ([self judgeStatusCodeWithDic:dic]) {
            block(dic);
        }else{
            return;
        }
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
//发送产品列表的请求
+ (void)requestProductListWithURL:(NSString *)URL WithCurrentPage:(NSString *)currentPage WithProductTypeId:(NSString *)productTypeId WithComplete:(void (^)(NSDictionary *))block{
    AFHTTPSessionManager * manager = [self getHttpManager];
    //请求URL
    NSString * url = [[NSString stringWithFormat:@"%@%@",BASEURL,URL] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //设置请求body
    if ([productTypeId isEqualToString:@"-1"]) {
        productTypeId = @"";
    }
    NSDictionary * dic = @{@"currentPage":currentPage};
    NSDictionary * body = @{@"page":dic,
                            @"orderGuize":@"create_datedesc",
                            @"productTypeId":productTypeId};
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
    AFHTTPSessionManager * manager = [self getHttpManager];
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
    AFHTTPSessionManager * manager = [self getHttpManager];
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

//发送我的券的请求
+ (void)requestMyTicketWithURL:(NSString *)URL WithpageNum:(NSString *)pageNum WithToken:(NSString *)token WithUID:(NSString *)uid WithComplete:(void (^)(NSDictionary *dic))block{
    AFHTTPSessionManager * manager = [self getHttpManager];
    //请求URL
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    NSString * url = [[NSString stringWithFormat:@"%@%@",BASEURL,URL] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //设置请求头
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue:uid forHTTPHeaderField:@"uid"];
    //设置请求body
    NSInteger intter = [pageNum integerValue];
    NSDictionary * dic = @{@"currentPage":@(intter)};
    NSDictionary * parameterDic = @{@"page":dic};
    NSString * parameterStr = [self dictionaryToJson:parameterDic];
    //发起请求
    [manager POST:url parameters:parameterStr progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([self judgeStatusCodeWithDic:dic]) {
            block(dic);
        }else{
            return;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.userInfo);
    }];;
}
//发送保存用户信息的请求
+ (void)requestSaveUserInfoWithURL:(NSString *)URL WithUserInfo:(NSDictionary *)InfoDic WithComplete:(void (^)(NSDictionary *dic))block{
    AFHTTPSessionManager * manager = [self getHttpManager];
    //请求URL
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    NSString * url = [[NSString stringWithFormat:@"%@%@",BASEURL,URL] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //设置请求头
    [manager.requestSerializer setValue:[LoginUser shareUser].token forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue:[LoginUser shareUser].uid forHTTPHeaderField:@"uid"];
    //设置请求body
    NSString * parameterStr = [self dictionaryToJson:InfoDic];
    [manager POST:url
       parameters:parameterStr
         progress:^(NSProgress * _Nonnull uploadProgress) {
             
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

//发送上传头像的请求
+ (void)requestUpheadImageWithURL:(NSString *)URL WithImage:(NSString *)imageStr WithComplete:(void (^)(NSDictionary *))block{
    AFHTTPSessionManager * manager = [self getHttpManager];
    //请求URL
    NSString * url = [[NSString stringWithFormat:@"%@%@",BASEURL,URL] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //请求参数
    NSDictionary * dic = @{@"filePathType":@"userHeadImage",
                           @"fileType":@".jpg",
                           @"imgContent":imageStr};
    NSString *parameter = [self dictionaryToJson:dic];
    //发送请求
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
        NSString * str;
        if ([dic[@"statusCode"] isEqualToString:@"4301"]) {
            str = @"用户不存在";
        }else if ([dic[@"statusCode"] isEqualToString:@"4302"]){
            str = @"用户密码错误";
        }else if ([dic[@"statusCode"] isEqualToString:@"4303"]){
            str = @"该账号已存在";
        }
        
//        NSString * errorStr = dic[@"statusMessage"];
        [SVProgressHUD showErrorWithStatus:str];
        return NO;
    }else{
        return YES;
    }
}
+ (AFHTTPSessionManager *)getHttpManager{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    return manager;
}
@end
