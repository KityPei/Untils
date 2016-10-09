//
//  ConnectAPI.h
//  Kity_Pei
//
//  Created by Kity_Pei on 16/10/8.
//  Copyright © 2016年 Kity_Pei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequest.h"

#define kServerIP @""           // 网络请求时url中的固定地址
#define kServerImgIP @""            //图片url中的固定地址

#define kNetPath [[NSBundle mainBundle] pathForResource:@"NetResource" ofType:@"plist"]
#define kTimeOut 15.     //超时

#define kResponseMuster @"result"             //返回数据的主要数据结构的key值
#define kResponseResult @"code"           //返回数据成功否的key值
#define kResponseSuccessNum 200            //返回数据成功的标示符  eg：200／100
#define kResponseErrorKey @"msg"        //返回数据失败的提示语

#define GMCONNECTAPI_ERROR_REQUEST  @"请求失败，请稍后再试"
#define GMCONNECTAPI_ERROR_CONNECT  @"连接失败，请稍后再试"

@interface HttpSuccessResponse : NSObject

@property (strong, nonatomic) NSDictionary *responseDic;
@property (strong, nonatomic) NSArray *responseList;
@property (strong, nonatomic) NSString *responseString;
@property (strong, nonatomic) NSNumber *responseNumber;

@property (strong, nonatomic) NSString *errorMessage;

@end


typedef void(^HttpSuccess)(HttpSuccessResponse *response);
typedef void(^HttpFail)(NSString *error);

@interface ConnectAPI : NSObject

+ (void)sendRequestWithKey:(NSString *)key timeOut:(NSTimeInterval)timeOut jsonData:(id)jsonData formData:(id)formData success:(HttpSuccess)success failure:(HttpFail)failure;

@end
