//
//  newsDetailViewController.m
//  sanxi
//
//  Created by liangang on 17/5/15.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "newsDetailViewController.h"

@interface newsDetailViewController ()

@end

@implementation newsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.dic[@"Title"];
    self.titleLable.text = self.dic[@"ShortDesc"];
    self.timeLabel.text = self.dic[@"PublishedOn"];
    if (![self.dic [@"Description"] isEqual:[NSNull null]]) {
         [self.webView loadHTMLString:self.dic[@"Description"] baseURL:nil];
    }
   
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
