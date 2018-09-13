//
//  redBagTableViewCell.h
//  sanxi
//
//  Created by liangang on 2017/6/10.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface redBagTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
