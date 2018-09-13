//
//  homeFirstTableViewCell.h
//  sanxi
//
//  Created by liangang on 17/5/9.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "CircleProgressBar.h"
@interface homeFirstTableViewCell : UITableViewCell<SDCycleScrollViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    NSDictionary *productsDic;
    NSMutableArray *bannerSourceArray;
    
}
@property (weak, nonatomic) IBOutlet CircleProgressBar *firstCircle;
@property (weak, nonatomic) IBOutlet UILabel *firstProgressLabel;
@property (weak, nonatomic) IBOutlet CircleProgressBar *secondCircle;
@property (weak, nonatomic) IBOutlet UILabel *secondProgressLabel;
@property (weak, nonatomic) IBOutlet CircleProgressBar *thirdCircle;
@property (weak, nonatomic) IBOutlet UILabel *thirdProgressLabel;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *bannerView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
