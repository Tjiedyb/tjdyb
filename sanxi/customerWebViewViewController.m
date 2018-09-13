//
//  customerWebViewViewController.m
//  shayu
//
//  Created by liangang on 2017/9/12.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "customerWebViewViewController.h"
#import<WebKit/WebKit.h>
#import "Masonry.h"
@interface customerWebViewViewController ()<WKNavigationDelegate,WKUIDelegate>
{
    WKWebView * webView;
}
@end

@implementation customerWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  webView = [WKWebView new];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(webView.superview  );
    }];
//    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"URL"];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:dic[@"url"]]]];
//    [self.view addSubview:webView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self.view addSubview:self.progressView];
//    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    // Do any additional setup after loading the view from its nib.
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
//    else if ([keyPath isEqualToString:@"title"])
//    {
//        if (object == self.webView) {
//            self.title = self.webView.title;
//            
//        }
//        else
//        {
//            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//            
//        }
//    }
//    else {
//        
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [webView removeObserver:self forKeyPath:@"estimatedProgress"];
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
