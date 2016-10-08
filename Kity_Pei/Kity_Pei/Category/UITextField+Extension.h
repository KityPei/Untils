//
//  UITextField+Extension.h
//  Kity_Pei
//
//  Created by Kity_Pei on 16/10/8.
//  Copyright © 2016年 Kity_Pei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)

- (void)setplaceholderColor:(UIColor *)color;

- (void)setplaceholderFont:(CGFloat)font;

- (void)updateTextFiledWithMaxLength:(NSInteger)length;

@end
