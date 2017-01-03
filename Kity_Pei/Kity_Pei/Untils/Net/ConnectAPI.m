//
//  ConnectAPI.m
//  Kity_Pei
//
//  Created by Kity_Pei on 16/10/8.
//  Copyright © 2016年 Kity_Pei. All rights reserved.
//

#import "ConnectAPI.h"

@implementation HttpSuccessResponse

@end


@implementation ConnectAPI

/**
 *  网络请求
 *
 *  url 请求的url
 *  requestType 请求方式
 *  timeOut 超时时间
 *  jsonData    请求参数
 *  formData    请求表单数据
 *
 */
+ (void)sendRequestWithUrl:(NSString *)url requestType:(HttpRequestType)type timeOut:(NSTimeInterval)timeOut jsonData:(id)jsonData formData:(id)formData success:(HttpSuccess)success failure:(HttpFail)failure {
    
    if (![url hasPrefix:@"http"]) {
        if ([url hasPrefix:@"/"]) {
            url = [NSString stringWithFormat:@"%@%@",kServerIP,url];
        } else {
            url = [NSString stringWithFormat:@"%@/%@",kServerIP,url];
        }
    }
    
    if (timeOut <= 0) {
        timeOut = kTimeOut;
    }
    
    [HttpRequest requestWithUrl:url requestType:type jsonData:jsonData formData:formData timeOut:timeOut success:^(NSString *url, id responseObject, NSString *responseJson) {
        NSLog(@"response_success:\n%@\n-------%@",url,responseJson);
        
        NSDictionary *responseData = [self JSONResolveWithJson:responseJson];
        if (responseData && [responseData isKindOfClass:[NSDictionary class]]) {
            if (responseData[kResponseResult] && [responseData[kResponseResult] isKindOfClass:[NSNumber class]] && ([responseData[kResponseResult] intValue]  == kResponseSuccessNum)) {
                id body = responseData[kResponseMuster];
                if (body) {
                    if ([body isKindOfClass:[NSDictionary class]]) {
                        if (success) {
                            HttpSuccessResponse *response = [[HttpSuccessResponse alloc] init];
                            response.responseDic = body;
                            response.errorMessage = [self ErrorMsgFromServer:responseData];
                            success(response);
                        }
                        return ;
                    } else if ([body isKindOfClass:[NSArray class]]) {
                        if (success) {
                            HttpSuccessResponse *response = [[HttpSuccessResponse alloc] init];
                            response.responseList = body;
                            response.errorMessage = [self ErrorMsgFromServer:responseData];
                            success(response);
                        }
                        return ;
                    } else if ([body isKindOfClass:[NSString class]]) {
                        if (success) {
                            HttpSuccessResponse *response = [[HttpSuccessResponse alloc] init];
                            response.responseString = body;
                            response.errorMessage = [self ErrorMsgFromServer:responseData];
                            success(response);
                        }
                        return ;
                    } else if ([body isKindOfClass:[NSNumber class]]) {
                        if (success) {
                            HttpSuccessResponse *response = [[HttpSuccessResponse alloc] init];
                            response.responseNumber = body;
                            response.errorMessage = [self ErrorMsgFromServer:responseData];
                            success(response);
                        }
                        return ;
                    }
                }
                if (success) {
                    HttpSuccessResponse *response = [[HttpSuccessResponse alloc] init];
                    response.errorMessage = [self ErrorMsgFromServer:responseData];
                    success(response);
                }
                return ;
            }
        }
        if (failure) {
            failure([self ErrorMsgFromServer:responseData]);
        }
    } failure:^(NSString *url, NSError *error) {
        NSLog(@"\n---%@ --------XXXXXXXXresponse_fail_%ld",url,(long)error.code);
        if (error.code == 401) {
            if (failure) {
                failure(nil);
            }
            return ;
        } else if (error.code == 413){
            if (failure) {
                failure(@"上传数据过大,上传失败");
            }
            return;
        }
        if (failure) {
            failure(GMCONNECTAPI_ERROR_CONNECT);
        }
    }];
    
}

/*
 *  获取失败的错误信息
 *
 *  responseData 网络返回的数据
 */
+ (NSString *)ErrorMsgFromServer:(id)responseData{
    NSString *errorString;
    if (responseData) {
        if ([responseData isKindOfClass:[NSDictionary class]]) {
            if (responseData[kResponseMuster]) {
                if ([responseData[kResponseMuster] isKindOfClass:[NSString class]]) {
                    errorString = responseData[kResponseMuster];
                }else if ([responseData[kResponseMuster] isKindOfClass:[NSDictionary class]]){
                    if (responseData[kResponseMuster][kResponseErrorKey]) {
                        errorString = responseData[kResponseMuster][kResponseErrorKey];
                    }
                }
            }
        }else if ([responseData isKindOfClass:[NSString class]]){
            errorString = responseData;
        }
    }
    
    if (!errorString || ![errorString isKindOfClass:[NSString class]] || errorString.length == 0) {
        errorString = GMCONNECTAPI_ERROR_REQUEST;
    }
    
    return errorString;
}

/**
 *  Json解析
 *
 *  json:Json数据
 */
+ (id)JSONResolveWithJson:(NSString *)json{
    if (!json || json.length == 0) {
        return @{};
    }
    NSError *error;
    NSData *data = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    if (data == nil) {
        NSLog(@"-JSONResolve failed. Object is: %@", json);
        return @{};
    }
    return data;
}


@end
