//
//  GlobService.m
//  sanxi
//
//  Created by liangang on 17/5/9.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "GlobService.h"

@implementation GlobService
static GlobService *_globalService = nil;
//@synthesize languageType

+ (GlobService *) sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_globalService == nil) {
            _globalService = [[self alloc] init]; // assignment not done here
            
        }
    });
    
    return _globalService;
}
-(instancetype)init
{
    self = [super init ];
    if (!self) {
        return nil;
    }
    self.webView = [[WKWebView alloc]init];
    return self;
}
-(LoginModel *)model
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"loginInfo"]) {
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"loginInfo"];
        _model = [[LoginModel     alloc]init];
        [_model setValuesForKeysWithDictionary:dic];
        return _model;
    }
    else
        return nil;
}
//-(void)hideTabBar
//{
//    [self.tabBarView removeFromSuperview];
//}
//-(void)addTabBar
//{
//    [[UIApplication sharedApplication].keyWindow addSubview:self.tabBarView];
//}
@end


@implementation LoginModel

-(void)setValue:(id)value forKey:(NSString *)key
{
    
    if ([key isEqualToString:@".issued"]) {
        [self setValue:value forKey:@"issued"];
    }
  else  if ([key isEqualToString:@".expires"]) {
       [self setValue:value forKey:@"expires"];
    }
    else
    [super setValue:value forKey:key];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    [super setValue:value forUndefinedKey:key];
    NSLog(@"value %@ key %@",value,key);
}

@end
