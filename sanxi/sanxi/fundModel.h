//
//  fundModel.h
//  sanxi
//
//  Created by liangang on 2017/6/11.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface fundModel : NSObject
@property(strong,nonatomic)NSString *FundName;
@property(strong,nonatomic)NSNumber *FundId,*BuyAmount,*TotalProfit,*CurrentFundRate,*Id;
@end
