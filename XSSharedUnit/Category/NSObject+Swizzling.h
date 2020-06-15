//
//  NSObject+Swizzling.h
// MacrolorSun
//
//  Created by Macrolor on 2016/11/12.
//  Copyright © 2016年 MS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(Swizzling)

+ (void)swizzlingMethod:(SEL)originalSelector toMethod:(SEL)swizzledSelector;

@end
