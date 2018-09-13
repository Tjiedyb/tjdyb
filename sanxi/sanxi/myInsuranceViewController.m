//
//  myInsuranceViewController.m
//  sanxi
//
//  Created by liangang on 2017/6/1.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "myInsuranceViewController.h"

@interface myInsuranceViewController ()

@end

@implementation myInsuranceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"基金管理";
    self.loginBtn.layer.borderWidth = 1;
    self.loginBtn.layer.borderColor = [UIColor colorWithHex:0xe5372a].CGColor;
    self.applyBtn.layer.borderWidth =1;
    self.applyBtn.layer.borderColor =[UIColor colorWithHex:0xe5372a].CGColor;

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
