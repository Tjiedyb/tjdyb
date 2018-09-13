//
//  GlobTabBar.m
//  sanxi
//
//  Created by liangang on 17/5/9.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "GlobTabBar.h"
#import "loginViewController.h"
#import "homeViewController.h"
#import "KFChatViewController.h"
@implementation GlobTabBar


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)tabBarClick:(UIButton *)sender {
    
    if (sender.tag==5) {
         UINavigationController *home =     [[GlobService sharedInstance].tabBar.viewControllers objectAtIndex:0];
//        home.hidesBottomBarWhenPushed = YES;
//        [[GlobService sharedInstance].tabBarView setHidden:YES];
//        //    [self.navigationController pushViewController:vc animated:YES];
//        //    self.hidesBottomBarWhenPushed= NO;
//        
//        [home pushViewController:[[KFChatViewController alloc]initWithMetadata:@[@{@"name":@"系统",@"value":@"IOS"}]] animated:YES];
//        home.hidesBottomBarWhenPushed = NO;
//        return;
        
        kfc = [[KFChatViewController alloc]initWithMetadata:@[@{@"name":@"系统",@"value":@"IOS"}]];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:kfc];
        [home.tabBarController presentViewController:nav animated:YES completion:nil];
         [[GlobService sharedInstance].tabBarView setHidden:YES];
        return;
        
    }
    if (sender.tag!=0&&sender.tag!=2) {
        if (![GlobService sharedInstance].model) {
            [extendMethod showMessage:@"请先登录"];
           [[GlobService sharedInstance].tabBar setSelectedIndex:0];

            loginViewController *vc = [[loginViewController alloc]init];
            UINavigationController *home =     [[GlobService sharedInstance].tabBar.viewControllers objectAtIndex:0];
            
            home.hidesBottomBarWhenPushed= YES;
            [[GlobService sharedInstance].tabBarView setHidden:YES];
            [home pushViewController:vc animated:YES];
            home.hidesBottomBarWhenPushed= NO;
            return;

        }
    }
    [[GlobService sharedInstance].tabBar setSelectedIndex:sender.tag];
//    [GlobService     sharedInstance].tabBarView.hidden = YES;
}

@end
