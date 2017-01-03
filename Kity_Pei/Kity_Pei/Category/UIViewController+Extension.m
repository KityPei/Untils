//
//  UIViewController+Extension.m
//  Kity_Pei
//
//  Created by Kity_Pei on 2017/1/3.
//  Copyright © 2017年 Kity_Pei. All rights reserved.
//

#import "UIViewController+Extension.h"
#import "UINavigationBar+Extension.h"
@implementation UIViewController (Extension)

- (void)pp_setTitle:(NSString *)title{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-120.), 44)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleView.frame];
    titleLabel.text = title;
    titleLabel.tag = 1101;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    titleLabel.numberOfLines = 1;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.minimumScaleFactor = 0.5;
    titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [titleView addSubview:titleLabel];
    self.navigationItem.titleView = titleView;
}


- (void)pp_setTitleView:(UIView *)view{
    self.navigationItem.titleView = view;
}

- (void)pp_setTitleTextColor:(UIColor *)color{
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:color ,NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    if (self.navigationItem.titleView) {
        UILabel *label = [self.navigationItem.titleView viewWithTag:1101];
        if (label) {
            label.textColor = color;
        }
    }
}

- (void)pp_setBtnLeftText:(NSString *)text textColor:(UIColor *)color image:(UIImage *)image action:(SEL)action{
    if (!text && !image) {
        return;
    }
    CGFloat offsetX = -16.;
    //left
    UIButton *buttonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLeft.titleLabel.font = [UIFont systemFontOfSize:14];
    [buttonLeft setTitleColor:color forState:UIControlStateNormal];
    buttonLeft.titleLabel.minimumScaleFactor = 0.5;
    buttonLeft.titleLabel.adjustsFontSizeToFitWidth = YES;
    buttonLeft.titleLabel.numberOfLines = 1;
    buttonLeft.frame = CGRectMake(0, 0, 44, 44);
    if (image) {
        [buttonLeft setImage:image forState:UIControlStateNormal];
    }else if (text){
        [buttonLeft setTitle:text forState:UIControlStateNormal];
    }else{
        buttonLeft = nil;
    }
    
    if (buttonLeft) {
        UIBarButtonItem *gapLeft = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                    target:nil action:nil];
        
        gapLeft.width = offsetX;
        
        [buttonLeft addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        
        //自定义button 点击区域过大
        UIView *buttonLeftView = [[UIView alloc] initWithFrame:buttonLeft.bounds];
        [buttonLeftView addSubview:buttonLeft];
        
        UIBarButtonItem *barButtonLeft = [[UIBarButtonItem alloc] initWithCustomView:buttonLeftView];
        
        self.navigationItem.leftBarButtonItems = @[gapLeft, barButtonLeft];
    }
}

- (void)pp_setBtnRightText:(NSString *)text textColor:(UIColor *)color image:(UIImage *)image action:(SEL)action{
    if (!text && !image) {
        return;
    }
    CGFloat offsetX = -16.;
    UIButton *buttonRight = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonRight.frame = CGRectMake(0, 0, 44, 44);
    [buttonRight setTitleColor:color forState:UIControlStateNormal];
    buttonRight.titleLabel.font = [UIFont systemFontOfSize:14];
    buttonRight.titleLabel.minimumScaleFactor = 0.5;
    buttonRight.titleLabel.adjustsFontSizeToFitWidth = YES;
    buttonRight.titleLabel.numberOfLines = 3;
    if (image) {
        [buttonRight setImage:image forState:UIControlStateNormal];
    }else if (text){
        [buttonRight setTitle:text forState:UIControlStateNormal];
    }else{
        buttonRight = nil;
    }
    if (buttonRight) {
        UIBarButtonItem *gapRight = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                     target:nil action:nil];
        
        gapRight.width = offsetX;
        
        [buttonRight addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        
        //自定义button 点击区域过大
        UIView *buttonRightView = [[UIView alloc] initWithFrame:buttonRight.bounds];
        [buttonRightView addSubview:buttonRight];
        
        UIBarButtonItem *barButtonRight = [[UIBarButtonItem alloc] initWithCustomView:buttonRightView];
        
        self.navigationItem.rightBarButtonItems = @[gapRight, barButtonRight];
    }
}

static UIImage *_nilImage;
- (void)pp_setBackgroundColor:(UIColor *)color needShadow:(BOOL)needShadow{
    [self.navigationController.navigationBar ex_setBackgroundColor:color];
    
    if (color == [UIColor clearColor]) {
        needShadow = NO;
    }
    if (!needShadow) {
        if (!_nilImage) {
            _nilImage = [[UIImage alloc] init];
        }
        [self.navigationController.navigationBar setShadowImage:_nilImage];
    }else {
        [self.navigationController.navigationBar setShadowImage:nil];
    }
}

- (void)pp_reset{
    [self.navigationController.navigationBar ex_reset];
}

@end
