//
//  UIColor+Hex.h
//  iOSKDD
//
//  Created by DY029 on 13-8-14.
//  Copyright (c) 2013年 KuaiDianDing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
+ (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*)colorWithHex:(NSInteger)hexValue;
+ (UIColor*)whiteColorWithAlpha:(CGFloat)alphaValue;
+ (UIColor*)blackColorWithAlpha:(CGFloat)alphaValue;
+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (UIImage *)createImageWithColor:(UIColor *)color AndSize:(CGSize )size;
@end