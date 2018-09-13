//
//  newsListViewController.h
//  sanxi
//
//  Created by liangang on 17/5/11.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  enum
{
    headlinestoday,
    financialtransactions
}NewsType;
@interface newsListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(assign)NewsType type;
@end
