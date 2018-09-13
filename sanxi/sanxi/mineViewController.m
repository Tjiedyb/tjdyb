//
//  mineViewController.m
//  sanxi
//
//  Created by liangang on 17/5/17.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "mineViewController.h"
#import "myFundViewController.h"
#import "myCrowdFundingViewController.h"
#import "myInsuranceViewController.h"
#import "myFavoriteViewController.h"
#import "securityCertificationViewController.h"
#import "ModifyPasswordViewController.h"
#import "redBagViewController.h"
#import "KFChatViewController.h"
#import "webViewViewController.h"
@interface mineViewController ()

@end

@implementation mineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    self.bgView .backgroundColor = RED;
    customeramountApi *api = [[customeramountApi alloc]init];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%@",request.responseString);
        self.TotalAmountLabel.text =[NSString stringWithFormat:@"%@", request.responseJSONObject[@"TotalAmount"]];
        self.TotalProfitLabel.text = [NSString stringWithFormat:@"%@",request.responseJSONObject[@"TotalProfit"]];
        self.CurrentProfitLabel.text = [NSString stringWithFormat:@"%@",request.responseJSONObject[@"CurrentProfit"]];
    } failure:^(__kindof YTKBaseRequest *request) {
         NSLog(@"%@",request.responseString);
    }];
//
    [self.scrollView addSubview:self.temoBgView];
    self.temoBgView.frame = CGRectMake(0, 0, WIDTH, 345);
    self.scrollView.contentSize = CGSizeMake(WIDTH, 345+50);
    self.nameLabel.text = [GlobService sharedInstance].model.name;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [[GlobService sharedInstance].tabBarView setHidden:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
/**
 我的基金

 @param sender ani
 */
- (IBAction)myFundBtnClick:(id)sender {
    myFundViewController *vc = [[myFundViewController alloc]init];
  //  [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed= YES;
    [[GlobService sharedInstance].tabBarView setHidden:YES];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed= NO;
   
}

/**
 我的众筹

 @param sender <#sender description#>
 */
- (IBAction)myCrowdFundingBtnClick:(id)sender {
    
    
    webViewViewController *web = [[webViewViewController alloc]init];
    web.url = [NSString stringWithFormat:@"http://mobile.htjh.group/User/MyCrowdfunding?token=%@",[GlobService sharedInstance].model.access_token];
    self.hidesBottomBarWhenPushed= YES;
    [[GlobService sharedInstance].tabBarView setHidden:YES];
    [self.navigationController pushViewController:web animated:YES];
    self.hidesBottomBarWhenPushed= NO;
//    myCrowdFundingViewController *vc = [[myCrowdFundingViewController alloc]init];
//    self.hidesBottomBarWhenPushed= YES;
//    [[GlobService sharedInstance].tabBarView setHidden:YES];
//    [self.navigationController pushViewController:vc animated:YES];
//    self.hidesBottomBarWhenPushed= NO;
}

/**
 我的保险

 @param sender <#sender description#>
 */
- (IBAction)myInsuranceBtnClick:(id)sender {
    webViewViewController *vc = [[webViewViewController alloc]init];
    vc.url = [NSString stringWithFormat:@"http://mobile.htjh.group/Lease/LeaseHistory?token=%@",[GlobService sharedInstance].model.access_token];
//    myInsuranceViewController *vc  = [[myInsuranceViewController alloc]init];
    self.hidesBottomBarWhenPushed= YES;
    [[GlobService sharedInstance].tabBarView setHidden:YES];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed= NO;
}

/**
 我的贷款

 @param sender <#sender description#>
 */
- (IBAction)myLoanBtnClick:(id)sender {
    
    
}

/**
 红包卡券

 @param sender <#sender description#>
 */
- (IBAction)myRedBagBtnClick:(id)sender {
    redBagViewController *vc = [[redBagViewController alloc]init];
    self.hidesBottomBarWhenPushed= YES;
    [[GlobService sharedInstance].tabBarView setHidden:YES];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed= NO;
    
}

/**
 我的转让

 @param sender <#sender description#>
 */
- (IBAction)myAssignmentBtnClick:(id)sender {
}

/**
 我的评价

 @param sender <#sender description#>
 */
- (IBAction)myEvaluateBtnClick:(id)sender {
    webViewViewController *web = [[webViewViewController alloc]init];
    web.url = [NSString stringWithFormat:@"http://mobile.htjh.group/User/MyRating?token=%@",[GlobService sharedInstance].model.access_token];
    self.hidesBottomBarWhenPushed= YES;
    [[GlobService sharedInstance].tabBarView setHidden:YES];
    [self.navigationController pushViewController:web animated:YES];
    self.hidesBottomBarWhenPushed= NO;
    
}

/**
在线客服

 @param sender <#sender description#>
 */
- (IBAction)customerServiceBtnClick:(id)sender {
    
    self.hidesBottomBarWhenPushed = YES;
    [[GlobService sharedInstance].tabBarView setHidden:YES];
    //    [self.navigationController pushViewController:vc animated:YES];
    //    self.hidesBottomBarWhenPushed= NO;
    [self.navigationController pushViewController:[[KFChatViewController alloc]
                                                                  initWithMetadata:@[@{@"name":@"系统",@"value":@"IOS"}]] animated:YES];
    self.hidesBottomBarWhenPushed = NO;

}

/**
 基本设置

 @param sender <#sender description#>
 */
- (IBAction)settingBtnClick:(id)sender {
    ModifyPasswordViewController *vc = [[ModifyPasswordViewController alloc]init];
    self.hidesBottomBarWhenPushed= YES;
    [[GlobService sharedInstance].tabBarView setHidden:YES];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed= NO;
}

/**
 安全认证

 @param sender <#sender description#>
 */
- (IBAction)safeBtnClick:(id)sender {
    securityCertificationViewController *vc = [[securityCertificationViewController alloc]init];
    self.hidesBottomBarWhenPushed= YES;
    [[GlobService sharedInstance].tabBarView setHidden:YES];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed= NO;
}

/**
 我的收藏

 @param sender <#sender description#>
 */
- (IBAction)storeBtnClick:(id)sender {
    myFavoriteViewController *vc = [[myFavoriteViewController alloc]init];
    self.hidesBottomBarWhenPushed= YES;
    [[GlobService sharedInstance].tabBarView setHidden:YES];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed= NO;
    
    
}

/**
 退出账号

 @param sender <#sender description#>
 */
- (IBAction)exitBtnClick:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginInfo"];

    [[GlobService sharedInstance].tabBar setSelectedIndex:0];
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
