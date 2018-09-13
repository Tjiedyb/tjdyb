//
//  GlobWebService.m
//  sanxi
//
//  Created by liangang on 17/5/10.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "GlobWebService.h"

@implementation GlobWebService

@end
@implementation homepagenewsApi

-(NSString *)requestUrl
{
    return [NSString stringWithFormat:@"api/news/homepagenews/%d",self.n];
}
-(NSInteger)cacheTimeInSeconds
{
    return 60*60;
}
@end
@implementation headlinestodayApi

-(NSString *)requestUrl
{
    return @"api/news/headlinestoday/all";
}
-(id)requestArgument
{
    return @{@"page":@(self.page),@"pageSize":@(10)};
}

@end


@implementation financialtransactionsApi

-(NSString *)requestUrl
{
     return @"api/news/financialtransactions/all";
}
-(id)requestArgument
{
    return @{@"page":@(self.page),@"pageSize":@(10)};
}
@end



@implementation newsdetailApi

-(NSString *)requestUrl
{
    return [NSString stringWithFormat:@"api/news/newsdetail/%d",self.newsId];
}

@end


@implementation identitytypesApi

-(NSString *)requestUrl
{
    return @"api/customer/identitytypes/all";
}

@end



@implementation getvalidationcodeApi

-(NSString *)requestUrl
{
    return [NSString stringWithFormat:@"api/customer/getvalidationcode/%@",self.phone];
}

@end
@implementation registerNormalApi

-(NSString *)requestUrl
{
    return @"api/customer/register/normal";
}
-(YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}
-(id)requestArgument

{
    return self.dic;
}
@end


@implementation registerVipApi

-(NSString *)requestUrl
{
    return @"api/customer/register/data";
}
-(id)requestArgument

{
    return self.dic;
}
-(YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}
@end



@implementation bannerApi

-(NSString *)requestUrl
{
    return [NSString stringWithFormat:@"api/news/banners/%@",self.type];
}

@end

@implementation loginApi

-(NSURLRequest *)buildCustomUrlRequest
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://mobile.htjh.group/Token"]];
   // [request addValue:[GlobalService sharedInstance].token forHTTPHeaderField:@"token"];
    //[request addValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
//    NSError *error;
//    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:@{@"username":self.userName,@"grant_type":@"password",@"password":self.passWord} options:NSJSONWritingPrettyPrinted error:&error];
    [request setHTTPBody:[[[NSString stringWithFormat:@"password=%@&username=%@&grant_type=password",self.passWord,self.userName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]dataUsingEncoding:NSUTF8StringEncoding]];
    return  request;

}

@end


@implementation tokenApi

-(NSDictionary *)requestHeaderFieldValueDictionary
{
    return @{@"Authorization":[NSString stringWithFormat:@"%@ %@",[GlobService sharedInstance].model.token_type,[GlobService sharedInstance].model.access_token]};
}

@end
@implementation customeramountApi

-(NSString *)requestUrl
{
    return @"api/customer/customeramount/fund";
}

@end

@implementation resetpasswordApi

//-(NSString *)requestUrl
//{
//    return @"api/customer/resetpassword/data";
//}
-(NSURLRequest *)buildCustomUrlRequest
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://www.htjh.group/api/customer/resetpassword/data"]];
    // [request addValue:[GlobalService sharedInstance].token forHTTPHeaderField:@"token"];
    //[request addValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    //    NSError *error;
    //    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:@{@"username":self.userName,@"grant_type":@"password",@"password":self.passWord} options:NSJSONWritingPrettyPrinted error:&error];
    [request setHTTPBody:[[[NSString stringWithFormat:@"oldPassword=%@&newPassword=%@&confirmPassword=%@",self.oldPassword,self.a,self.confirmPassword] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]dataUsingEncoding:NSUTF8StringEncoding]];
    return  request;
    
}

//-(id)requestArgument
//{
//    return @{@"oldPassword":self.oldPassword,@"newPassword":self.a,@"confirmPassword":self.confirmPassword};
//}
//-(YTKRequestMethod)requestMethod
//{
//    return YTKRequestMethodPost ;
//}
@end


@implementation userDataApi

-(NSString *)requestUrl
{
    return @"api/customer/user/data";
}

@end


@implementation favouriteitemsApi

-(NSString *)requestUrl
{
    return @"api/customer/crowdfund/favouriteitems";
}
    
-(id)requestArgument
{
    return @{@"page":@(self.page),@"pageSize":@(self.pageSize)};
}
@end

@implementation uploaderPicApi

-(NSString *)requestUrl
{
    return @"api/uploader/picture";
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
       
        [formData appendPartWithFileData:UIImagePNGRepresentation(self.image) name:@"file_data" fileName:@"file_data" mimeType:@"image/jpeg" ];
        
    };
}
-(YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}
@end


@implementation certificationApi

-(NSString *)requestUrl
{
    return @"api/customer/certification/save";
}
-(id)requestArgument
{
    return @{@"PositiveId":@(self.PositiveId),@"OppsiteId":@(self.OppsiteId),@"HandleCardId":@(self.HandleCardId),@"Type":@(self.Type)};
}
    
-(YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}
@end
@implementation certificationInfoApi

-(NSString *)requestUrl
{
    return @"api/customer/certification/info";
}

@end


@implementation locationApi

-(NSString *)requestUrl
{
    return @"api/customer/location/point";
}
-(id)requestArgument
{
    return @{@"longitude":self.longitude ,@"latitude":self.latitude};
}

@end


@implementation discountAllApi

-(NSString *)requestUrl
{
    return @"api/common/discount/all";
}

@end


@implementation activediscountApi

-(NSString *)requestUrl
{
    return [NSString stringWithFormat:@"api/common/activediscount/%@",self.activeCode];
}
//-(id)requestArgument
//{
//    return @{@"activeCode":self.activeCode};
//}


@end
@implementation myFundOrdersApi

-(NSString *)requestUrl
{
    return @"api/fund/customerfund/all";
}

@end


@implementation fundListApi

-(NSString *)requestUrl
{
    return @"api/fund/customerfund/orders";
}

@end


@implementation myCrowdFundApi

-(NSString *)requestUrl
{
    return [NSString stringWithFormat:@"api/crowedfund/customerorders/%ld",(long)self.orderStatus];
}
-(id)requestArgument
{
    return @{@"page":@(self.page),@"pageSize":@(self.pageSize)};
}

@end


@implementation cancelCrowdFundApi

-(NSString *)requestUrl
{
    return [NSString stringWithFormat:@"api/crowedfund/cancelorder/%ld",(long)self.Id];
}

@end


@implementation removeFavApi

-(NSString *)requestUrl
{
    return [NSString stringWithFormat:@"api/customer/favourite/remove/%d",self.Id];
}

@end



@implementation forgetPassWordApi

-(NSURLRequest *)buildCustomUrlRequest
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://mobile.htjh.group/api/customer/forgotpassword"]];
    // [request addValue:[GlobalService sharedInstance].token forHTTPHeaderField:@"token"];
    //[request addValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    //    NSError *error;
    //    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:@{@"username":self.userName,@"grant_type":@"password",@"password":self.passWord} options:NSJSONWritingPrettyPrinted error:&error];
    [request setHTTPBody:[[[NSString stringWithFormat:@"Code=%@&PhoneNumber=%@&Password=%@&RePassword=%@",self.Code,self.PhoneNumber,self.Password,self.RePassword  ] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]dataUsingEncoding:NSUTF8StringEncoding]];
    return  request;
    
}



@end

@implementation productsApi

-(NSString *)requestUrl
{
    return @"api/common/homepage/products";
}

@end
