//
//  redBagViewController.m
//  sanxi
//
//  Created by liangang on 2017/6/10.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "redBagViewController.h"
#import "redBagTableViewCell.h"
@interface redBagViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *sourceArray;
}
@end

@implementation redBagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"红包卡券";
    [self loadData];
    self.tableView.tableFooterView = [[UIView alloc]init];
   self. tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadData
{
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    discountAllApi *api = [[discountAllApi alloc]init];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%@",request.responseString);
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];

        sourceArray = request.responseJSONObject;
        [self.tableView reloadData];
    } failure:^(__kindof YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];

         NSLog(@"%@",request.responseString);
    }];
}
- (IBAction)activeCodeBtnClick:(id)sender {
    if (self.codeTextField.text.length==0) {
        [extendMethod showMessage:@"请输入激活码"];
    }
    else
    {
        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        activediscountApi *api = [[activediscountApi alloc]init];
        api.activeCode = self.codeTextField.text;
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            NSLog(@"%@",request .responseString);
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            [extendMethod showMessage:request.responseJSONObject[@"message"]];
            if ([request.responseJSONObject[@"result"] integerValue]==1) {
                [self loadData];
            }
        } failure:^(__kindof YTKBaseRequest *request) {
             NSLog(@"%@",request .responseString);
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];

        }];
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return sourceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    redBagTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"redBagTableViewCell" owner:nil options:nil] objectAtIndex:0];
    NSDictionary *dic = [sourceArray objectAtIndex:indexPath.row];
    cell.titleLabel .text = [NSString stringWithFormat:@"%@",dic[@"DiscountName"]];
    cell.timeLabel.text = [NSString stringWithFormat:@"有效期：%@至%@",dic[@"StartDate"],dic[@"EndDate"]];
    cell.priceLabel.text = [NSString stringWithFormat:@"¥%.0f",[dic[@"Price"] floatValue]];
   
    return cell;
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
