//
//  myFavTableViewCell.m
//  sanxi
//
//  Created by liangang on 2017/6/15.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "myFavTableViewCell.h"

@implementation myFavTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.deleteBtn.layer.borderColor = RED.CGColor;
    self.deleteBtn.layer.cornerRadius = 5;
    self.deleteBtn.layer.borderWidth =1;
    [self.deleteBtn setTitleColor:RED forState:UIControlStateNormal];
    self.detailBtn.layer.borderColor = RED.CGColor;
    self.detailBtn.layer.cornerRadius = 5;
    self.detailBtn.layer.borderWidth =1;
    [self.detailBtn setTitleColor:RED forState:UIControlStateNormal];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
