//
//  UIViewController+Extension.h
//  Kity_Pei
//
//  Created by Kity_Pei on 2017/1/3.
//  Copyright © 2017年 Kity_Pei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

- (void)pp_setTitle:(NSString *)title;
- (void)pp_setTitleView:(UIView *)view;
- (void)pp_setTitleTextColor:(UIColor *)color;
- (void)pp_setBtnLeftText:(NSString *)text textColor:(UIColor *)color image:(UIImage *)image action:(SEL)action;
- (void)pp_setBtnRightText:(NSString *)text textColor:(UIColor *)color image:(UIImage *)image action:(SEL)action;
- (void)pp_setBackgroundColor:(UIColor *)color needShadow:(BOOL)needShadow;
- (void)pp_reset;

@end
