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

@implementation XSUIUtils

+ (BOOL)isX {
    if ([[self iphoneType] isEqualToString:@"iPhone X"] ||
        [[self iphoneType] isEqualToString:@"iPhone XR"] ||
        [[self iphoneType] isEqualToString:@"iPhone XS"] ||
        [[self iphoneType] isEqualToString:@"iPhone XS Max"]) {
        return YES;
    } else {
        return NO ;
    }
}

+ (BOOL)isIPad {
    if ([[self iphoneType] containsString:@"iPad"]) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSString*)iphoneType {
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone3,1"]) return@"iPhone4";
    
    if([platform isEqualToString:@"iPhone3,2"]) return@"iPhone4";
    
    if([platform isEqualToString:@"iPhone3,3"]) return@"iPhone4";
    
    if([platform isEqualToString:@"iPhone4,1"]) return@"iPhone4S";
    
    if([platform isEqualToString:@"iPhone5,1"]) return@"iPhone5";
    
    if([platform isEqualToString:@"iPhone5,2"]) return@"iPhone5";
    
    if([platform isEqualToString:@"iPhone5,3"]) return@"iPhone5c";
    
    if([platform isEqualToString:@"iPhone5,4"]) return@"iPhone5c";
    
    if([platform isEqualToString:@"iPhone6,1"]) return@"iPhone5s";
    
    if([platform isEqualToString:@"iPhone6,2"]) return@"iPhone5s";
    
    if([platform isEqualToString:@"iPhone7,1"]) return@"iPhone6Plus";
    
    if([platform isEqualToString:@"iPhone7,2"]) return@"iPhone6";
    
    if([platform isEqualToString:@"iPhone8,1"]) return@"iPhone6s";
    
    if([platform isEqualToString:@"iPhone8,2"]) return@"iPhone6sPlus";
    
    if([platform isEqualToString:@"iPhone8,4"]) return@"iPhoneSE";
    
    if([platform isEqualToString:@"iPhone9,1"]) return@"iPhone7";
    
    if([platform isEqualToString:@"iPhone9,2"]) return@"iPhone7Plus";
    
    if([platform isEqualToString:@"iPhone10,1"] || [platform isEqualToString:@"iPhone10,4"]) return@"iPhone8";
    
    if([platform isEqualToString:@"iPhone10,2"] || [platform isEqualToString:@"iPhone10,5"]) return@"iPhone8Plus";
    
    if([platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"]) return@"iPhoneX";
    
    if([platform isEqualToString:@"iPhone11,8"]) return@"iPhoneXR";
    
    if([platform isEqualToString:@"iPhone11,2"]) return@"iPhoneXS";
    
    if([platform isEqualToString:@"iPhone11,6"]) return@"iPhoneXSMax";
    
    
    if([platform isEqualToString:@"iPad2,1"]) return@"iPad2";
    
    if([platform isEqualToString:@"iPad2,2"]) return@"iPad2";
    
    if([platform isEqualToString:@"iPad2,3"]) return@"iPad2";
    
    if([platform isEqualToString:@"iPad2,4"]) return@"iPad2";
    
    if([platform isEqualToString:@"iPad2,5"]) return@"iPadMini1G";
    
    if([platform isEqualToString:@"iPad2,6"]) return@"iPadMini1G";
    
    if([platform isEqualToString:@"iPad2,7"]) return@"iPadMini1G";
    
    if([platform isEqualToString:@"iPad3,1"]) return@"iPad3";
    
    if([platform isEqualToString:@"iPad3,2"]) return@"iPad3";
    
    if([platform isEqualToString:@"iPad3,3"]) return@"iPad3";
    
    if([platform isEqualToString:@"iPad3,4"]) return@"iPad4";
    
    if([platform isEqualToString:@"iPad3,5"]) return@"iPad4";
    
    if([platform isEqualToString:@"iPad3,6"]) return@"iPad4";
    
    if([platform isEqualToString:@"iPad4,1"]) return@"iPadAir";
    
    if([platform isEqualToString:@"iPad4,2"]) return@"iPadAir";
    
    if([platform isEqualToString:@"iPad4,3"]) return@"iPadAir";
    
    if([platform isEqualToString:@"iPad4,4"]) return@"iPadMini2G";
    
    if([platform isEqualToString:@"iPad4,5"]) return@"iPadMini2G";
    
    if([platform isEqualToString:@"iPad4,6"]) return@"iPadMini2G";
    
    if([platform isEqualToString:@"iPad4,7"]) return@"iPadMini3";
    
    if([platform isEqualToString:@"iPad4,8"]) return@"iPadMini3";
    
    if([platform isEqualToString:@"iPad4,9"]) return@"iPadMini3";
    
    if([platform isEqualToString:@"iPad5,1"]) return@"iPadMini4";
    
    if([platform isEqualToString:@"iPad5,2"]) return@"iPadMini4";
    
    if([platform isEqualToString:@"iPad5,3"]) return@"iPadAir2";
    
    if([platform isEqualToString:@"iPad5,4"]) return@"iPadAir2";
    
    if([platform isEqualToString:@"iPad6,3"]) return@"iPadPro9.7";
    
    if([platform isEqualToString:@"iPad6,4"]) return@"iPadPro9.7";
    
    if([platform isEqualToString:@"iPad6,7"]) return@"iPadPro12.9";
    
    if([platform isEqualToString:@"iPad6,8"]) return@"iPadPro12.9";
    
    if([platform isEqualToString:@"i386"]) return@"iPhoneSimulator";
    
    if([platform isEqualToString:@"x86_64"]) return@"iPhoneSimulator";
    
    return platform;
    
}


/**
 高斯模糊
 @param image image
 @param blur (0 - 1 之间)
 @return image
 */
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
