//
//  newsListViewController.m
//  sanxi
//
//  Created by liangang on 17/5/11.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "newsListViewController.h"
#import "newsDetailViewController.h"
#import "webViewViewController.h"
@interface newsListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *sourceArray;
    NSInteger page;
}
@end

@implementation newsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    sourceArray = [[NSMutableArray alloc]init];
    self.tableView.mj_header     = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page=0;
        [self loadData:page];
    }];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        page++;
        [self loadData:page];
    }];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.tableView.mj_header beginRefreshing];
    if (self.type == headlinestoday) {
        self.title = @"今日头条";
    }
    if (self.type == financialtransactions  )
    {
        self.title = @"理财指点";
    }
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [[GlobService sharedInstance].tabBarView setHidden:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadData:(NSInteger )_page
{
    if (self.type==headlinestoday) {
        headlinestodayApi    *api = [[headlinestodayApi alloc]init];
        api.page =_page;
        
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer    endRefreshing];
            if (_page==0) {
                [sourceArray removeAllObjects];
            }
            [sourceArray addObjectsFromArray:request.responseJSONObject[@"News"]];
            [self.tableView reloadData];
        } failure:^(__kindof YTKBaseRequest *request) {
            
        }];
    }
    if (self.type==financialtransactions) {
        financialtransactionsApi   *api = [[financialtransactionsApi alloc]init];
        api.page =_page;
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer    endRefreshing];
            if (_page==0) {
                [sourceArray removeAllObjects];
            }
            [sourceArray addObjectsFromArray:request.responseJSONObject[@"News"]];
            [self.tableView reloadData];
        } failure:^(__kindof YTKBaseRequest *request) {
            
        }];
        
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return sourceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    NSDictionary *dic = sourceArray[indexPath.row];
    cell.textLabel.text =dic[@"Title"];
    cell.detailTextLabel.text = dic[@"PublishedOn"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = sourceArray[indexPath.row];
    webViewViewController *vc = [[webViewViewController alloc]init];
    vc.url = [NSString stringWithFormat:@"http://mobile.htjh.group/News/Detail/%@",dic[@"Id"]];
    //    [self.navigationController pushViewController:vc animated:YES];
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
