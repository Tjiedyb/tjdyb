//
//  forgetPasswordViewController.m
//  sanxi
//
//  Created by liangang on 2017/6/15.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "forgetPasswordViewController.h"

@interface forgetPasswordViewController ()
{
    NSInteger secondsCountDown;
    NSTimer *countDownTimer;
}
@end

@implementation forgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(upload)] ;
    self.title = @"忘记密码";
    secondsCountDown = 60;
    // Do any additional setup after loading the view from its nib.
}
-(void)upload
{
   
    if (self.phoneTextField.text.length==0) {
        [extendMethod showMessage:@"请输入手机号"];
        return;
        
    }
    if (self.passWordTextField.text.length==0) {
        [extendMethod showMessage:@"请输入密码"];
        return;
    }
    if (self.rePassWordTextField.text.length == 0) {
        [extendMethod showMessage:@"请输入密码"];
        return;
    }
    if (self.codeTextField.text.length==0   )
    {
        [extendMethod showMessage:@"请输入验证码"];
        return;
    }
    if (![self.passWordTextField.text isEqualToString:self.rePassWordTextField.text]) {
        [extendMethod showMessage:@"两次输入的密码不一致"];
        return;
    }
    forgetPassWordApi *api = [[forgetPassWordApi alloc]init];
    api.Code = self.codeTextField.text;
    api.PhoneNumber = self.phoneTextField.text;
    api.RePassword  = self.rePassWordTextField.text;
    api.Password     = self.passWordTextField.text;
    [MBProgressHUD showHUDAddedTo:[UIApplication     sharedApplication].keyWindow animated:YES];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%@",request.responseString);
        NSLog(@"%@",request.responseString);
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        [extendMethod showMessage:request.responseJSONObject[@"message"]];
        if ([request.responseJSONObject[@"result"] integerValue]==1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
          NSLog(@"%@",request.responseString);
         [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)SMSCodeAction:(id)sender {
    if (self.phoneTextField.text.length==0 ) {
        [extendMethod showMessage:@"请输入手机号码"];
        return;
    }
    [sender setUserInteractionEnabled:NO];
    [sender setBackgroundColor:[UIColor colorWithWhite:0.800 alpha:1.000]];
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethed:) userInfo:sender repeats:YES];
    [countDownTimer fire];
    
    getvalidationcodeApi *api = [[getvalidationcodeApi alloc]init];
    api.phone = self.phoneTextField.text;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        
    } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%@",request.responseString);
    }];
}
-(void)timeFireMethed:(NSTimer *)timer
{
    secondsCountDown--;
    //    NSLog(@"%@",timer.userInfo);
    UIButton *button = timer.userInfo;
    [button setTitle:[NSString stringWithFormat:@"%ldS",(long)secondsCountDown] forState:UIControlStateNormal];
    if (secondsCountDown==0) {
        [countDownTimer invalidate];
        [button setUserInteractionEnabled:YES];
        [button setTitle:@"发送验证码" forState:UIControlStateNormal];
        button.layer.cornerRadius = 5;
        // [button setBackgroundColor:GREEN];
        secondsCountDown = 60;
        
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.tabBarController.tabBar.hidden  = YES;
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
