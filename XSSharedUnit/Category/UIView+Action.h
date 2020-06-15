//
//  UIView+Action.h
// MacrolorSun
//
//  Created by Macrolor on 2016/11/12.
//  Copyright © 2016年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(Action)

- (SEL __nullable)itemAction;

- (id __nullable)itemTarget;

- (NSInteger)itemPosition;

- (NSInteger) itemSection;

- (void)addTarget:(id _Nonnull)target
           action:(SEL _Nonnull)action
          section:(NSInteger)section;

- (void)addTarget:(id _Nonnull)target
           action:(SEL _Nonnull)action
         position:(NSInteger)position
          section:(NSInteger)section;

- (void)addEvent:(UIView * _Nonnull)view;

@end
