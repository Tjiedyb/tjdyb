    //
//  homeViewController.m
//  sanxi
//
//  Created by liangang on 17/5/9.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "homeViewController.h"
#import "homeFirstTableViewCell.h"
#import "homeSecondTableViewCell.h"
#import "homeHeadTableViewCell.h"
#import "newsListViewController.h"
#import "newsDetailViewController.h"
#import "registerViewController.h"
#import "loginViewController.h"
#import "KFUserManager.h"
#import "webViewViewController.h"

@interface homeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary *newsDic;
    BOOL loadSuccess;
}
@end

@implementation homeViewController
-(void)internetCheck
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
                case AFNetworkReachabilityStatusUnknown:
            {
                //未知网络
                NSLog(@"未知网络");
                if (!loadSuccess) {
                    [self loadNewsData];
                }
            }
                break;
                case AFNetworkReachabilityStatusNotReachable:
            {
                //无法联网
                NSLog(@"无法联网");
                
            }
                break;
                
                case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                //手机自带网络
                NSLog(@"当前使用的是2g/3g/4g网络");
                if (!loadSuccess) {
                    [self loadNewsData];
                }
            }
                break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                //WIFI
                NSLog(@"当前在WIFI网络下");
                if (!loadSuccess) {
                    [self loadNewsData];
                }
            }
                
        }
    }];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"首页";
    self.navigationItem.titleView = self.titleView;
        [self loadNewsData];
    // Do any additional setup after loading the view from its nib.
}

-(void)loadNewsData
{
    homepagenewsApi *api = [[homepagenewsApi alloc]init];
    api.n = 1;
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow  animated:YES];
        
        newsDic = request.responseJSONObject;
        [self.tableView reloadData];
        
    } failure:^(__kindof YTKBaseRequest *request) {
         NSLog(@"%@",request.responseString);
    }];
}


/**
 登录
 */
-(void)loginBtnClick
{
    loginViewController *vc = [[loginViewController alloc]init];
    self.hidesBottomBarWhenPushed= YES;
    [[GlobService sharedInstance].tabBarView setHidden:YES];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed= NO;
}

/**
 注册
 */
-(void)registerBtnClick
{
    registerViewController *vc = [[registerViewController alloc]init];
    self.hidesBottomBarWhenPushed= YES;
    [[GlobService sharedInstance].tabBarView setHidden:YES];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed= NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 1;
    if (section==0) {
        return 1;
    }
    else if (section    ==1)
    {
        NSArray *array = newsDic[@"NewsToday"];
        return array.count+1;
    }
    else
    {
        NSArray *array = newsDic[@"NewsFinancial"];
        return array.count+1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
          return 370;
    }
  else
  {
      if (indexPath.row==0) {
          return 40;
      }
      else
          return 85;
  }
      
//      return 85;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [[GlobService sharedInstance].tabBarView setHidden:NO];
    
    
    
    userDataApi  *api =[[userDataApi alloc]init];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%@",request.responseString);
        if ([KFUserManager shareUserManager].user.userToken.length == 0) {
            [[KFUserManager shareUserManager]initializeWithPhone:request.responseJSONObject[@"PhoneNumber"] completion:^(KFUser * _Nullable user, NSError * _Nullable error) {
                NSLog(@"%@",[error description]);
            }];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
         NSLog(@"%@",request.responseString);
//        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"loginInfo"]) {
//            loginViewController *vc = [[loginViewController alloc]init];
//            self.hidesBottomBarWhenPushed= YES;
//            [[GlobService sharedInstance].tabBarView setHidden:YES];
//            [self.navigationController pushViewController:vc animated:YES];
//            self.hidesBottomBarWhenPushed= NO;
//
//        }
           }];
    if ([GlobService sharedInstance].model.access_token.length>0) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:@selector(loginBtnClick)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"个人中心" style:UIBarButtonItemStyleDone target:self action:@selector(mine)];
    }
    else
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:self action:@selector(loginBtnClick)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(registerBtnClick)];
    }
    [self.navigationController setNavigationBarHidden:NO animated:NO];

}
-(void)mine
{
    [[GlobService sharedInstance].tabBar setSelectedIndex:5];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            homeFirstTableViewCell   *cell = [[[NSBundle mainBundle] loadNibNamed:@"homeFirstTableViewCell" owner:nil options:nil] objectAtIndex:0];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else
            return nil;
    }
    
    else
    {
        if (indexPath.row==0) {
            homeHeadTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"homeHeadTableViewCell" owner:nil options:nil] objectAtIndex:0]
            ;
            switch (indexPath.section) {
                case 1:
                    cell.titleLabel.text = @"今日头条";
                    break;
                case 2:
                    cell.titleLabel.text = @"理财指点";
                    break;
                default:
                    break;
            }
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }
        else
        {
            homeSecondTableViewCell *cell = [[[NSBundle mainBundle ] loadNibNamed:@"homeSecondTableViewCell" owner:nil options:nil] objectAtIndex:0];
            switch (indexPath.section) {
                case 1:
                {
                    NSArray *array =newsDic[@"NewsToday"];
                    NSDictionary *dic = array[indexPath.row-1];
                    [cell.picView sd_setImageWithURL:[NSURL URLWithString:dic[@"Thumbnail"]] placeholderImage:nil];
                    cell.titleLabel.text = dic[@"Title"];
                    cell.timeLabel.text = dic[@"PublishedOn"];

                }
                    break;
                case 2:
                {
                    NSArray *array =newsDic[@"NewsFinancial"];
                    NSDictionary *dic = array[indexPath.row-1];
                    [cell.picView sd_setImageWithURL:[NSURL URLWithString:dic[@"Thumbnail"]] placeholderImage:nil];
                    cell.titleLabel.text = dic[@"Title"];
                    cell.timeLabel.text = dic[@"PublishedOn"];
                    
                }
                    break;
                    
                default:
                    break;
            }
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
//        if (indexPath.row==0) {
//            homeSecondTableViewCell  *cell = [[[NSBundle mainBundle] loadNibNamed:@"homeSecondTableViewCell" owner:nil options:nil] objectAtIndex:0];
//             cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            return cell;
//        }
//        else
//            return nil;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        if (indexPath.section==1) {
            newsListViewController *vc = [[newsListViewController alloc]init];
            vc.type = headlinestoday ;
            self.hidesBottomBarWhenPushed= YES;
            [[GlobService sharedInstance].tabBarView setHidden:YES];
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed= NO;
            
        }
        if (indexPath.section==2) {
            newsListViewController *vc = [[newsListViewController alloc]init];
            vc.type = financialtransactions  ;
            self.hidesBottomBarWhenPushed= YES;
            [[GlobService sharedInstance].tabBarView setHidden:YES];
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed= NO;

        }
    }
    
    else
    {
        NSArray *array = [[NSArray alloc]init];
        if (indexPath.section==1)
            array =newsDic[@"NewsToday"];
        else if (indexPath.section ==2)
            array = newsDic[@"NewsFinancial"];
//        NSArray *array =newsDic[@"NewsToday"];
       NSDictionary *dic = array[indexPath.row-1];
        
//        https://3x.ezhancms.com/News/Detail/1
        webViewViewController *vc = [[webViewViewController alloc]init];
        vc.url = [NSString stringWithFormat:@"http://mobile.htjh.group/News/Detail/%@",dic[@"Id"]];
        //    [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed= YES;
        [[GlobService sharedInstance].tabBarView setHidden:YES];
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed= NO;
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
