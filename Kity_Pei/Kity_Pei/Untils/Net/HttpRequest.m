//
//  HttpRequest.m
//  Kity_Pei
//
//  Created by Kity_Pei on 16/10/8.
//  Copyright © 2016年 Kity_Pei. All rights reserved.
//

#import "HttpRequest.h"
#import "AFNetworking.h"
#import <CommonCrypto/CommonDigest.h>
@implementation HttpRequest

+ (void)requestWithUrl:(NSString *)url requestType:(HttpRequestType)type jsonData:(id)jsonData formData:(NSDictionary *)formData timeOut:(NSTimeInterval)timeOut success:(void(^)(NSString *url, id responseObject,NSString *responseJson))success failure:(void (^) (NSString *url,NSError *error))failure {
    if (!url || url.length == 0) {
        if (failure) {
            failure(url,[NSError errorWithDomain:@"url cannot be nil" code:404 userInfo:nil]);
            return;
        }
    }
    if (jsonData && (![jsonData isKindOfClass:[NSArray class]] && ![jsonData isKindOfClass:[NSDictionary class]])) {
        if (failure) {
            failure(url,[NSError errorWithDomain:@"jsonData is invaild" code:404 userInfo:nil]);
            return;
        }
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setTimeoutInterval:timeOut];
    
    switch (type) {
        case HttpRequestType_GET:{
            if (jsonData) {
                manager.requestSerializer = [AFJSONRequestSerializer serializer];
                [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
                [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
                [manager.requestSerializer setTimeoutInterval:timeOut];
                [manager GET:url parameters:jsonData success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                    if (success) {
                        NSString *responseJson;
                        if (responseObject && [responseObject isKindOfClass:[NSData class]]) {
                            responseJson = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                        }
                        success(task.currentRequest.URL.absoluteString,responseObject,responseJson);
                    }
                } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                    if (failure) {
                        failure(task.currentRequest.URL.absoluteString,[NSError errorWithDomain:error.domain code:((NSHTTPURLResponse *)task.response).statusCode userInfo:error.userInfo]);
                    }
                }];
            } else {
                [manager GET:url parameters:formData success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                    if (success) {
                        NSString *responseJson;
                        if (responseObject && [responseObject isKindOfClass:[NSData class]]) {
                            responseJson = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                        }
                        success(task.currentRequest.URL.absoluteString,responseObject,responseJson);
                    }
                } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                    if (failure) {
                        failure(task.currentRequest.URL.absoluteString,[NSError errorWithDomain:error.domain code:((NSHTTPURLResponse *)task.response).statusCode userInfo:error.userInfo]);
                    }
                }];
            }
            break;
        }case HttpRequestType_POST:{
            if (jsonData) {
                manager.requestSerializer = [AFJSONRequestSerializer serializer];
                [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
                [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
                [manager.requestSerializer setTimeoutInterval:timeOut];
                [manager POST:url parameters:jsonData success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                    if (success) {
                        NSString *responseJson;
                        if (responseObject && [responseObject isKindOfClass:[NSData class]]) {
                            responseJson = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                        }
                        success(task.currentRequest.URL.absoluteString,responseObject,responseJson);
                    }
                } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                    if (failure) {
                        failure(task.currentRequest.URL.absoluteString,[NSError errorWithDomain:error.domain code:((NSHTTPURLResponse *)task.response).statusCode userInfo:error.userInfo]);
                    }
                }];
            } else {
                [manager POST:url parameters:formData success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                    if (success) {
                        NSString *responseJson;
                        if (responseObject && [responseObject isKindOfClass:[NSData class]]) {
                            responseJson = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                        }
                        success(task.currentRequest.URL.absoluteString,responseObject,responseJson);
                    }
                } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                    if (failure) {
                        failure(task.currentRequest.URL.absoluteString,[NSError errorWithDomain:error.domain code:((NSHTTPURLResponse *)task.response).statusCode userInfo:error.userInfo]);
                    }
                }];
            }
            break;
        }case HttpRequestType_PUT:{
            if (jsonData) {
                manager.requestSerializer = [AFJSONRequestSerializer serializer];
                [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
                [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
                [manager.requestSerializer setTimeoutInterval:timeOut];
                [manager PUT:url parameters:jsonData success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                    if (success) {
                        NSString *responseJson;
                        if (responseObject && [responseObject isKindOfClass:[NSData class]]) {
                            responseJson = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                        }
                        success(task.currentRequest.URL.absoluteString,responseObject,responseJson);
                    }
                } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                    if (failure) {
                        failure(task.currentRequest.URL.absoluteString,[NSError errorWithDomain:error.domain code:((NSHTTPURLResponse *)task.response).statusCode userInfo:error.userInfo]);
                    }
                }];
            } else {
                [manager PUT:url parameters:formData success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                    if (success) {
                        NSString *responseJson;
                        if (responseObject && [responseObject isKindOfClass:[NSData class]]) {
                            responseJson = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                        }
                        success(task.currentRequest.URL.absoluteString,responseObject,responseJson);
                    }
                } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                    if (failure) {
                        failure(task.currentRequest.URL.absoluteString,[NSError errorWithDomain:error.domain code:((NSHTTPURLResponse *)task.response).statusCode userInfo:error.userInfo]);
                    }
                }];
            }
            break;
        }case HttpRequestType_DELETE:{
            if (jsonData) {
                manager.requestSerializer = [AFJSONRequestSerializer serializer];
                [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
                [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-type"];
                [manager.requestSerializer setTimeoutInterval:timeOut];
                [manager DELETE:url parameters:jsonData success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                    if (success) {
                        NSString *responseJson;
                        if (responseObject && [responseObject isKindOfClass:[NSData class]]) {
                            responseJson = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                        }
                        success(task.currentRequest.URL.absoluteString,responseObject,responseJson);
                    }
                } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                    if (failure) {
                        failure(task.currentRequest.URL.absoluteString,[NSError errorWithDomain:error.domain code:((NSHTTPURLResponse *)task.response).statusCode userInfo:error.userInfo]);
                    }
                }];
            } else {
                [manager DELETE:url parameters:formData success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                    if (success) {
                        NSString *responseJson;
                        if (responseObject && [responseObject isKindOfClass:[NSData class]]) {
                            responseJson = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                        }
                        success(task.currentRequest.URL.absoluteString,responseObject,responseJson);
                    }
                } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                    if (failure) {
                        failure(task.currentRequest.URL.absoluteString,[NSError errorWithDomain:error.domain code:((NSHTTPURLResponse *)task.response).statusCode userInfo:error.userInfo]);
                    }
                }];
            }
            break;
        }default:
            if (failure) {
                failure(url,[NSError errorWithDomain:@"HttpRequestType cannot be nil" code:404 userInfo:nil]);
            }
            return;
            break;
    }
}

@end
