//
//  securityCertificationViewController.m
//  sanxi
//
//  Created by liangang on 2017/6/1.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "securityCertificationViewController.h"
#import "upLoadIDCardViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "CCLocationManager.h"
@interface securityCertificationViewController ()<CLLocationManagerDelegate>
{
    NSDictionary *certificationData;
    CLLocationManager *locationmanager;
}
@end

@implementation securityCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgView.backgroundColor = RED;
    
    self.certificationImageView.tintColor =RED;
    self.title = @"安全认证";
    // Do any additional setup after loading the view from its nib.
    
}
-(void)loadCertificationData
{
    certificationInfoApi *api = [[certificationInfoApi alloc]init];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSLog(@"%@",request.responseString);
        NSInteger count=0;
        if ([request.responseJSONObject[@"PositiveId"] integerValue]) {
            [self.certificationImageView setImage:[UIImage imageNamed:@"IDCard_s"]];
            certificationData = request.responseJSONObject;
            count++;
            
        }
        if (!request.responseJSONObject[@"Latitude"] ||[request.responseJSONObject[@"Latitude"] isEqual:[NSNull null]]) {
            [UIApplication sharedApplication].idleTimerDisabled = TRUE;
            locationmanager = [[CLLocationManager alloc] init];
            [locationmanager requestAlwaysAuthorization];        //NSLocationAlwaysUsageDescription
            [locationmanager requestWhenInUseAuthorization];     //NSLocationWhenInUseDescription
            locationmanager.delegate = self;
            [self getLat];
        }
        else
        {
            count++;
            [self.locationImageView setImage:[UIImage imageNamed:@"location"]];
            self.locationLabel.text = @"已获取";
        }
        self.countLabel.text = [NSString stringWithFormat:@"%d",count];
    } failure:^(__kindof YTKBaseRequest *request) {
          NSLog(@"%@",request.responseString);
    }];
}
-(void)getLat
{
//    __block __weak securityCertificationViewController *wself = self;
    
    
        [[CCLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
            
            NSLog(@"%f %f",locationCorrrdinate.latitude,locationCorrrdinate.longitude);
            locationApi *api = [[locationApi alloc]init];
            api.latitude     = [NSString stringWithFormat:@"%f",locationCorrrdinate.latitude];
            api.longitude = [NSString stringWithFormat:@"%f",locationCorrrdinate.longitude];
            [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
                NSLog(@"%@",request.responseString);
            } failure:^(__kindof YTKBaseRequest *request) {
                NSLog(@"%@",request.responseString);

            }];
//            [wself setLabelText:[NSString stringWithFormat:@"%f %f",locationCorrrdinate.latitude,locationCorrrdinate.longitude]];
            
        }];
   
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[GlobService sharedInstance].tabBarView setHidden:YES];
    [self loadCertificationData];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)upLoadIdBtnClick:(id)sender {
    upLoadIDCardViewController *vc = [[upLoadIDCardViewController alloc]init];
    vc.dic = certificationData  ;
    self.hidesBottomBarWhenPushed= YES;
    [[GlobService sharedInstance].tabBarView setHidden:YES];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed= NO;}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
