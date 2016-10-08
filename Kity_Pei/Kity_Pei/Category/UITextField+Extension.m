//
//  UITextField+Extension.m
//  Kity_Pei
//
//  Created by Kity_Pei on 16/10/8.
//  Copyright © 2016年 Kity_Pei. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)

- (void)setplaceholderColor:(UIColor *)color {
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:color}];
}

- (void)setplaceholderFont:(CGFloat)font {
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}];
}

- (void)updateTextFiledWithMaxLength:(NSInteger)length {
    NSString *string = self.text;
    NSString *lang = [self.textInputMode primaryLanguage];//键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (string.length > length) {
                self.text = [string substringToIndex:length];
            }
        }
    } else {
        if (string.length > length) {
            self.text = [string substringToIndex:length];
        }
    }
}

@end
