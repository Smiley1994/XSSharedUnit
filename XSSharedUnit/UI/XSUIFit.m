//
//  ANN9UIFit.m
//  BabyLearnEnglish
//
//  Created by 晓松 on 2019/1/21.
//  Copyright © 2019 ann9. All rights reserved.
//

#import "XSUIFit.h"
#import "XSUIUtils.h"
#import "XSUIMacro.h"



@implementation XSUIFit


// iphone  6 7 8
+ (CGFloat)percentageWithScreenWidth {
    return SCREEN_WIDTH / 375.0;
}

// iphone  6 7 8
+ (CGFloat)percentageWithScreenHeight {
    return SCREEN_HEIGHT / 667.0;
}


+ (CGFloat)fitWidth:(CGFloat)width {
    return width * [self percentageWithScreenWidth];
}

+ (CGFloat)fitHeight:(CGFloat)height {
    return height * [self percentageWithScreenHeight];
}

+ (CGFloat)fitLandscapeFont:(CGFloat)size {
    return size * [self percentageWithScreenHeight];
}

+ (CGFloat)fitVerticalScreenFont:(CGFloat)size {
    return size * [self percentageWithScreenWidth];
}



@end
