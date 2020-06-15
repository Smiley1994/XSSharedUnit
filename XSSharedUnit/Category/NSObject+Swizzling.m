//
//  NSObject+Swizzling.m
// MacrolorSun
//
//  Created by Macrolor on 2016/11/12.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSObject(Swizzling)

+ (void)swizzlingMethod:(SEL)originalSelector toMethod:(SEL)swizzledSelector {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}
@end
