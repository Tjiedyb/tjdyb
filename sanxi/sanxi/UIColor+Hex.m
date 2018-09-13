//
//  UIColor+Hex.m
//  iOSKDD
//
//  Created by DY029 on 13-8-14.
//  Copyright (c) 2013年 KuaiDianDing. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)
+ (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

+ (UIColor*)colorWithHex:(NSInteger)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}

+ (UIColor*)whiteColorWithAlpha:(CGFloat)alphaValue
{
    return [UIColor colorWithHex:0xffffff alpha:alphaValue];
}

+ (UIColor*)blackColorWithAlpha:(CGFloat)alphaValue
{
    return [UIColor colorWithHex:0x000000 alpha:alphaValue];
}
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *Image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();    
    return Image;
}
+ (UIImage *)createImageWithColor:(UIColor *)color AndSize:(CGSize )size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width,size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *Image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return Image;
}
@end
