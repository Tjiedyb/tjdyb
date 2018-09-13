//
//  AppDelegate.m
//  sanxi
//
//  Created by liangang on 17/5/4.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "AppDelegate.h"
//#import "CYLTabBarController.h"
#import "homeViewController.h"
#import "fundViewController.h"
#import "CrowdFundingViewController.h"
#import "InsuranceViewController.h"
#import "financingViewController.h"
#import "netLoanViewController.h"
#import "GlobTabBar.h"
#import "YTKNetworkConfig.h"
#import "mineViewController.h"
#import <KF5SDK/KF5SDK.h>
#import <AlipaySDK/AlipaySDK.h>
#import "JPUSHService.h"
#import "webViewViewController.h"
#import "userApi.h"
#import "customerWebViewViewController.h"
#import "BaoxianViewController.h"
@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:@"9fdc6ce7101b5754d0dc00bd"
                          channel:@"app store"
                 apsForProduction:YES
            advertisingIdentifier:nil];
    
//    userApi  *api  = [[userApi alloc ]init];
//    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"%@",request.responseString);
//        NSDictionary *dic = request.responseJSONObject;
//        if ([dic[@"url"] isEqualToString:@"http://baidu.com"]) {
////                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"URL"];
////                        [[NSUserDefaults standardUserDefaults] setObject:request.responseJSONObject forKey:@"URL"];
//        }
//        else
//        {
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"URL"];
//
//            [[NSUserDefaults standardUserDefaults] setObject:request.responseJSONObject forKey:@"URL"];
//        }
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"%@",request.responseString);
//    }];
//    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"URL"];
//    if (dic) {
//        customerWebViewViewController *vc = [[customerWebViewViewController   alloc]init];
//        self.window.rootViewController = vc;
//    }
//    else
//    {
//
//
////        mainViewController  *vc = [[mainViewController alloc]init];
////        UINavigationController *nav = [[UINavigationController   alloc]initWithRootViewController:vc];
////        self.window.rootViewController = nav;
//    }

    [self CreatTabBar];
    [self customizeInterface    ];
    GlobTabBar *tab = [[[NSBundle mainBundle] loadNibNamed:@"GlobTabBar" owner:nil options:nil] objectAtIndex:0];
    [[UIApplication sharedApplication].keyWindow addSubview:tab];
    [tab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(tab.superview);
        make.height.mas_equalTo(50);
    }];
    [GlobService sharedInstance].tabBarView = tab;
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = @"https://www.htjh.group/";
    
    //    [[[KFConfig shareConfig]initializeWithHostName:@"https://zjgh.kf5.com" appId:@"001593274b55fdc7135c34864cc475207f3d3d6f33289aba"];
    [[KFConfig shareConfig] initializeWithHostName:@"https://zjgh.kf5.com" appId:@"001593274b55fdc7135c34864cc475207f3d3d6f33289aba"];
    NSLog(@"当前版本%@",[KFConfig shareConfig].version);
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
   
    return YES;
}

-(void)CreatTabBar
{
    
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : @"",
                                                 CYLTabBarItemSelectedImage : @"",
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"基金",
                                                  CYLTabBarItemImage : @"",
                                                  CYLTabBarItemSelectedImage : @"",
                                                  };
        NSDictionary *thirdTabBarItemsAttributes = @{
                                                      CYLTabBarItemTitle : @"保险",
                                                      CYLTabBarItemImage : @"",
                                                      CYLTabBarItemSelectedImage : @"",
                                                      };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"保险",
                                                  CYLTabBarItemImage : @"",
                                                  CYLTabBarItemSelectedImage : @"",
                                                  };
    NSDictionary *fifthTabBarItemsAttributes  =@{
                                                 CYLTabBarItemTitle : @"融租",
                                                 CYLTabBarItemImage : @"",
                                                 CYLTabBarItemSelectedImage : @"",
                                                 };
    NSDictionary *sixthTabBarItemsAttributes  =@{
                                                 CYLTabBarItemTitle : @"网贷",
                                                 CYLTabBarItemImage : @"",
                                                 CYLTabBarItemSelectedImage : @"",
                                                 };

    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes,
                                       fifthTabBarItemsAttributes,
                                       sixthTabBarItemsAttributes
                                       ];
    homeViewController *first = [[homeViewController alloc]init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:first];
    fundViewController *second = [[fundViewController alloc]init];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:second];
    BaoxianViewController  *third = [[BaoxianViewController alloc]init];
    UINavigationController *nav3 = [[UINavigationController   alloc]initWithRootViewController:third];
    InsuranceViewController *fourth = [[InsuranceViewController alloc]init];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:fourth];
    financingViewController *fifth = [[financingViewController alloc]init];
    UINavigationController   *nav5 = [[UINavigationController alloc]initWithRootViewController:fifth];
    mineViewController *sixth = [[mineViewController alloc]init];
    UINavigationController *nav6 = [[UINavigationController   alloc]initWithRootViewController:sixth];
    NSArray *viewControllers = @[nav1,nav2,nav3,nav4,nav5,nav6];
    
    
    
//    firstTabBarViewController *first = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"firstTabBarViewController"];
//    UINavigationController   *nav1 = [[UINavigationController alloc]initWithRootViewController:first];
//    secondTabBarViewController *second = [[secondTabBarViewController alloc]init];
//    UINavigationController *nav2 = [[UINavigationController   alloc]initWithRootViewController:second];
//    //    ThirdTabBarViewController *third = [[ThirdTabBarViewController alloc]init];
//    //    UINavigationController   *nav3 =[[UINavigationController  alloc  ]initWithRootViewController:third];
//    fourthTabBarViewController *fourth = [[fourthTabBarViewController alloc]init];
//    UINavigationController   *nav4 = [[UINavigationController alloc]initWithRootViewController:fourth];
//    NSArray *viewControllers = @[nav1,nav2,nav4];
//    
    self.tabBar = [[CYLTabBarController alloc]initWithViewControllers:viewControllers tabBarItemsAttributes:tabBarItemsAttributes];
    self.tabBar.tabBar.hidden = YES;
    self.window.rootViewController = self.tabBar;
    [GlobService sharedInstance].tabBar = self.tabBar;
}
-(void)customizeInterface
{
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    dict2[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [item setTitleTextAttributes:dict2 forState:UIControlStateNormal];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //    [item setTintColor:[UIColor whiteColor]];
    [item setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -64) forBarMetrics:UIBarMetricsDefault];
    //    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithRed:0.310 green:0.561 blue:0.804 alpha:1.000]];
    //    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RED} forState:UIControlStateSelected];
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [AppDelegate createImageWithColor:[UIColor colorWithRed:165/255.0f green:15 /255.0f blue:15/255.0f alpha:1.000]];
        
        textAttributes = @{
                           NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName : [UIColor whiteColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [self createImageWithColor:[UIColor colorWithRed:0.310 green:0.561 blue:0.804 alpha:1.000]];
        //        textAttributes = @{
        //                           UITextAttributeFont : [UIFont boldSystemFontOfSize:18],
        //                           UITextAttributeTextColor : [UIColor blackColor],
        //                           UITextAttributeTextShadowColor : [UIColor clearColor],
        //                           UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
        //                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    [navigationBarAppearance setShadowImage:[[UIImage alloc] init]];
}
+ (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return theImage;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([resultDic[@"resultStatus"] intValue]==9000) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"支付成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                //[self.payVC.navigationController popViewControllerAnimated:YES ];
//                if (self.isPop) {
//                    [self.payVC.navigationController popViewControllerAnimated:YES];
//                    return ;
//                }
//                [self.payVC.navigationController popToRootViewControllerAnimated:YES];
//                [self.payVC.tabBarController setSelectedIndex:2];
            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"支付失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            
        }];
    }
     return  YES;
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([resultDic[@"resultStatus"] integerValue]==9000) {
                [extendMethod showMessage:@"支付成功"];
            }
            else
            {
                [extendMethod showMessage:@"支付失败"];

            }
            webViewViewController *web = [[webViewViewController alloc]init];
            web.url = [NSString stringWithFormat:@"http://mobile.htjh.group/User/MyCrowdfunding?token=%@",[GlobService sharedInstance].model.access_token];
            UIViewController *vc = [AppDelegate getCurrentVC];
            vc.hidesBottomBarWhenPushed= YES;
            [[GlobService sharedInstance].tabBarView setHidden:YES];
            [vc.navigationController pushViewController:web animated:YES];
            vc.hidesBottomBarWhenPushed= NO;

        }];
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}

+ (UIViewController *)getCurrentVC {
    
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    if (!window) {
        return nil;
    }
    UIView *tempView;
    for (UIView *subview in window.subviews) {
        if ([[subview.classForCoder description] isEqualToString:@"UILayoutContainerView"]) {
            tempView = subview;
            break;
        }
    }
    if (!tempView) {
        tempView = [window.subviews lastObject];
    }
    
    id nextResponder = [tempView nextResponder];
    while (![nextResponder isKindOfClass:[UIViewController class]] || [nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UITabBarController class]]) {
        tempView =  [tempView.subviews firstObject];
        
        if (!tempView) {
            return nil;
        }
        nextResponder = [tempView nextResponder];
    }
    return  (UIViewController *)nextResponder;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    //    [APService stopLogPageView:@"aa"];
    // Sent when the application is about to move from active to inactive state.
    // This can occur for certain types of temporary interruptions (such as an
    // incoming phone call or SMS message) or when the user quits the application
    // and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down
    // OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate
    // timers, and store enough application state information to restore your
    // application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called
    // instead of applicationWillTerminate: when the user quits.
    
    //[[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the
    // application was inactive. If the application was previously in the
    // background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if
    // appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //    rootViewController.deviceTokenValueLabel.text =
    //    [NSString stringWithFormat:@"%@", deviceToken];
    //    rootViewController.deviceTokenValueLabel.textColor =
    //    [UIColor colorWithRed:0.0 / 255
    //                    green:122.0 / 255
    //                     blue:255.0 / 255
    //                    alpha:1];
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS6及以下系统，收到通知:%@", [self logDic:userInfo]);
    //    [rootViewController addNotificationCount];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS7及以上系统，收到通知:%@", [self logDic:userInfo]);
    
    if ([[UIDevice currentDevice].systemVersion floatValue]<10.0 || application.applicationState>0) {
        //        [rootViewController addNotificationCount];
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler
{
    //    notification.
    //    NSDictionary * userInfo = notification.request.content.userInfo;
    //
    //    UNNotificationRequest *request = notification.request; // 收到推送的请求
    //    UNNotificationContent *content = request.content; // 收到推送的消息内容
    //
    //    NSNumber *badge = content.badge;  // 推送消息的角标
    //    NSString *body = content.body;    // 推送消息体
    //    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    //    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    //    NSString *title = content.title;  // 推送消息的标题
    //
    //    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    //        [JPUSHService handleRemoteNotification:userInfo];
    //        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
    //
    //        //        [rootViewController addNotificationCount];
    //
    //    }
    //    else {
    //        // 判断为本地通知
    //        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    //    }
    //    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    //    NSDictionary * userInfo = response.notification.request.content.userInfo;
    //    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    //    UNNotificationContent *content = request.content; // 收到推送的消息内容
    //
    //    NSNumber *badge = content.badge;  // 推送消息的角标
    //    NSString *body = content.body;    // 推送消息体
    //    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    //    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    //    NSString *title = content.title;  // 推送消息的标题
    //
    //    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    //        [JPUSHService handleRemoteNotification:userInfo];
    //        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
    //        //        [rootViewController addNotificationCount];
    //
    //    }
    //    else {
    //        // 判断为本地通知
    //        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    //    }
    //
    //    completionHandler();  // 系统要求执行这个方法
}
#endif

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}



@end
