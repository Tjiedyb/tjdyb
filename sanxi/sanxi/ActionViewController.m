//
//  ActionViewController.m
//  sanxi
//
//  Created by Tjie on 2018/8/10.
//  Copyright © 2018年 liangang. All rights reserved.
//

#import "ActionViewController.h"

@interface ActionViewController ()

@end

@implementation ActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(doBack)];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"活动列表";
}

- (void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
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
