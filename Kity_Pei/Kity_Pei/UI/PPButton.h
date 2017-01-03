//
//  PPButton.h
//  Kity_Pei
//
//  Created by Kity_Pei on 2017/1/3.
//  Copyright © 2017年 Kity_Pei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPButton : UIButton

#define ButtonDelayTouchDefault   0.2

@property (nonatomic) IBInspectable CGFloat cornerRadius;

@property (strong, nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;

- (void)setDelayTouch:(float)delay;
@end
