//
//  PPViewController.h
//  Kity_Pei
//
//  Created by Kity_Pei on 2017/1/3.
//  Copyright © 2017年 Kity_Pei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VIEWBACKCOLOR [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1]
#define NAVTITLECOLOR  [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]
#define NAVBACKCOLOR [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1]
#define MAJORCOLOR [UIColor colorWithRed:22/255.0 green:197/255.0 blue:238/255.0 alpha:1]

@interface PPViewController : UIViewController

- (NSString *)PPNavigationTitleText;
- (UIView *)PPNavigationTitleView;
- (UIColor *)PPNavigationTitleColor;

- (BOOL)PPNavigationTitleCenter;
- (UIImage *)PPNavigationLeftImage;
- (NSString *)PPNavigationLeftText;
- (NSString *)PPNavigationRightText;
- (UIImage *)PPNavigationRightImage;
- (UIColor *)PPNavigationBackgroundColor;
- (void)PPNavigationActionLeft;
- (void)PPNavigationActionRight;


//action
- (void)PPNavigationRefresh;

@end
