//
//  loginViewController.m
//  sanxi
//
//  Created by liangang on 17/5/16.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "loginViewController.h"
#import "forgetPasswordViewController.h"
#import "registerViewController.h"
@interface loginViewController ()

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registerBtnClick:(id)sender {
    registerViewController *vc = [[registerViewController alloc]init];
    self.hidesBottomBarWhenPushed= YES;
    [[GlobService sharedInstance].tabBarView setHidden:YES];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed= NO;
}
- (IBAction)loginBtnClick:(id)sender {
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    loginApi *api = [[loginApi alloc]init];
    api.passWord = self.passWordTextField.text;
    api.userName = self.userNameTextField.text;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%@",request.responseString);
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated: YES];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginInfo"];
        [[NSUserDefaults standardUserDefaults] setObject:request.responseJSONObject forKey:@"loginInfo"];
        [self.navigationController popViewControllerAnimated:YES];
        [[GlobService sharedInstance].webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://mobile.htjh.group/List?token=%@",[GlobService sharedInstance].model.access_token]]]];
    } failure:^(__kindof YTKBaseRequest *request) {
         NSLog(@"%@",request.responseString);
        
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated: YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"消息" message:request.responseJSONObject[@"error_description"] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
        
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden  = YES;
}
- (IBAction)forgetBtnClick:(id)sender {
    forgetPasswordViewController *vc  = [[forgetPasswordViewController alloc]init];
    self.hidesBottomBarWhenPushed= YES;
    [[GlobService sharedInstance].tabBarView setHidden:YES];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed= NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
