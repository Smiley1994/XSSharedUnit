//
//  ANN9UIUtils.h
//  BabyLearnEnglish
//
//  Created by 晓松 on 2018/11/26.
//  Copyright © 2018 ann9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XSUIUtils : NSObject

/**
 * 设备名称  iPhone 4
 * 屏幕尺寸  3.7Inch
 * 密度
 */
+ (BOOL)isThreeSevenInchDevice;


/**
 * 设备名称   iPhone SE（SE, 5S, 5C）
 * 屏幕尺寸   4.0Inch
 * 密度dpi     2.0 xhdpi
 */
+ (BOOL)isFourZeroInchDevice;


/**
 * 设备名称   iPhone 8 (8, 7, 6S, 6)
 * 屏幕尺寸   4.7Inch
 * 密度dpi     2.0 xhdpi
 */
+ (BOOL)isFourSevenInchDevice;

/**
 * 设备名称   iPhone 8+ (8+, 7+, 6S+, 6+)
 * 屏幕尺寸   5.5Inch
 * 密度dpi     3.0 xxhdpi
 */
+ (BOOL)isFiveFiveInchDevice;


/**
 * 设备名称   iPhone X (X, XS, 11 Pro)
 * 屏幕尺寸   5.8Inch
 * 密度dpi     3.0 xxhdpi
 */
+ (BOOL)isFiveEightInchDevice;


/**
 * 设备名称   iPhone X (11, XR)
 * 屏幕尺寸   6.1Inch
 * 密度dpi     2.0 xhdpi
 */
+ (BOOL)isSixOneInchDevice;


/**
 * 设备名称   iPhone XS Max (11 Pro Max )
 * 屏幕尺寸   6.5Inch
 * 密度dpi     3.0 xxhdpi
 */
+ (BOOL)isSixFiveInchDevice;


/**
 * 设备名称   iPhone 12 Mini
 * 屏幕尺寸   5.4Inch
 * 密度dpi     3.0 xxhdpi
 */
+ (BOOL)isFiveFourInchDevice;

/**
 * 设备名称   iPhone 12 Pro
 * 屏幕尺寸   6.1Inch
 * 密度dpi     3.0 xxhdpi
 */
+ (BOOL)isSixOneInchDevice12;

/**
 * 设备名称   iPhone 12 Pro Max
 * 屏幕尺寸   6.7Inch
 * 密度dpi     3.0 xxhdpi
 */
+ (BOOL)isSixSevenInchDevice;

+ (BOOL)isX;

+ (BOOL)isIPad;



/**
 高斯模糊
 @param image image
 @param blur (0 - 1 之间)
 @return image
 */
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

@end

NS_ASSUME_NONNULL_END
