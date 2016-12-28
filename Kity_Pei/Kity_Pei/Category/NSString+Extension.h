//
//  NSString+Extension.h
//  Kity_Pei
//
//  Created by Kity_Pei on 16/9/29.
//  Copyright © 2016年 Kity_Pei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Extension)

//  判断是否为空
- (BOOL) isValid;

// 此处路径下文件的大小
- (long long)fileSize;

// 计算文字所占大小
- (CGSize)sizeForLabelWithArea:(CGSize)size font:(CGFloat)fontSize;

//  解析json
- (id)JSONResolve;

//  转化成url
- (NSURL *)URLValue;

//  判断是否为有效手机号
- (BOOL)isPhoneNumber;

//  判断是否为有效身份证号码（18位）
- (BOOL)isIDCard;

@end
