//
//  favoriteModel.h
//  sanxi
//
//  Created by liangang on 2017/6/11.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface favoriteModel : NSObject
@property(strong,nonatomic)NSString *EntityName,*CreatedOn,*CustomProperties;
@property(strong,nonatomic)NSNumber *EntityId,*Type,*Id;
@end
