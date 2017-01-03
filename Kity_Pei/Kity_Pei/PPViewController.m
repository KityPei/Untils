//
//  PPViewController.m
//  Kity_Pei
//
//  Created by Kity_Pei on 2017/1/3.
//  Copyright © 2017年 Kity_Pei. All rights reserved.
//

#import "PPViewController.h"
#import "UIViewController+Extension.h"
@interface PPViewController ()

@end

@implementation PPViewController{
    UIView *_nullView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self PPNavigationRefresh];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:view atIndex:0];
    
    self.view.backgroundColor = VIEWBACKCOLOR;
}

#pragma mark -
#pragma mark --navigationBar--
- (NSString *)PPNavigationTitleText {
    return nil;
}

- (UIView *)PPNavigationTitleView {
    return nil;
}

- (UIColor *)PPNavigationTitleColor {
    return NAVTITLECOLOR;
}

- (BOOL)PPNavigationTitleCenter {
    return YES;
}

- (NSString *)PPNavigationLeftText {
    return nil;
}

- (UIImage *)PPNavigationLeftImage {
    return nil;
}

- (NSString *)PPNavigationRightText {
    return nil;
}

- (UIImage *)PPNavigationRightImage {
    return nil;
}

- (UIColor *)PPNavigationBackgroundColor {
    return NAVBACKCOLOR;
}

- (void)PPNavigationActionLeft {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)PPNavigationActionRight {
    
}

- (void)PPNavigationRefresh {
    if (!self.navigationController || self.navigationController.navigationBarHidden) {
        return;
    }
    if ([self PPNavigationTitleView]) {
        [self pp_setTitleView:[self PPNavigationTitleView]];
    } else {
        [self pp_setTitle:[self PPNavigationTitleText]];
    }
    
    [self pp_setTitleTextColor:[self PPNavigationTitleColor]];
    
    [self pp_setBtnLeftText:[self PPNavigationLeftText] textColor:MAJORCOLOR image:[self PPNavigationLeftImage] action:@selector(PPNavigationActionLeft)];
    
    [self pp_setBtnRightText:[self PPNavigationRightText] textColor:MAJORCOLOR image:[self PPNavigationRightImage] action:@selector(PPNavigationActionRight)];
    
    [self pp_setBackgroundColor:[self PPNavigationBackgroundColor] needShadow:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
} // Dispose of any resources that can be recreated.

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
