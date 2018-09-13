//
//  ectendMethod.m
//  shopCase
//
//  Created by liangang on 16/5/13.
//  Copyright © 2016年 liangang. All rights reserved.
//

#import "extendMethod.h"
#import <CommonCrypto/CommonDigest.h>
@implementation extendMethod
+(void)showMessage:(NSString *)message
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithWindow:[UIApplication sharedApplication].keyWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    
    
    //    MBProgressHUD *hud = [MBProgressHUD alloc]
    hud.mode = MBProgressHUDModeText;
    [hud setRemoveFromSuperViewOnHide:YES];
    hud.detailsLabelText = message;
    [hud show:YES];
    [hud hide:YES afterDelay:1];
    
}
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
+(void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    // and then we write it out
    [imageData writeToFile:fullPathToFile atomically:NO];
}
+(NSString *) md5:(NSString *) input
{
    if (!input) {
        return @"";
    }
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}
+(NSMutableDictionary   *)dicCheck:(NSDictionary *)dic
{
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNull class]]) {
            obj = @"";
        }
        [tempDic setObject:obj forKey:key];
    }];
    return tempDic;
}
+(NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    //    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    //    [formatter setDateStyle:NSDateFormatterMediumStyle];
    //    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日 hh:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
+(NSString *)timeWithTimeIntervalString1:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    //    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    //    [formatter setDateStyle:NSDateFormatterMediumStyle];
    //    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
+(CGSize)labelSIze:(CGSize)_rec Font:(UIFont*)_font textString:(NSString *)_str
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:_font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [_str boundingRectWithSize:_rec options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return labelSize;
    
}

@end
