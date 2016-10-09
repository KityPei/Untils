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

// 此处string是一个路径，计算该路径下文件的大小
- (long long)fileSize;

// 计算文字所占大小
- (CGSize)sizeForLabelWithArea:(CGSize)size font:(CGFloat)fontSize;

- (id)JSONResolve;

@end
