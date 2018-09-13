//
//  GlobService.h
//  sanxi
//
//  Created by liangang on 17/5/9.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYLTabBarController.h"
#import "GlobTabBar.h"
#import <WebKit/WebKit.h>
@interface LoginModel : NSObject
@property (strong,nonatomic)NSString *access_token,*token_type,*expires_in,*name,*issued,*expires;

@end

@interface GlobService : NSObject
@property(strong,nonatomic)CYLTabBarController *tabBar;
@property(strong,nonatomic)GlobTabBar *tabBarView;
@property(strong,nonatomic)WKWebView *webView;

+ (GlobService *) sharedInstance;
@property(strong,nonatomic)LoginModel *model;
//-(void)hideTabBar;
//-(void)addTabBar;
@end
