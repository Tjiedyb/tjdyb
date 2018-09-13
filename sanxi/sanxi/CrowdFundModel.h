//
//  CrowdFundApi.h
//  sanxi
//
//  Created by liangang on 2017/6/13.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CrowdFundModel : NSObject
@property(strong,nonatomic)NSString *OrderNo,*CrowedFundName,*strCrowedFundPhoto,*CrowedFundItemName,*Name,*PhoneNumber,*Province,*City,*Disctinct,*AddressInfo,*PaymentType,*ZipCode,*strStatus,*Comments,*PayDate,*CreatedOn,*ExpiredOn;
@property(strong,nonatomic)NSNumber *CrowedFundId,*CrowedFundItemId,*SubTotal,*UnitPrice,*ShippingFee,*DiscountFee,*TotalFee,*Quantity,*Status,*Id;

@end
