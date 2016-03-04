//
//  NSImage+ANImageBitmapRep.h
//  ImageBitmapRep
//
//  Created by Alex Nichol on 10/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#if TARGET_OS_IPHONE != 1

#import <UIKit/UIKit.h>

@class ANImageBitmapRep;

@interface UIImage (ANImageBitmapRep)

#if __has_feature(objc_arc) == 1
+ (UIImage *)imageFromImageBitmapRep:(ANImageBitmapRep *)ibr __attribute__((ns_returns_autoreleased));
- (ANImageBitmapRep *)imageBitmapRep __attribute__((ns_returns_autoreleased));
- (UIImage *)imageByScalingToSize:(CGSize)sz __attribute__((ns_returns_autoreleased));
- (UIImage *)imageFittingFrame:(CGSize)sz __attribute__((ns_returns_autoreleased));
- (UIImage *)imageFillingFrame:(CGSize)sz __attribute__((ns_returns_autoreleased));
#else
+ (UIImage *)imageFromImageBitmapRep:(ANImageBitmapRep *)ibr;
- (ANImageBitmapRep *)imageBitmapRep;
- (UIImage *)imageByScalingToSize:(CGSize)sz;
- (UIImage *)imageFittingFrame:(CGSize)sz;
- (UIImage *)imageFillingFrame:(CGSize)sz;
#endif

@end

#endif
