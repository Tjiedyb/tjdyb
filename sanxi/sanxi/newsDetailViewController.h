//
//  newsDetailViewController.h
//  sanxi
//
//  Created by liangang on 17/5/15.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newsDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
//@property(assign)NSInteger newsID;
@property(strong,nonatomic) NSDictionary *dic;
@end
