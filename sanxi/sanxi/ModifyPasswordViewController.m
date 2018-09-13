//
//  ModifyPasswordViewController.m
//  sanxi
//
//  Created by liangang on 2017/6/15.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "ModifyPasswordViewController.h"

@interface ModifyPasswordViewController ()

@end

@implementation ModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.actionBtn.backgroundColor = RED;
    self.title = @"修改密码";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionBtnClick:(id)sender {
    
    resetpasswordApi *api = [[resetpasswordApi alloc    ]init];
    api.oldPassword = self.oldPasswordTextField.text;
    api.a = self.NewPasswordTextField .text;
    api.confirmPassword = self.confimPasswordTextFiled  .text;
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES   ];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        NSLog(@"%@",request.responseString);
    } failure:^(__kindof YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];

         NSLog(@"%@",request.responseString);
    }];
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
