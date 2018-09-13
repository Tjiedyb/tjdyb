//
//  myCrowdFundingViewController.m
//  sanxi
//
//  Created by liangang on 2017/6/1.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "myCrowdFundingViewController.h"
#import "HMSegmentedControl.h"
#import "CrowdFundModel.h"
#import "myCrowdFundCellTableViewCell.h"
#import "webViewViewController.h"
@interface myCrowdFundingViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    HMSegmentedControl *segmentedControl;
    NSInteger firstPage;
    NSInteger secondPage;
    NSInteger thirdPage;
    NSInteger fourthPage;
    NSInteger fifthPage;
    NSInteger sixthPage;
    NSMutableArray *firstSourceArray;
    NSMutableArray *secondSourceArray;
    NSMutableArray *thirdSourceArray;
    NSMutableArray *fourthSourceArray;
    NSMutableArray *fifthSourceArray;
    NSMutableArray *sixthSourceArray;
    UITableView *firstTable;
    UITableView *thirdTable;
    UITableView *secondTable;
    UITableView *fourthTable;
    UITableView *fifthTable;
    UITableView *sixthTable;

}
@end

@implementation myCrowdFundingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的众筹";
    // Do any additional setup after loading the view from its nib.
   segmentedControl  = [[HMSegmentedControl alloc]initWithSectionTitles:@[@"全部",@"待支付",@"待发货",@"待收货",@"待评价",@"退款"]];
    segmentedControl.frame = CGRectMake(0, 0, WIDTH, 50);
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    //    segmentedControl.borderType =HMSegmentedControlBorderTypeBottom;
    segmentedControl.frame = CGRectMake(0, 0, WIDTH,40);
    segmentedControl.selectionIndicatorHeight = 2;
    segmentedControl.selectionIndicatorColor = [UIColor colorWithRed:0.808 green:0.137 blue:0.251 alpha:1.000];
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName:RED};
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
//    [self loadData:1];
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT-64)];
    [self.view addSubview:self.scrollView];
   self. scrollView.pagingEnabled= YES;
  self.  scrollView.alwaysBounceHorizontal = YES;
   self. scrollView.delegate = self;
  self.  scrollView.contentSize = CGSizeMake(WIDTH*6, HEIGHT-64);
    [self creatFirstTable];
    [self creatSecondTable];
    [self creatThirdTable];
    [self creatfourthTable];
    [self creatfifthTable];
    [self creatsixthTable];
    self.automaticallyAdjustsScrollViewInsets = NO;
    firstSourceArray = [[NSMutableArray   alloc]init];
    secondSourceArray = [[NSMutableArray alloc]init];
    thirdSourceArray = [[NSMutableArray alloc]init];
    fourthSourceArray = [[NSMutableArray alloc]init];
    fifthSourceArray = [[NSMutableArray   alloc]init];
    sixthSourceArray = [[NSMutableArray   alloc]init];
    
    


    
}
-(void)loadDataPage:(NSInteger)_page State:(NSInteger)_state
{
    myCrowdFundApi *api = [[myCrowdFundApi alloc]init];
    api.page = _page;
    api.pageSize = 10;
    api.orderStatus = _state;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSArray *array = request.responseJSONObject[@"Data"];
        if (_state==0) {
            [firstTable .mj_header  endRefreshing];
            [firstTable.mj_footer endRefreshing ];
            if (_page==0) {
                [firstSourceArray removeAllObjects];
            }
            [array enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CrowdFundModel *model = [[CrowdFundModel alloc]init];
                [model setValuesForKeysWithDictionary:obj];
                [firstSourceArray addObject:model];
                
            }];
            [firstTable reloadData];
            
        }
        if (_state==1) {
            [secondTable .mj_header  endRefreshing];
            [secondTable.mj_footer endRefreshing ];
            if (_page==0) {
                [secondSourceArray removeAllObjects];
            }
            [array enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CrowdFundModel *model = [[CrowdFundModel alloc]init];
                [model setValuesForKeysWithDictionary:obj];
                [secondSourceArray addObject:model];
                
            }];
            [secondTable reloadData];
            
        }
        if (_state==5) {
            [thirdTable .mj_header  endRefreshing];
            [thirdTable.mj_footer endRefreshing ];
            if (_page==0) {
                [thirdSourceArray removeAllObjects];
            }
            [array enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CrowdFundModel *model = [[CrowdFundModel alloc]init];
                [model setValuesForKeysWithDictionary:obj];
                [thirdSourceArray addObject:model];
                
            }];
            [thirdTable     reloadData];
            
        }
        if (_state==10) {
            [fourthTable .mj_header  endRefreshing];
            [fourthTable.mj_footer endRefreshing ];
            if (_page==0) {
                [fourthSourceArray removeAllObjects];
            }
            [array enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CrowdFundModel *model = [[CrowdFundModel alloc]init];
                [model setValuesForKeysWithDictionary:obj];
                [fourthSourceArray addObject:model];
                
            }];
            [fourthTable     reloadData];
            
        }
        if (_state==15) {
            [fifthTable     .mj_header  endRefreshing];
            [fifthTable.mj_footer endRefreshing ];
            if (_page==0) {
                [fifthSourceArray removeAllObjects];
            }
            [array enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CrowdFundModel *model = [[CrowdFundModel alloc]init];
                [model setValuesForKeysWithDictionary:obj];
                [fifthSourceArray addObject:model];
                
            }];
            [fifthTable     reloadData];
            
        }
        if (_state==25) {
            [sixthTable     .mj_header  endRefreshing];
            [sixthTable.mj_footer endRefreshing ];
            if (_page==0) {
                [sixthSourceArray removeAllObjects];
            }
            [array enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CrowdFundModel *model = [[CrowdFundModel alloc]init];
                [model setValuesForKeysWithDictionary:obj];
                [sixthSourceArray addObject:model];
                
            }];
            [sixthTable     reloadData];
            
        }


        NSLog(@"%@",request.responseString);
    } failure:^(__kindof YTKBaseRequest *request) {
         NSLog(@"%@",request.responseString);
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;

    firstTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //        [self loadTatalData:0];
        firstPage = 1;
        [self loadDataPage:firstPage State:0];
        
    }];
    firstTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        firstPage++;
        //        [self loadTatalData:firstPage];
        [self loadDataPage:firstPage State:0];
        
    }];
    [firstTable.mj_header beginRefreshing];
    //    [self loadLuckyData:0];
    secondTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //        [self loadLuckyData:0];
        
        secondPage = 1;
        [self loadDataPage:secondPage State:1];
    }];
    secondTable .mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        secondPage++;
        //        [self loadLuckyData:secondPage];
        [self loadDataPage:secondPage State:1];
    }];
    [secondTable.mj_header beginRefreshing];
    
    
    thirdTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //        [self loadsearchShowAward:0];
        thirdPage = 1;
        [self loadDataPage:thirdPage State:5];
    }];
    thirdTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        thirdPage++;
        //        [self loadsearchShowAward:thirdPage];
        [self loadDataPage:thirdPage State:5];
        
        
    }];
    [thirdTable.mj_header beginRefreshing];
    
    
    
    fourthTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //        [self loadsearchShowAward:0];
        fourthPage = 1;
        [self loadDataPage:fourthPage State:10];
    }];
    fourthTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        fourthPage++;
        //        [self loadsearchShowAward:thirdPage];
        [self loadDataPage:fourthPage State:10];
        
        
    }];
    [fourthTable.mj_header beginRefreshing];
    
    
    
    fifthTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //        [self loadsearchShowAward:0];
        fifthPage = 1;
        [self loadDataPage:fifthPage State:15];
    }];
    fifthTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        fifthPage++;
        //        [self loadsearchShowAward:thirdPage];
        [self loadDataPage:fifthPage State:15];
        
        
    }];
    [fifthTable.mj_header beginRefreshing];
    
    
    
    sixthTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //        [self loadsearchShowAward:0];
        sixthPage = 1;
        [self loadDataPage:sixthPage State:25];
    }];
    sixthTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        sixthPage++;
        //        [self loadsearchShowAward:thirdPage];
        [self loadDataPage:sixthPage State:25];
        
        
    }];
    [sixthTable.mj_header beginRefreshing];

}
-(void)segmentedControlChangedValue:(HMSegmentedControl *)seg
{
    switch (seg.selectedSegmentIndex) {
        case 0:
            [self.scrollView scrollRectToVisible:firstTable.frame animated:YES];
            
            break;
        case 1:
            [self.scrollView scrollRectToVisible:secondTable.frame animated:YES];
            break;
        case 2:
            [self.scrollView scrollRectToVisible:thirdTable.frame animated:YES];
            break;
        case 3:
            [self.scrollView scrollRectToVisible:fourthTable.frame animated:YES];
            break;
        case 4:
            [self.scrollView scrollRectToVisible:fifthTable.frame animated:YES];
            break;
        case 5:
            [self.scrollView scrollRectToVisible:sixthTable.frame animated:YES];
            break;

        default:
            break;
    }

}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        int page = scrollView.contentOffset.x / self.view.bounds.size.width;
        [segmentedControl setSelectedSegmentIndex:page animated:YES ];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)creatFirstTable
{
    firstTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    firstTable.delegate = self;
    firstTable.dataSource = self;
    firstTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:firstTable];
    
}
-(void)creatSecondTable
{
    secondTable = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    secondTable.delegate = self;
    secondTable.dataSource = self;
    secondTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    secondTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:secondTable];
}
-(void)creatThirdTable
{
    thirdTable = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH*2, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    thirdTable.delegate = self;
    thirdTable.dataSource = self;
    thirdTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:thirdTable];
}
-(void)creatfourthTable
{
    fourthTable = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH*3, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    fourthTable.delegate = self;
    fourthTable.dataSource = self;
    fourthTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:fourthTable];
}
-(void)creatsixthTable
{
    sixthTable = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH*5, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    sixthTable.delegate = self;
    sixthTable.dataSource = self;
    sixthTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:sixthTable];
}
-(void)creatfifthTable
{
    fifthTable = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH*4, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    fifthTable.delegate = self;
    fifthTable.dataSource = self;
    fifthTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:fifthTable];
}

//-(void)loadData:(NSInteger )_page
//{
//    myCrowdFundApi *api = [[myCrowdFundApi alloc]init];
//    api.page =1;
//    api.pageSize = 10;
//    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
//        NSLog(@"%@",request.responseString);
//    } failure:^(__kindof YTKBaseRequest *request) {
//        NSLog(@"%@",request.responseString);
//    }];
//    
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == firstTable) {
        return firstSourceArray.count;
    }
    else if (tableView == secondTable)
    {
        return secondSourceArray.count;
    }
    else if (tableView == thirdTable)
    {
        return thirdSourceArray.count;
    }
    else if (tableView == fourthTable)
    {
        return fourthSourceArray.count;
    }
    else if (tableView == fifthTable)
    {
        return fifthSourceArray.count;
    }
    else
        
    {
        return sixthSourceArray.count;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
//    if (!cell) {
//        cell     = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CELL"];
//    }
//    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
//    return cell;、
    myCrowdFundCellTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"myCrowdFundCellTableViewCell" owner:nil options:nil] objectAtIndex:0];
    CrowdFundModel *model ;
    if (tableView == firstTable) {
        model =  [firstSourceArray objectAtIndex:indexPath.row];
    }
    else if (tableView == secondTable)
    {
         model =  [secondSourceArray    objectAtIndex:indexPath.row];
    }
    else if (tableView == thirdTable)
    {
         model =  [thirdSourceArray    objectAtIndex:indexPath.row];
    }
    else if (tableView == fourthTable )
    {
        model = [fourthSourceArray objectAtIndex:indexPath.row];
    }
    else if (tableView == firstTable )
    {
        model = [fifthSourceArray objectAtIndex:indexPath.row];
    }
    else
    {
        model = [sixthSourceArray objectAtIndex:indexPath.row];
    }
    [cell.picView sd_setImageWithURL:[NSURL URLWithString:model.strCrowedFundPhoto]];
    cell.nameLabel.text = model.CrowedFundItemName;
    cell.orderCodeLabel.text = [NSString stringWithFormat:@"订单编号：%@",model.OrderNo];
    cell.stateLabelLabel.text = [NSString stringWithFormat:@"%@",model.strStatus ];
    cell.priceLabel.text = [NSString stringWithFormat:@"%.2f",[model.SubTotal floatValue]];
    cell.model = model;
    if ([model.strStatus isEqualToString:@"已取消"])
    {
        [cell.parOrderBtn setHidden:YES];
        [cell.cancelOrderBtn setHidden:YES];
        cell.contactSellerBtn.hidden = NO;
    }
    else
    {
        [cell.parOrderBtn setHidden:NO];
        [cell.cancelOrderBtn setHidden:NO];
        cell.contactSellerBtn.hidden = NO;

    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CrowdFundModel *model ;
    if (tableView == firstTable) {
        model =  [firstSourceArray objectAtIndex:indexPath.row];
    }
    else if (tableView == secondTable)
    {
        model =  [secondSourceArray    objectAtIndex:indexPath.row];
    }
    else if (tableView == thirdTable)
    {
        model =  [thirdSourceArray    objectAtIndex:indexPath.row];
    }
    else if (tableView == fourthTable )
    {
        model = [fourthSourceArray objectAtIndex:indexPath.row];
    }
    else if (tableView == firstTable )
    {
        model = [fifthSourceArray objectAtIndex:indexPath.row];
    }
    else
    {
        model = [sixthSourceArray objectAtIndex:indexPath.row];
    }
    webViewViewController *vc = [[webViewViewController alloc]init   ];
    vc.url = [NSString stringWithFormat:@"http://mobile.htjh.group/CrowdFund/Detail/%@?token=%@",model.CrowedFundId,[GlobService sharedInstance].model.access_token];
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
