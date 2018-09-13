//
//  myCrowdFundCellTableViewCell.m
//  sanxi
//
//  Created by liangang on 2017/6/13.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "myCrowdFundCellTableViewCell.h"
#import "KFChatViewController.h"
@implementation myCrowdFundCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contactSellerBtn.layer.borderColor = RED.CGColor;
    self.contactSellerBtn.layer.borderWidth = 1;
    self.contactSellerBtn.layer.cornerRadius = 5;
    [self.contactSellerBtn setTitleColor:RED forState:UIControlStateNormal];
    
    self.cancelOrderBtn.layer.borderColor = RED.CGColor;
    self.cancelOrderBtn.layer.borderWidth = 1;
    self.cancelOrderBtn.layer.cornerRadius = 5;
    [self.cancelOrderBtn setTitleColor:RED forState:UIControlStateNormal];
    
    
    self.parOrderBtn.layer.borderColor = RED.CGColor;
    self.parOrderBtn.layer.borderWidth = 1;
    self.parOrderBtn.layer.cornerRadius = 5;
    [self.parOrderBtn setTitleColor:RED forState:UIControlStateNormal];
    self.stateLabelLabel.textColor = RED;
    // Initialization code
}
- (IBAction)kfBtnClick:(id)sender {
    self.viewController.hidesBottomBarWhenPushed = YES;
    [[GlobService sharedInstance].tabBarView setHidden:YES];
    //    [self.navigationController pushViewController:vc animated:YES];
    //    self.hidesBottomBarWhenPushed= NO;
    [self.viewController.navigationController pushViewController:[[KFChatViewController alloc]
                                                                  initWithMetadata:@[@{@"name":@"系统",@"value":@"IOS"}]] animated:YES];
    self.viewController.hidesBottomBarWhenPushed = NO;
    

}
- (IBAction)cancelBtnClick:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"消息" message:@"是否取消订单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%d",buttonIndex);
    if (buttonIndex==1) {
        cancelCrowdFundApi *api = [[cancelCrowdFundApi alloc]init];
        api.Id = [self.model.Id integerValue  ];
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            NSLog(@"%@",request.responseString);
        } failure:^(__kindof YTKBaseRequest *request) {
            NSLog(@"%@",request.responseString);

        }];
        
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
