//
//  myFavTableViewCell.h
//  sanxi
//
//  Created by liangang on 2017/6/15.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "favoriteModel.h"
@interface myFavTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong,nonatomic) favoriteModel   *model;
@end
