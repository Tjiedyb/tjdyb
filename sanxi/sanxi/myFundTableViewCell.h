//
//  myFundTableViewCell.h
//  sanxi
//
//  Created by liangang on 2017/6/11.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myFundTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *TotalProfitLabel;
@property (weak, nonatomic) IBOutlet UILabel *BuyAmountLabel;

@end
