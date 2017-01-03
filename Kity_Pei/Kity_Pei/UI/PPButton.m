//
//  PPButton.m
//  Kity_Pei
//
//  Created by Kity_Pei on 2017/1/3.
//  Copyright © 2017年 Kity_Pei. All rights reserved.
//

#import "PPButton.h"

@implementation PPButton{
    float _delayTouchDelay;
    BOOL _delayCanover;
    
    id _delayTarget;
    SEL _delayAction;
}

- (id)init{
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configUI];
    }
    return self;
}

+ (instancetype)buttonWithType:(UIButtonType)buttonType{
    PPButton *btn = [super buttonWithType:buttonType];
    [btn configUI];
    return btn;
}

- (void)configUI{
    [self setExclusiveTouch:YES];
    _delayCanover = YES;
    _delayTouchDelay = ButtonDelayTouchDefault;
    
    [[self imageView] setContentMode:UIViewContentModeScaleAspectFill];
    [self imageView].clipsToBounds = YES;
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}

- (void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}

//delayTouch
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    _delayTarget = target;
    _delayAction = action;
    [super addTarget:self action:@selector(actionFortarget) forControlEvents:controlEvents];
}

- (void)actionFortarget{
    if (_delayCanover) {
        _delayCanover = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_delayTouchDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _delayCanover = YES;
        });
        
        if (_delayTarget && _delayAction) {
            if ([_delayTarget respondsToSelector:_delayAction]) {
                [_delayTarget performSelector:_delayAction withObject:self afterDelay:0.0];
            }
        }
    }
}

- (void)setDelayTouch:(float)delay{
    _delayTouchDelay = delay;
}

@end
