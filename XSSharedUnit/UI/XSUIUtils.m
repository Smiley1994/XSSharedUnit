//
//  ANN9UIUtils.m
//  BabyLearnEnglish
//
//  Created by 晓松 on 2018/11/26.
//  Copyright © 2018 ann9. All rights reserved.
//

#import "XSUIUtils.h"
#import <sys/utsname.h>
#import <Accelerate/Accelerate.h>
#import "XSUIMacro.h"
#import "UIDevice+XSDeviceInfo.h"

@implementation XSUIUtils

/**
 * 设备名称  iPhone 4
 * 屏幕尺寸  3.7Inch
 * 密度
 */
+ (BOOL)isThreeSevenInchDevice {
    return (SCREEN_WIDTH == 320 && SCREEN_HEIGHT == 480) || (SCREEN_WIDTH == 480 && SCREEN_HEIGHT == 320);
}

/**
 * 设备名称   iPhone SE（SE, 5S, 5C）
 * 屏幕尺寸   4.0Inch
 * 密度dpi     2.0 xhdpi
 */
+ (BOOL)isFourZeroInchDevice {
    return (SCREEN_WIDTH == 320 && SCREEN_HEIGHT == 568) || (SCREEN_WIDTH == 568 && SCREEN_HEIGHT == 320);
}

/**
 * 设备名称   iPhone 8 (8, 7, 6S, 6)
 * 屏幕尺寸   4.7Inch
 * 密度dpi     2.0 xhdpi
 */
+ (BOOL)isFourSevenInchDevice {
    return (SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 667) || (SCREEN_WIDTH == 667 && SCREEN_HEIGHT == 375);
}

/**
 * 设备名称   iPhone 8+ (8+, 7+, 6S+, 6+)
 * 屏幕尺寸   5.5Inch
 * 密度dpi     3.0 xxhdpi
 */
+ (BOOL)isFiveFiveInchDevice {
    return (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 736) || (SCREEN_WIDTH == 736 && SCREEN_HEIGHT == 414);
}

/**
 * 设备名称   iPhone X (X, XS, 11 Pro)
 * 屏幕尺寸   5.8Inch
 * 密度dpi     3.0 xxhdpi
 */
+ (BOOL)isFiveEightInchDevice {
    return (SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 812) || (SCREEN_WIDTH == 812 && SCREEN_HEIGHT == 375);
}


/**
 * 设备名称   iPhone X (11, XR)
 * 屏幕尺寸   6.1Inch
 * 密度dpi     2.0 xhdpi
 */
+ (BOOL)isSixOneInchDevice {
    return (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 896) || (SCREEN_WIDTH == 896 && SCREEN_HEIGHT == 414);
}

/**
 * 设备名称   iPhone XS Max (11 Pro Max )
 * 屏幕尺寸   6.5Inch
 * 密度dpi     3.0 xxhdpi
 */
+ (BOOL)isSixFiveInchDevice {
    return (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 896) || (SCREEN_WIDTH == 896 && SCREEN_HEIGHT == 414);
}

/**
 * 设备名称   iPhone 12 Pro
 * 屏幕尺寸   6.1Inch
 * 密度dpi     3.0 xxhdpi
 */
+ (BOOL)isSixOneInchDevice12 {
    return (SCREEN_WIDTH == 390 && SCREEN_HEIGHT == 844) || (SCREEN_WIDTH == 844 && SCREEN_HEIGHT == 390);
}

/**
 * 设备名称   iPhone 12 Mini
 * 屏幕尺寸   5.4Inch
 * 密度dpi     3.0 xxhdpi
 */
+ (BOOL)isFiveFourInchDevice {
    return (SCREEN_WIDTH == 360 && SCREEN_HEIGHT == 780) || (SCREEN_WIDTH == 780 && SCREEN_HEIGHT == 360);
}

/**
 * 设备名称   iPhone 12 Pro Max
 * 屏幕尺寸   6.7Inch
 * 密度dpi     3.0 xxhdpi
 */
+ (BOOL)isSixSevenInchDevice {
    return (SCREEN_WIDTH == 428 && SCREEN_HEIGHT == 926) || (SCREEN_WIDTH == 926 && SCREEN_HEIGHT == 428);
}

+ (BOOL)isX {
    if ([[UIDevice getDeviceTypeString] isEqualToString:@"iPhone X"] ||
        [[UIDevice getDeviceTypeString] isEqualToString:@"iPhone XR"] ||
        [[UIDevice getDeviceTypeString] isEqualToString:@"iPhone XS"] ||
        [[UIDevice getDeviceTypeString] isEqualToString:@"iPhone XS Max"]) {
        return YES;
    } else {
        return NO ;
    }
}

+ (BOOL)isIPad {
    if ([[UIDevice getDeviceTypeString] containsString:@"iPad"]) {
        return YES;
    } else {
        return NO;
    }
}




+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur{
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    
    int boxSize     = (int)(blur * 100); //100为最大模糊程度
    boxSize         = boxSize - (boxSize % 2) + 1;
    CGImageRef img  = image.CGImage;
    
    vImage_Buffer     inBuffer, outBuffer;
    vImage_Error      error;
    
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData       = CGDataProviderCopyData(inProvider);
    
    //设置从CGImage获取对象的属性
    void *pixelBuffer;
    inBuffer.width      = CGImageGetWidth(img);
    inBuffer.height     = CGImageGetHeight(img);
    inBuffer.rowBytes   = CGImageGetBytesPerRow(img);
    inBuffer.data       = (void*)CFDataGetBytePtr(inBitmapData);
    pixelBuffer         = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    if(!pixelBuffer)
        NSLog(@"No pixelbuffer");
    outBuffer.data      = pixelBuffer;
    outBuffer.width     = CGImageGetWidth(img);
    outBuffer.height    = CGImageGetHeight(img);
    outBuffer.rowBytes  = CGImageGetBytesPerRow(img);
    error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                       &outBuffer,
                                       NULL,
                                       0,
                                       0,
                                       boxSize,
                                       boxSize,
                                       NULL,
                                       kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate( outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef  = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //清除;
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef);
    
    return returnImage;
}



@end
