//
//  UIView+Extension.m
//  Kity_Pei
//
//  Created by Kity_Pei on 16/9/29.
//  Copyright © 2016年 Kity_Pei. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX:(CGFloat)x {
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setMaxX:(CGFloat)maxX {
    self.x = maxX - self.width;
}

- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxY:(CGFloat)maxY {
    self.y = maxY - self.height;
}

- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setMinX:(CGFloat)minX {
    self.x = minX;
}

- (CGFloat)minX {
    return CGRectGetMinX(self.frame);
}

- (void)setMinY:(CGFloat)minY {
    self.y = minY;
}

- (CGFloat)minY {
    return CGRectGetMinY(self.frame);
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size {
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

- (CGSize)size {
    return self.frame.size;
}

@end
