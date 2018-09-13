//
//  myFundListViewController.m
//  sanxi
//
//  Created by liangang on 2017/6/11.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "myFundListViewController.h"

@interface myFundListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *sourceArray;
}
@end

@implementation myFundListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    sourceArray = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadData
{
    fundListApi *api = [[fundListApi alloc]init];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%@",request.responseString);
    } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%@",request.responseString);

    }];
}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
