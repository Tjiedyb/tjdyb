//
//  upLoadIDCardViewController.h
//  sanxi
//
//  Created by liangang on 2017/6/6.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBCameraViewController.h"
#import "DBCameraContainerViewController.h"
#import "DBCameraLibraryViewController.h"
@interface upLoadIDCardViewController : UIViewController<DBCameraViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *frontImageView;
@property (weak, nonatomic) IBOutlet UIView *frontBg;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIView *backBg;
@property (weak, nonatomic) IBOutlet UIImageView *menWithIDImageView;
@property (weak, nonatomic) IBOutlet UIView *menWithIDBg;
@property (weak, nonatomic) IBOutlet UIImageView *longTermImageView;
@property (weak, nonatomic) IBOutlet UIImageView *unLongTermImageView;
@property (strong,nonatomic)NSDictionary *dic;
@end
