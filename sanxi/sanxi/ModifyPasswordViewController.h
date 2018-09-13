//
//  ModifyPasswordViewController.h
//  sanxi
//
//  Created by liangang on 2017/6/15.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyPasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *NewPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confimPasswordTextFiled;

@end
