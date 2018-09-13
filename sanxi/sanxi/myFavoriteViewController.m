//
//  myFavoriteViewController.m
//  sanxi
//
//  Created by liangang on 2017/6/1.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "myFavoriteViewController.h"
#import "favoriteModel.h"
#import "myFavTableViewCell.h"
#import "webViewViewController.h"
@interface myFavoriteViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    NSInteger page;
    NSMutableArray *sourceArray;
    favoriteModel *temp;
}
@end

@implementation myFavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
//    [self loadData:1];
    self.tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self loadData:page];
    }];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        page ++;
        [self loadData:page];
    }];
    sourceArray = [[NSMutableArray alloc]init];
    self.tableView.tableFooterView = [[UIView alloc]init];
//    [self.tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView.mj_header beginRefreshing];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
-(void)loadData:(NSInteger)_page
{
    favouriteitemsApi    *api = [[favouriteitemsApi   alloc]init];
    api.pageSize =999;
    api.page = _page;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%@",request.responseString);
        [self.tableView.mj_header endRefreshing ];
        [self.tableView.mj_footer endRefreshing];
        if (_page==1) {
            [sourceArray removeAllObjects];
        }
        [request.responseJSONObject[@"Data"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            favoriteModel *model = [[favoriteModel    alloc]init];
            [model setValuesForKeysWithDictionary:obj];
            [sourceArray addObject:model];
            [self.tableView reloadData];
        }];
        
        
    } failure:^(__kindof YTKBaseRequest *request) {
          NSLog(@"%@",request.responseString);
    }];
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
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
//    }
    favoriteModel *Model = sourceArray[indexPath.row];
//    cell.textLabel.text =Model.EntityName;
//    cell.detailTextLabel.text = Model.CreatedOn;
//    return cell;
    myFavTableViewCell   *cell = [[[NSBundle mainBundle] loadNibNamed:@"myFavTableViewCell" owner:nil options:nil] objectAtIndex:0];
    cell.nameLabel.text =Model.EntityName;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteBtn.tag = indexPath.row;
    cell.timeLabel.text = Model.CreatedOn;
    
    return cell;
}
-(void)deleteBtnClick:(UIButton *)sender
{
    temp = sourceArray[sender.tag];
    UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:@"消息" message:@"是否删除收藏" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        removeFavApi *api = [[removeFavApi alloc]init];
        api.Id = [temp.Id integerValue];
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            NSLog(@"%@",request.responseString);
            [self.tableView.mj_header beginRefreshing];
        } failure:^(__kindof YTKBaseRequest *request) {
             NSLog(@"%@",request.responseString);
        }];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    https://3x.ezhancms.com/CrowdFund/Detail/5
    favoriteModel    *model = [sourceArray objectAtIndex:indexPath.row];
    webViewViewController *vc = [[webViewViewController alloc]init   ];
    vc.url = [NSString stringWithFormat:@"http://mobile.htjh.group/CrowdFund/Detail/%@",model.EntityId];
    [self.navigationController pushViewController:vc animated:YES];
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
