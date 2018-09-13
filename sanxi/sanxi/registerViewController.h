//
//  registerViewController.h
//  sanxi
//
//  Created by liangang on 17/5/16.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTCheckbox.h"
@interface registerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UITextField *rePassWordTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *workerCode;
@property (weak, nonatomic) IBOutlet UITextField *IDType;
@property (weak, nonatomic) IBOutlet UITextField *IDNumber;
@property (weak, nonatomic) IBOutlet CTCheckbox *checkBox;

@end
