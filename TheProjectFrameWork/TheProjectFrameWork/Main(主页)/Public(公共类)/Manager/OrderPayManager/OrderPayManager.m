//
//  OrderPayManager.m
//  TheProjectFrameWork
//
//  Created by maple on 16/10/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "OrderPayManager.h"

@implementation OrderPayManager

/**
 *  <#Description#>
 *
 *  @param orderID <#orderID description#>
 *  @param type    <#type description#>
 *  @param block   <#block description#>
 */
+(void)OrderPayWithOrderID:(NSString *)orderID andPayType:(NSString *)type With:(void (^)(BOOL, NSString *, NSString *, NSString *,NSString * , NSString *))block
{
    NSString * string =@"";
    NSString * isUseRebate = @"";
    if ([type isEqualToString:@"1"])
    {
        string = @"mobile_payfinsh";
    }
    else if ([type isEqualToString:@"10"])
    {
        string = @"mobile_payfinsh";
    }
     else if ([type isEqualToString:@"2"])
    {
        string = @"mobile_payfinsh";
    }
     else if ([type isEqualToString:@"3"])
    {
        
    }
     else if ([type isEqualToString:@"4"])
    {
        
    }
     else if ([type isEqualToString:@"5"])
    {
        
    }
     else if ([type isEqualToString:@"6"])
    {
        isUseRebate = @"1";
        string = @"mobile_payfinsh";

    }
     else if ([type isEqualToString:@"7"])
    {
        isUseRebate = @"1";
        string = @"mobile_payfinsh";

    }
    else if ([type isEqualToString:@"8"])
    {
        isUseRebate = @"1";
    }
    NSString *md5code = [[NSUserDefaults standardUserDefaults]objectForKey:MD5Pay_pwd]?:@"";

    NSDictionary * dic = @{@"payType":type,
                           @"order_id":orderID,
                           @"user_id":[UserAccountManager shareUserAccountManager].loginStatus?kUserId:[UserAccountManager  shareUserAccountManager].cartUserID,
                           @"callBackUrl":string,
                           @"isUseRebate":isUseRebate,
                           @"pay_pwd":md5code
                           };
    [NetWork PostNetWorkWithUrl:@"/orderPay" with:dic successBlock:^(NSDictionary *dic)
     {
         [HUDManager hideHUDView];
         if ([dic[@"status"] boolValue])
         {
             
             NSString * type22 = [NSString stringWithFormat:@"%@",dic[@"data"][@"payType"]];
             NSString * urls = [NSString stringWithFormat:@"%@",dic[@"data"][@"payUrl"]];
             NSString * price = [NSString stringWithFormat:@"%@",dic[@"data"][@"price"]];
             NSString * orderPayFrom = [NSString stringWithFormat:@"%@",dic[@"data"][@"orderPayFrom"]];
             if ([type isEqualToString:@"2"]) {
                 /**微信支付*/
                 NSDictionary *temdic = dic[@"data"];
                 urls = [temdic mj_JSONString];
                 type22 = @"2";
             } block(YES,urls,type,price,orderPayFrom,dic[@"message"]);
         }
         else
         {
             block(NO,@"",@"",@"",@"",dic[@"message"]);
         }
     }
     
    errorBlock:^(NSString *error)
    {
         block(NO,@"",@"",@"",@"",error);

     }];
    
}
/**
 *  积分订单支付
 *
 *  @param orderID orderid
 *  @param type    支付类型
 *  @param block   回调
 */
+(void)IntegralOrderPayWithOrderID:(NSString *)orderID andPayType:(NSString *)type With:(void (^)(BOOL, NSString *, NSString *, NSString *,NSString * , NSString *))block
{
    NSString * string = @"";
    NSString * isUseRebate = @"";
    if ([type isEqualToString:@"1"])
    {
        string = @"mobile_payfinsh";
    }
    else if ([type isEqualToString:@"2"])
    {
        string = @"mobile_payfinsh";
    }
    else if ([type isEqualToString:@"3"])
    {
        
    }
    else if ([type isEqualToString:@"4"])
    {
        
    }
    else if ([type isEqualToString:@"5"])
    {
        
    }
    else if ([type isEqualToString:@"6"])
    {
        isUseRebate = @"1";
        string = @"mobile_payfinsh";
        
    }
    else if ([type isEqualToString:@"7"])
    {
        isUseRebate = @"1";
        string = @"mobile_payfinsh";
        
    }
    else if ([type isEqualToString:@"8"])
    {
        isUseRebate = @"1";
    }
    NSString *md5code = [[NSUserDefaults standardUserDefaults]objectForKey:MD5Pay_pwd]?:@"";
    NSDictionary * dic = @{@"payType":type,
                           @"order_id":orderID,
                           @"user_id":kUserId,
                           @"callBackUrl":@"integralPayfinsh",
                           @"pay_pwd":md5code
                           };
    [NetWork PostNetWorkWithUrl:@"/integrationPay" with:dic successBlock:^(NSDictionary *dic)
     {
         [HUDManager hideHUDView];
         if ([dic[@"status"] boolValue])
         {
             NSString * type22 = [NSString stringWithFormat:@"%@",dic[@"data"][@"payType"]];
             NSString * urls = [NSString stringWithFormat:@"%@",dic[@"data"][@"payUrl"]];
             NSString * price = [NSString stringWithFormat:@"%@",dic[@"data"][@"price"]];
             NSString * orderPayFrom = [NSString stringWithFormat:@"%@",dic[@"data"][@"orderPayFrom"]];
             if ([type isEqualToString:@"2"]) {
                 /**微信支付*/
                 NSDictionary *temdic = dic[@"data"];
                 urls = [temdic mj_JSONString];
                 type22 = @"2";
             } block(YES,urls,type,price,orderPayFrom,dic[@"message"]);
         }
         else
         {
             block(NO,@"",@"",@"",@"",dic[@"message"]);
         }
     }
     
                     errorBlock:^(NSString *error)
     {
         block(NO,@"",@"",@"",@"",error);
         
     }];
    
}

+(void)CHeckPayPassWord:(void(^)(BOOL success ,NSString *payType, NSString* error))block{
    NSDictionary * dic = @{@"user_id":kUserId};
    [NetWork PostNetWorkWithUrl:@"/buyer/checkPayPassword" with:dic successBlock:^(NSDictionary *dic)
     {
         [HUDManager hideHUDView];
         if ([dic[@"status"] boolValue])
         {
             NSString * string = [NSString stringWithFormat:@"%@",dic[@"data"]];
             if ([string isEqualToString:@"0"])
             {
                 block(NO,string,@"NOPayPassWord");
             }
             else if ([string isEqualToString:@"1"])
             {
                 block(YES,string,@"");
             }
             else
             {
                 block(NO,string,@"");
             }
         }
         else
         {
             block(NO,@"",dic[@"message"]);
         }
     } errorBlock:^(NSString *error)
     {
         block(NO,@"",error);
     }];
 
}



@end
