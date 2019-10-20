//
//  UrlMacros.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#ifndef UrlMacros_h
#define UrlMacros_h



//测试服务器
//#define KAppRootUrl   @"http://test.lightkitch.com/mobile"
#define KAppRootUrl   @"http://demo.lightkitch.com/mobile"
//#define KAppRootUrl   @"http://taian.lightkitch.com/mobile"

//测试服务器
//#define KAppRootUrl   @"http://192.168.1.151/mobile"
//预演示服务器
//#define KAppRootUrl   @"http://47.92.29.172/mobile"
//吃货正式服务器
//#define KAppRootUrl   @"http://www.xinhuawangyilian.com/mobile"
#define PushKey       @"46514ab1-d7dd-45ce-b0d8-f364a8f13ce6"

#define kIsB2cStr    @"isb2cstr"




/**预编译宏   DevelopMent=0 是电商demo  DevelopMent=1 是吃货APP*/

#if DevelopMent==0

/**是否是吃货头条 (YES : 是 NO : 不是) */
#define kIsChiHuoApp NO
/**是否有优惠券 (YES : 有 NO : 没有) */
#define kIsHaveCoupon   YES
/**是否有投诉 (YES : 有 NO : 没有) */
#define kIsHaveComplaint   YES
/**是否首页是聚合页 (YES : 是 NO : 不是) */
#define kIsHomeJuHe   NO

#else


/**是否是吃货头条 (YES : 是 NO : 不是) */
#define kIsChiHuoApp YES
/**是否有优惠券 (YES : 有 NO : 没有) */
#define kIsHaveCoupon   NO
/**是否有投诉 (YES : 有 NO : 没有) */
#define kIsHaveComplaint   NO
/**是否首页是聚合页 (YES : 是 NO : 不是) */
#define kIsHomeJuHe   NO

#endif



#define MD5Pay_pwd @"MD5Pay_pwd"

/**
 *  控制语言切换按钮 (YES : 限制 NO : 不限制)
 */
#define kHideLanguageController YES

#define kUserId [[NSNumber numberWithInteger:[UserAccountManager shareUserAccountManager].userModel.userId] stringValue]
#define kStoreId [[NSNumber numberWithInteger:[UserAccountManager shareUserAccountManager].shopModel.store_id ] stringValue]

#endif /* UrlMacros_h */
