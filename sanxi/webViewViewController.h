//
//  webViewViewController.h
//  sanxi
//
//  Created by liangang on 2017/6/11.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface webViewViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(strong,nonatomic)NSString *url;
@end
