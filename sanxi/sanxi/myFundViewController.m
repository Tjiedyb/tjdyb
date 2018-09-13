//
//  myFundViewController.m
//  sanxi
//
//  Created by liangang on 2017/6/1.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "myFundViewController.h"
#import "fundModel.h"
#import "myFundTableViewCell.h"
#import "webViewViewController.h"
@interface myFundViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *sourceArray;
}
@end

@implementation myFundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的基金";
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"历史" style:UIBarButtonItemStylePlain target:self action:@selector(history)];
    [self loadData];
    sourceArray = [[NSMutableArray alloc]init];
    self.tableView.tableFooterView = [[UIView alloc]init];
    // Do any additional setup after loading the view from its nib.
}
-(void)history
{
    
}
-(void)loadData
{
    myFundOrdersApi *api = [[myFundOrdersApi alloc]init];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%@",request.responseString);
        [request.responseJSONObject[@"Data"] enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            fundModel *model = [[fundModel alloc]init];
            [model setValuesForKeysWithDictionary:obj];
            [sourceArray addObject:model];
        }];
        [self.tableView reloadData];
    } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%@",request.responseString);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return sourceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    myFundTableViewCell *cell  = [[[NSBundle mainBundle] loadNibNamed:@"myFundTableViewCell" owner:nil options:nil] objectAtIndex:0];
    fundModel *model = sourceArray[indexPath.row];
    cell.nameLabel .text = model.FundName;
    cell.BuyAmountLabel.text = [NSString stringWithFormat:@"%.2f",[model.BuyAmount floatValue]];
    cell.rateLabel.text = [NSString stringWithFormat:@"%.2f",[model.CurrentFundRate floatValue]];
    cell.TotalProfitLabel.text = [NSString stringWithFormat:@"%.2f",[model.TotalProfit floatValue]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     fundModel *model = sourceArray[indexPath.row];
    webViewViewController *vc = [[webViewViewController alloc]init   ];
    vc.url = [NSString stringWithFormat:@"http://mobile.htjh.group/Detail?id=%@&token=%@",model.FundId,[GlobService sharedInstance].model.access_token];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

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
