//
//  myCrowdFundCellTableViewCell.h
//  sanxi
//
//  Created by liangang on 2017/6/13.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrowdFundModel.h"
@interface myCrowdFundCellTableViewCell : UITableViewCell<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *orderCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabelLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *contactSellerBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelOrderBtn;
@property (weak, nonatomic) IBOutlet UIButton *parOrderBtn;
@property(strong,nonatomic  ) CrowdFundModel *model;
@end
