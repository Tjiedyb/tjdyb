//
//  GlobWebService.h
//  sanxi
//
//  Created by liangang on 17/5/10.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "YTKRequest.h"

@interface GlobWebService : YTKRequest

@end
@interface homepagenewsApi : YTKRequest
@property(assign) NSInteger n;
@end

/**
 今日头条新闻
 */
@interface headlinestodayApi : YTKRequest
@property(assign)NSInteger page, pageSize;
@end

/**
 理财指点所有
 */
@interface financialtransactionsApi : YTKRequest
@property(assign)NSInteger page,pageSize;
@end


/**
 新闻详情
 */
@interface newsdetailApi : YTKRequest
@property(assign)NSInteger newsId;
@end


/**
 证件类型
 */
@interface identitytypesApi : YTKRequest

@end


/**
 手机验证码
 */
@interface getvalidationcodeApi : YTKRequest
@property(strong,nonatomic)NSString *phone;
@end


/**
 普通注册
 */
@interface registerNormalApi : YTKRequest
@property(strong,nonatomic)NSString *PhoneNumber,*Name,*AssociateStaffNo,*IsCompany,*CompanyName,*VerificationCode,*Password,*RePassword;
@property(strong,nonatomic)NSDictionary *dic;
@end


/**
 基金会员注册
 */
@interface registerVipApi : YTKRequest
@property(strong,nonatomic)NSString *Name,*PhoneNumber,*Password,*RePassword,*IdentityType,*IdentityNumber
,*IsCompany,*CompnayName,*VerificationCod,*AssociateStaffNo;
@property(strong,nonatomic)NSDictionary *dic;

@end

/**
 Banner
 */
@interface bannerApi : YTKRequest
@property(strong,nonatomic)NSString *type;

@end
/**
 登录
 */

@interface loginApi : YTKRequest
@property(strong,nonatomic)NSString *userName, *passWord;
@end

@interface tokenApi : YTKRequest

@end

/**
 个人资产与收益
 */
@interface customeramountApi : tokenApi

@end

/**
 重置密码
 */
@interface resetpasswordApi : tokenApi
@property(strong,nonatomic)NSString *oldPassword,*a,*confirmPassword;
@end


/**
 用户信息
 */

@interface userDataApi : tokenApi

@end

/**
我的收藏（众筹）
 */
@interface favouriteitemsApi : tokenApi
@property(assign)NSInteger page,pageSize;
@end


/**
传图
 */

@interface uploaderPicApi : tokenApi
@property(strong,nonatomic)UIImage *image;

@end


/**
 上传证件信息
 */
@interface certificationApi : tokenApi
@property(assign)NSInteger PositiveId,OppsiteId,HandleCardId,Type;

@end

@interface certificationInfoApi : tokenApi

@end


@interface locationApi : tokenApi
@property(strong,nonatomic) NSString *latitude,*longitude;

@end

@interface discountAllApi : tokenApi

@end

@interface activediscountApi : tokenApi
@property(strong,nonatomic)NSString *activeCode;
@end

/**
 我的基金
 */
@interface myFundOrdersApi : tokenApi

@end

/**
 历史基金
 */
@interface fundListApi : tokenApi

@end
@interface myCrowdFundApi : tokenApi
@property(assign)NSInteger page ,pageSize,orderStatus;
@end




@interface cancelCrowdFundApi : tokenApi
@property(assign)NSInteger Id;

@end


@interface removeFavApi :tokenApi
@property(assign)NSInteger Id;

@end


@interface  forgetPassWordApi : tokenApi
@property (strong,nonatomic)NSString *Code,*PhoneNumber,*Password,*RePassword;

@end



@interface productsApi: YTKRequest  

@end

