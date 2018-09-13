//
//  registerViewController.m
//  sanxi
//
//  Created by liangang on 17/5/16.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "registerViewController.h"

@interface registerViewController ()
{
    NSInteger secondsCountDown;
    NSTimer *countDownTimer;
}
@end

@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(upLoad)];
     secondsCountDown = 60;
    self.title = @"注册";
    [self.checkBox addTarget:self action:@selector(checkboxDidChange:) forControlEvents:UIControlEventValueChanged];
    self.checkBox.textLabel.text = @"不填员工编号则注册为预览用户";
    self.checkBox.textLabel.font = [UIFont systemFontOfSize:14];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(doBack)];
    
    
//    UIBarButtonItem *btn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(doBack)];
//    UIBarButtonItem* backBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] landscapeImagePhone:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(doBack)];
//    backBtn.frame = CGRectMake(0, 0, 30, 30) ;
//    backBtn.backgroundColor = [UIColor clearColor];
//    backBtn.tintColor = [UIColor whiteColor];
//    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
//    backBtn.showsTouchWhenHighlighted=YES;
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    [self.navigationItem setLeftBarButtonItem:btn];
   
//    [self.checkBox setColor:RED forControlState:0];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    
    //2.手势相关的属性
    
    //点击次数（默认1）
    
    tapGesture.numberOfTapsRequired = 1;
    
    //手指的个数（默认1）
    
    tapGesture.numberOfTouchesRequired = 1;
    
    //3.把手势与视图相关联
    
    [self.view addGestureRecognizer:tapGesture];
}

    
-(void)tapClick:(UITapGestureRecognizer *)tap{
    
    [self.view endEditing:YES];
    
}


-(void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
   
-(void)checkboxDidChange:(CTCheckbox *)sender
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)upLoad
{
    if (self.nameTextField.text.length==0) {
        [extendMethod showMessage:@"请输入姓名"];
        return;
    }
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
    if (self.IDNumber.text.length>0) {
        
    }
    else
    {
        registerNormalApi *api =  [[registerNormalApi alloc]init];
        api.Name = self.nameTextField.text;
        api.Password = self.passWordTextField.text;
        api.VerificationCode = self.codeTextField.text;
        api.PhoneNumber = self.phoneTextField.text;
        api.RePassword = self.rePassWordTextField.text;
        api.CompanyName=self.companyNameTextField.text;
        api.AssociateStaffNo=self.workerCode.text;
        
        if (self.companyNameTextField.text.length>0) {
            api.CompanyName = self.companyNameTextField .text;
        }
        if (self.workerCode.text.length>0) {
            api.AssociateStaffNo = self.workerCode.text;
        }
        unsigned int numIvars; //成员变量个数
        Ivar *vars = class_copyIvarList(NSClassFromString(@"registerNormalApi"), &numIvars);
        //Ivar *vars = class_copyIvarList([UIView class], &numIvars);
        
        NSString *key=nil;
        NSMutableDictionary *dic= [[NSMutableDictionary alloc]init];
        for(int i = 0; i < numIvars; i++) {
            
            Ivar thisIvar = vars[i];
            key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];  //获取成员变量的名字
            NSLog(@"variable name :%@", key);
            if ([api valueForKey:key]) {
                NSMutableString     *temp = [NSMutableString stringWithString:[api valueForKey:key]];
                //        NSString *value = [temp substringFromIndex:1];
                if ([key containsString:@"_"]) {
                    NSString *keyF =   [key stringByReplacingOccurrencesOfString:@"_" withString:@"."];
                    if (temp) {
                        [dic setObject:temp forKey:[keyF substringFromIndex:1]];
                    }
                }
                
                
            }
            key = [NSString stringWithUTF8String:ivar_getTypeEncoding(thisIvar)]; //获取成员变量的数据类型
            NSLog(@"variable type :%@", key);
        }
        free(vars);
        
        api.dic = dic;
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            NSLog(@"%@",request.responseString);
            [extendMethod showMessage:request.responseJSONObject[@"message"]];
            if ([request.responseJSONObject[@"result"] integerValue]==1) {
                [self.navigationController popViewControllerAnimated:YES];
                
            }
        } failure:^(__kindof YTKBaseRequest *request) {
            
        }];
    }
    
    
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
        NSLog(@"%@",request.responseString);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
