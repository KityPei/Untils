//
//  PPAlertView.m
//  Kity_Pei
//
//  Created by Kity_Pei on 16/9/29.
//  Copyright © 2016年 Kity_Pei. All rights reserved.
//

#import "PPAlertView.h"

@interface PPAlertView()

@property (strong, nonatomic) UILabel *contentLabel;
@property (nonatomic) NSTimeInterval time;
@property (nonatomic) NSTimeInterval timeForSingle;
@property (strong, nonatomic) NSTimer *timer;


@property (strong, nonatomic) NSMutableArray *actionList;

@end


@implementation PPAlertView

#pragma mark -
#pragma mark --单例--
static PPAlertView *instance = nil;

+ (PPAlertView *)Instance {
    @synchronized (self) {
        if (!instance) {
            instance = [[self alloc] init];
            instance.time = 3;
            instance.timeForSingle = 1.5;
        }
    }
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    @synchronized (self) {
        if (!instance) {
            instance = [super allocWithZone:zone];
        }
    }
    return instance;
}

- (id)copy {
    return self;
}

- (id)mutableCopy {
    return self;
}

#pragma mark -
#pragma mark --Init--
+ (void)contentInit {
    if (![self Instance].contentLabel) {
        CGRect rect = [UIScreen mainScreen].bounds;
        
        [self Instance].contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        [[self Instance].contentLabel setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
        [[self Instance].contentLabel setCenter:CGPointMake(rect.size.width/2, rect.size.height-80)];
        [self Instance].contentLabel.layer.cornerRadius = 6;
        [self Instance].contentLabel.layer.masksToBounds = YES;
        [self Instance].contentLabel.clipsToBounds = YES;
        [self Instance].contentLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self Instance].contentLabel.minimumScaleFactor = 0.3;
        [self Instance].contentLabel.textAlignment = NSTextAlignmentCenter;
        [self Instance].contentLabel.userInteractionEnabled = NO;
        [self Instance].contentLabel.font = [UIFont systemFontOfSize:12.0f];
        [self Instance].contentLabel.numberOfLines = 2;
        [self Instance].contentLabel.textColor = [UIColor whiteColor];
    }
}

+ (void)closeMySelf {
    if ([self Instance].contentLabel) {
        for (UILabel *label in [self Instance].contentLabel.subviews) {
            [label removeFromSuperview];
        }
        [[self Instance].contentLabel removeFromSuperview];
        [self Instance].contentLabel.text = @"";
    }
    
    if (instance.timer) {
        [instance.timer invalidate];
        instance.timer = nil;
    }
    
    if (instance.actionList) {//?
        for (NSTimer *timer in instance.actionList) {
            if (timer) {
                [timer invalidate];
            }
        }
    }
    [instance.actionList removeAllObjects];
}

+ (void)showContentLabelWithTime:(NSTimeInterval)time {
    if (![self Instance].contentLabel || [self Instance].contentLabel.superview) {
        return;
    }
    [self Instance].contentLabel.transform = CGAffineTransformMakeScale(0, 0);//缩小
    [[UIApplication sharedApplication].keyWindow addSubview:[self Instance].contentLabel];
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:8.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self Instance].contentLabel.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        if (instance.timer) {
            [instance.timer invalidate];
            instance.timer = nil;
        }
        instance.timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(closeMySelf) userInfo:nil repeats:NO];
    }];
}

#pragma mark -
#pragma mark --Action--
+ (void)alertWithTitle:(NSString *)title {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!title || title.length == 0) {
            return ;
        }
        
        [self closeMySelf];
        
        [self contentInit];
        
        [self Instance].contentLabel.text = [NSString stringWithFormat:@" %@ ",title];
        [self Instance].contentLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        
        if (![NSThread isMainThread]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showContentLabelWithTime:instance.time];
            });
        } else {
            [self showContentLabelWithTime:instance.time];
        }
        
    });
}

+ (void)alertWithTitle:(NSString *)title defaultTitle:(NSString *)defaultTitle {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *content = defaultTitle;
        if (title && title.length > 0) {
            content = title;
        }
        if (!content || content.length == 0) {
            return ;
        }
        
        [self closeMySelf];
        
        [self contentInit];
        
        [self Instance].contentLabel.text = [NSString stringWithFormat:@" %@ ",content];
        [self Instance].contentLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        
        if (![NSThread isMainThread]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showContentLabelWithTime:instance.time];
            });
        } else {
            [self showContentLabelWithTime:instance.time];
        }
        
    });
}

+ (void)alertWithTitleArray:(NSArray*)titleArray{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!titleArray || titleArray.count == 0) {
            return;
        }
        [self closeMySelf];
        
        [self contentInit];
        [self Instance].contentLabel.text = @"";
        [self Instance].contentLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        
        if (![NSThread isMainThread]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showContentLabelWithTime:instance.timeForSingle * titleArray.count];
            });
        }else{
            [self showContentLabelWithTime:instance.timeForSingle * titleArray.count];
        }
        
        for (int i = 0; i< titleArray.count; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:[self Instance].contentLabel.bounds];
            label.backgroundColor = [UIColor clearColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = [NSString stringWithFormat:@" %@ ",titleArray[i]];
            label.adjustsFontSizeToFitWidth = YES;
            label.minimumScaleFactor = 0.5;
            label.numberOfLines = 2;
            label.font = [UIFont systemFontOfSize:12];
            [label setTextColor:[UIColor whiteColor]];
            label.center = CGPointMake(label.bounds.size.width/2, label.bounds.size.height/2 + i*label.bounds.size.height);
            
            [[self Instance].contentLabel addSubview:label];
        }
        
        instance.actionList = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0 ;i < titleArray.count-1 ;i++) {
            double delayInSeconds = instance.timeForSingle * (i+1);
            
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:delayInSeconds target:self selector:@selector(moveContentLabelSubviews) userInfo:nil repeats:NO];
            [instance.actionList addObject:timer];
        }
    });
}
+ (void)moveContentLabelSubviews{
    [UIView animateWithDuration:0.3 animations:^{
        for (UILabel *label in [self Instance].contentLabel.subviews) {
            label.center = CGPointMake(label.center.x, label.center.y - [self Instance].contentLabel.bounds.size.height);
        }
    } completion:nil];
}


@end
