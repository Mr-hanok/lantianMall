//
//  PayHandle.m
//  TheProjectFrameWork
//
//  Created by maple on 2017/1/5.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#import "PayHandle.h"
#import "WXApi.h"
#import "WXApiObject.h"

// 开放平台登录https://open.weixin.qq.com的开发者中心获取APPID
#define WX_APPID @"wxd21d89033***b4ca"
// 开放平台登录https://open.weixin.qq.com的开发者中心获取AppSecret。
#define WX_APPSecret @"fc32dfae99bc67e****5f77dddd4ea5"
// 微信支付商户号
#define MCH_ID  @"1353***702"
// 安全校验码（MD5）密钥，商户平台登录账户和密码登录http://pay.weixin.qq.com
// 平台设置的“API密钥”，为了安全，请设置为以数字和字母组成的32字符串。
#define WX_PartnerKey @"B6246A6D8***C730EEA0F78D3B461"

@implementation PayHandle
+(void)PayWith:(PayTypes)type
{

    PayReq *request = [[PayReq alloc] init];
    request.partnerId = @"10000100";
    request.prepayId= @"1101000000140415649af9fc314aa427";
    request.package = @"Sign=WXPay";
    request.nonceStr= @"a462b76e7436e98e0ed6e13c64b4fd1c";
    request.timeStamp= @"1397527777";
    request.sign= @"582282D72DD2B03AD892830965F428CB16E7A256";
    [WXApi sendReq:request];
//    if (type==PayTypeWeChat)
//    {
//                //============================================================
//            // V3&V4支付流程实现
//            // 注意:参数配置请查看服务器端Demo
//            // 更新时间：2015年11月20日
//            //============================================================
//            NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
//            //解析服务端返回json数据
//            NSError *error;
//            //加载一个NSURL对象
//            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//            //将请求的url数据放到NSData对象中
//            NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//            if ( response != nil) {
//                NSMutableDictionary *dict = NULL;
//                //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
//                dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//                
//                NSLog(@"url:%@",urlString);
//                if(dict != nil){
//                    NSMutableString *retcode = [dict objectForKey:@"retcode"];
//                    if (retcode.intValue == 0){
//                        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
//                        
//                        //调起微信支付
//                        PayReq* req             = [[PayReq alloc] init];
//                        req.partnerId           = [dict objectForKey:@"partnerid"];
//                        req.prepayId            = [dict objectForKey:@"prepayid"];
//                        req.nonceStr            = [dict objectForKey:@"noncestr"];
//                        req.timeStamp           = stamp.intValue;
//                        req.package             = [dict objectForKey:@"package"];
//                        req.sign                = [dict objectForKey:@"sign"];
//                        [WXApi sendReq:req];
//                        //日志输出
//                        NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
//                    }else{
//                        NSLog(@"%@",[dict objectForKey:@"retmsg"]);
//                    }
//                }else{
//                    NSLog(@"服务器返回错误，未获取到json对象");
//                }
//            }else{
//                NSLog(@"服务器返回错误");
//            }
//    }
//    else
//    {
//        
//    }
    
}

@end
