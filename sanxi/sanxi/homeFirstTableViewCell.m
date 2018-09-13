//
//  homeFirstTableViewCell.m
//  sanxi
//
//  Created by liangang on 17/5/9.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "homeFirstTableViewCell.h"
#import "KF5SDKChat.h"
#import "firstTableViewCellCollectionViewCell.h"
#import "webViewViewController.h"
#import "registerViewController.h"
#import "loginViewController.h"
#import "fundViewController.h"
#import "CrowdFundingViewController.h"
#import "ActionViewController.h"
@implementation homeFirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    bannerSourceArray = [[NSMutableArray alloc]init];
    self.firstCircle.progressBarWidth = 3;
     self.firstCircle.transform=CGAffineTransformMakeRotation(-M_PI /2);
    [self.firstCircle setProgress:(0.5) animated:YES duration:0.4];
    self.firstCircle.hintHidden = NO;
    [self.firstCircle setHintTextGenerationBlock:^NSString *(CGFloat progress) {
        NSLog(@"%.2f",progress);
        self.firstProgressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress*100];
        return @"";
    }];
    self.secondCircle.progressBarWidth = 3;
    self.secondCircle.transform =CGAffineTransformMakeRotation(-M_PI /2);
    [self.secondCircle setProgress:(0.3) animated:YES duration:0.4];
    self.secondCircle.hintHidden = NO;
    [self.secondCircle setHintTextGenerationBlock:^NSString *(CGFloat progress) {
        NSLog(@"%.2f",progress);
        self.secondProgressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress*100];
        return @"";
    }];
    self.thirdCircle.progressBarWidth = 3;
    self.thirdCircle.transform =CGAffineTransformMakeRotation(-M_PI /2);
    [self.thirdCircle setProgress:(0.76) animated:YES duration:0.4];
    self.thirdCircle.hintHidden = NO;
    [self.thirdCircle setHintTextGenerationBlock:^NSString *(CGFloat progress) {
        NSLog(@"%.2f",progress);
        self.thirdProgressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress*100];
        return @"";
    }];
    self.bannerView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    self.bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.bannerView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    self.bannerView.delegate = self;
    self.bannerView.autoScrollTimeInterval = 3.f;
    bannerApi *api = [[bannerApi alloc]init];
    api.type =@"SY";
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%@",request.responseString);
        [request.responseJSONObject   enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [imageArray addObject:obj[@"Banner"]];
            [bannerSourceArray addObject:obj[@"CustomProperties"]];
        }];
        self.bannerView.imageURLStringsGroup = imageArray;
        
    } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%@",request.responseString);
    }];
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"firstTableViewCellCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CELL"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    productsDic = [[NSDictionary alloc]init];
    productsApi *api1 = [[productsApi alloc]init];
    [api1 startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        productsDic = request.responseJSONObject;
        [self.collectionView reloadData];
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
   
    // Initialization code
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((WIDTH-16-20)/2,73 );
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    firstTableViewCellCollectionViewCell *cell = [collectionView     dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
//    cell.backgroundColor  = [UIColor blueColor];
    if (indexPath.item==0) {
        NSDictionary *dic = productsDic[@"Fund"];
        cell.TitleLabel.text = dic[@"Title"]?dic[@"Title"]:@"";
        cell.ExpiredOnLabel.text =  [NSString stringWithFormat:@"%@",dic[@"ExpiredOn"]?dic[@"ExpiredOn"]:@""];
    }
    if (indexPath.item==1) {
        NSDictionary *dic = productsDic[@"CrowdFund"];
        if ([dic isEqual:[NSNull null]]) {
            
        }
        else
        {
        cell.TitleLabel.text =dic[@"Title"]?dic[@"Title"]:@"";
        cell.ExpiredOnLabel.text =  [NSString stringWithFormat:@"%@",dic[@"ExpiredOn"]?dic[@"ExpiredOn"]:@""];
        }

    }
    if (indexPath.item==2) {
        NSDictionary *dic = productsDic[@"Insurance"];
        cell.TitleLabel.text = dic[@"Title"];
        cell.ExpiredOnLabel.text = dic[@"ShortDesc"];
    }
    return cell;
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    
    NSDictionary *dic = bannerSourceArray[index];
   
    if ([dic[@"ProductType"] isEqualToString:@" CrowdFund"]) {
        if ([dic[@"ProductId"] integerValue]!=0) {
            webViewViewController *web = [[webViewViewController alloc]init];
            web.url = [NSString stringWithFormat:@"http://mobile.htjh.group/CrowdFund/Detail/%@",dic[@"ProductId"]];
             [self.viewController .navigationController pushViewController:web animated:YES];
        }
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        if ([GlobService sharedInstance].model.access_token.length>0) {
            NSDictionary *dic = productsDic[@"Fund"];
            webViewViewController *vc = [[webViewViewController alloc]init   ];
            vc.url = [NSString stringWithFormat:@"http://mobile.htjh.group/Fund/Detail/%@?token=%@",dic[@"Id"],[GlobService sharedInstance].model.access_token];
            [self.viewController .navigationController pushViewController:vc animated:YES];
        }
        else
        {
            loginViewController *vc = [[loginViewController alloc]init];
            self.viewController.hidesBottomBarWhenPushed= YES;
            [[GlobService sharedInstance].tabBarView setHidden:YES];
            [self.viewController    .navigationController pushViewController:vc animated:YES];
            self.viewController.hidesBottomBarWhenPushed= NO;

        }
       
    }
    if (indexPath.row==1) {
//        https://3x.ezhancms.com/CrowdFund/Detail/5
        NSDictionary *dic = productsDic[@"CrowdFund"];
        if (!dic|| [dic isEqual:[NSNull null]]) {
            return;
        }
        webViewViewController *vc = [[webViewViewController alloc]init   ];
        vc.url = [NSString stringWithFormat:@"http://mobile.htjh.group/CrowdFund/Detail/%@?token=%@",dic[@"Id"],[GlobService sharedInstance].model.access_token];
        [self.viewController .navigationController pushViewController:vc animated:YES];
    }
}
- (IBAction)kfChatBtnClick:(id)sender {
//    self.hidesBottomBarWhenPushed= YES;
    self.viewController.hidesBottomBarWhenPushed = YES;
    [[GlobService sharedInstance].tabBarView setHidden:YES];
//    [self.navigationController pushViewController:vc animated:YES];
//    self.hidesBottomBarWhenPushed= NO;
    [self.viewController.navigationController pushViewController:[[KFChatViewController alloc]
                                                   initWithMetadata:@[@{@"name":@"系统",@"value":@"IOS"}]] animated:YES];
    self.viewController.hidesBottomBarWhenPushed = NO;

    

}
- (IBAction)secondBtn:(id)sender {
    ActionViewController *vc=[[ActionViewController alloc]init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}
- (IBAction)firstBtn:(id)sender {
   
//    CrowdFundingViewController *vc = [[CrowdFundingViewController alloc]init];
//    [self.viewController.navigationController pushViewController:vc animated:YES];
    ActionViewController *vc=[[ActionViewController alloc]init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
    
    
}
- (IBAction)thirdBtn:(id)sender {
    KFChatViewController  *kfc = [[KFChatViewController alloc]initWithMetadata:@[@{@"name":@"系统",@"value":@"IOS"}]];
    [self.viewController.navigationController pushViewController:kfc animated:YES];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
