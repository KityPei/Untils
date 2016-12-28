//
//  NSObject+Extension.m
//  Kity_Pei
//
//  Created by Kity_Pei on 16/10/9.
//  Copyright © 2016年 Kity_Pei. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

- (NSString *)JSONValue {
    if ([NSJSONSerialization isValidJSONObject:self]){
        NSError *error = nil;
        id jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        if (error == nil) {
            NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            return json;
        }
    }
    NSLog(@"-JSONValue failed. Object is: %@", self);
    return @"{}";
}

- (BOOL) isValid {
    return !(self==nil || [self isKindOfClass:[NSNull class]]);
}

- (void)performAfterDelay:(NSTimeInterval)delay block:(void (^)())block{
    [self performSelector:@selector(ppBlockAfterDelay:) withObject:block afterDelay:delay];
}

- (void)ppBlockAfterDelay:(void (^)())block {
    block();
}
@end
