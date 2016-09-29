//
//  PPAlertView.h
//  Kity_Pei
//
//  Created by Kity_Pei on 16/9/29.
//  Copyright © 2016年 Kity_Pei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PPAlertView : NSObject

+ (void)alertWithTitle:(NSString *)title;
+ (void)alertWithTitle:(NSString *)title defaultTitle:(NSString *)defaultTitle;
+ (void)alertWithTitleArray:(NSArray*)titleArray;

@end
