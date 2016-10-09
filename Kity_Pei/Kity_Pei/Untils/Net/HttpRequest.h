//
//  HttpRequest.h
//  Kity_Pei
//
//  Created by Kity_Pei on 16/10/8.
//  Copyright © 2016年 Kity_Pei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int,HttpRequestType) {
    HttpRequestType_GET = 0,
    HttpRequestType_POST = 1,
    HttpRequestType_PUT = 2,
    HttpRequestType_DELETE = 3
};

@interface HttpRequest : NSObject

+ (void)requestWithUrl:(NSString *)url requestType:(HttpRequestType)type jsonData:(id)jsonData formData:(NSDictionary *)formData timeOut:(NSTimeInterval)timeOut success:(void(^)(NSString *url, id responseObject,NSString *responseJson))success failure:(void (^) (NSString *url,NSError *error))failure;

@end
