//
//  ectendMethod.h
//  shopCase
//
//  Created by liangang on 16/5/13.
//  Copyright © 2016年 liangang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
@interface extendMethod : NSObject
+(void)showMessage:(NSString *)message;
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
+(void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;
+(NSString *) md5:(NSString *) string;
+(NSMutableDictionary *)dicCheck:(NSDictionary *)dic;
+(NSString *)timeWithTimeIntervalString:(NSString *)timeString;
+(NSString *)timeWithTimeIntervalString1:(NSString *)timeString;
+(CGSize)labelSIze:(CGSize)_rec Font:(UIFont*)_font textString:(NSString *)_str;
@end
