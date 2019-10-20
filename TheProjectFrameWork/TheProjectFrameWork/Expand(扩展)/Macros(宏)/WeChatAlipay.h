//
//  WeChatAlipay.h
//  TheProjectFrameWork
//
//  Created by maple on 2017/1/11.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#ifndef WeChatAlipay_h
#define WeChatAlipay_h
#import "WXApiManager.h"
#import <AlipaySDK/AlipaySDK.h>


#pragma mark -- WeChat

//微信key
#define WeChatKey @""

//微信
#define WeChat @""


#pragma mark -- Alipay
//合作身份者id，以2088开头的16位纯数字
#define PartnerID      @""
//收款支付宝账号
#define SellerID       @""
//商户私钥，自助生成
#define PartnerPrivKey @""
//支付宝公钥
#define AlipayPubKey   @""
//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY        @""

#endif /* WeChatAlipay_h */
