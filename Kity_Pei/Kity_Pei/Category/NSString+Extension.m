//
//  NSString+Extension.m
//  Kity_Pei
//
//  Created by Kity_Pei on 16/9/29.
//  Copyright © 2016年 Kity_Pei. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (long long)fileSize {
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    BOOL isDirectory = NO;
    BOOL fileExists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    if (!fileExists) {
        return 0;
    }
    if (isDirectory) {
        NSArray *subpaths = [mgr contentsOfDirectoryAtPath:self error:nil];
        long long totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            totalSize += [fullSubpath fileSize];
        }
        return totalSize;
    } else {
        NSDictionary *attr = [mgr attributesOfItemAtPath:self error:nil];
        return [attr[NSFileSize] longLongValue];
    }
}

- (CGSize)sizeForLabelWithArea:(CGSize)size font:(CGFloat)fontSize {
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return CGSizeMake(ceilf(rect.size.width), ceilf(rect.size.height));
}

- (id)JSONResolve {
    if (self.length == 0) {
        return @{};
    }
    NSError *error;
    NSData *json = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    if (json == nil) {
        NSLog(@"%@ === JSONResolve failed. ",self);
    }
    return json;
}


@end
