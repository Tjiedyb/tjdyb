//
//  fundViewController.m
//  sanxi
//
//  Created by liangang on 17/5/9.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "fundViewController.h"
#import <WebKit/WebKit.h>
#import <AlipaySDK/AlipaySDK.h>
@interface fundViewController ()<WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate>

{
    WKWebView *webView;
}
@end

@implementation fundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"基金";
    webView = [WKWebView new];
    [self.view addSubview:webView];
//    [self.view addSubview:self.progressView];
    [webView  mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset
        make.left.bottom.top.right.equalTo(self.view);
    }];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    webView.UIDelegate   = self;
    webView.navigationDelegate= self;
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences.minimumFontSize = 18;
   WKUserContentController *userCC = config.userContentController;
    [userCC addScriptMessageHandler:self name:@"PayOrder"];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://mobile.htjh.group/Fund/List?token=%@",[GlobService sharedInstance].model.access_token]]]];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES ];
    self.tabBarController.tabBar.hidden = YES;
    [GlobService sharedInstance].tabBarView .hidden = YES;
//    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
//    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        if (object == webView) {
            NSLog(@"%.2f",webView.estimatedProgress);
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:webView.estimatedProgress];
            
            //            [self.progressView setAlpha:1.0f];
            //            [self.progressView setProgress:self.currentSubView.webView.estimatedProgress animated:YES];
            //
            if(webView.estimatedProgress >= 1.0f) {
                
                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self.progressView setAlpha:0.0f];
                } completion:^(BOOL finished) {
                    [self.progressView setProgress:0.0f animated:NO];
                }];
                //
            }
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
        
    }
    else if ([keyPath isEqualToString:@"title"])
    {
        if (object == webView) {
            self.title = webView.title;
            
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            
        }
    }
    else {
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [webView removeObserver:self forKeyPath:@"estimatedProgress"];
//    [webView removeObserver:self forKeyPath:@"title"];

}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    NSLog(@"%@",message.body);
    NSDictionary *dic = message.body;
    switch ([dic[@"method"]integerValue ]) {
        case 1:
        {
            [[AlipaySDK defaultService] payOrder:dic[@"orderStr"] fromScheme:@"sanxi" callback:^(NSDictionary *resultDic) {
                NSLog(@"%@",resultDic);
            }];
        }
            break;
            
        default:
            break;
    }
}
- (void)webView:(WKWebView *)_webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{//mobile.htjh.group/
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL resourceSpecifier];
    NSLog(@"%@",scheme);
    if ([scheme containsString:@"Home"]||[scheme isEqualToString:@"//mobile.htjh.group/"]) {
        [[GlobService sharedInstance].tabBar setSelectedIndex:0];
    }
    if ([scheme containsString:@"User"]) {
       [[GlobService sharedInstance].tabBar setSelectedIndex:5];
    }
    if ([scheme containsString:@"kf5"]) {
        KFChatViewController  *kfc = [[KFChatViewController alloc]initWithMetadata:@[@{@"name":@"系统",@"value":@"IOS"}]];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:kfc];
        [self  presentViewController:nav animated:YES completion:nil];
        [[GlobService sharedInstance].tabBarView setHidden:YES];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
        
    }

    decisionHandler(WKNavigationActionPolicyAllow);
}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
