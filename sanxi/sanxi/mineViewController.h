//
//  mineViewController.h
//  sanxi
//
//  Created by liangang on 17/5/17.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mineViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *CurrentProfitLabel;
@property (weak, nonatomic) IBOutlet UILabel *TotalProfitLabel;
@property (weak, nonatomic) IBOutlet UILabel *TotalAmountLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *temoBgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
