//
//  AppDelegate.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//测试

#import "AllOrdersViewController.h"
#import "AppDelegate.h"
#import "AppDelegate+PrivateMethods.h"
#import "IQKeyboardManager.h"
#import "MessageCenterViewController.h"
#import "AppAsiaShare.h"
#import "GoodsDetialViewController.h"
#import "ShufflingManager.h"
#import "WXApi.h"
#import "ShareMacros.h"
#import <GTSDK/GeTuiSdk.h>     // GetuiSdk头文件应用
// iOS10 及以上需导入 UserNotifications.framework
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif


/// 个推开发者网站中申请App时，注册的AppId、AppKey、AppSecret
#define kGtAppId           @"wg1uoS5Cyn6h75UgHQUel8"
#define kGtAppKey          @"uTZYSWIkdg8nwKwv0AW5x"
#define kGtAppSecret       @"WUcm67S1Cw7zyzOZWfb2A2"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[UIButton appearance]setExclusiveTouch:YES];
    application.statusBarStyle =UIStatusBarStyleLightContent;
    [LaguageControl shareControl];
    IQKeyboardManager * manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.enableAutoToolbar = YES;
    manager.shouldToolbarUsesTextFieldTintColor = NO;
    [IQKeyboardManager sharedManager].toolbarTintColor = kNavigationColor;

    manager.toolbarManageBehaviour =IQAutoToolbarByTag;

    
    [self ProjectSetRootViewController];
    
    //向微信注册
    [WXApi registerApp:ShareWeChatAppKey withDescription:@"蓝天MALL"];
    
//    // 通过个推平台分配的appId、 appKey 、appSecret 启动SDK，注：该方法需要在主线程中调用
//    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
//    // 注册 APNs
//    [self registerRemoteNotification];

    
    [self GetLogoImageView:^(BOOL success)
     {
         
    }];
    
//    [self NetWorkAdver:^(BOOL isSuccess) {
//
//    }];
//    [self getMianDataFromServer];
    
    /**
     *   用的时候再打开吧
     */
    //    [self oneSignalLaunchOptions:launchOptions];
    //    [AppAsiaShare registerAppAsiaShare];

//    [self.oneSignal IdsAvailable:^(NSString *userId, NSString *pushToken) {
//        [UserAccountManager shareUserAccountManager].pushUserID = userId;
//    }];
//    [self.oneSignal sendTags:@{@"name":@"houxingling"}];
//    [self getCartSessionID];
    
//    [NSThread sleepForTimeInterval:3];//设置启动页面
//    [NSThread mainThread];
    

    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}

-(void)getCartSessionID
{
    [NetWork PostNetWorkWithUrl:@"/get_cart_session" with:nil successBlock:^(NSDictionary *dic)
     {
         if ([dic[@"status"] boolValue])
         {
             [UserAccountManager shareUserAccountManager].cartUserID =[NSString stringWithFormat:@"%@",dic[@"data"][@"user_id"]];
             [UserAccountManager shareUserAccountManager].servicePhone = dic[@"data"][@"servicePhone"];
         }
     } errorBlock:^(NSString *error)
    {
        [self getCartSessionID];
     }];
}
- (void)oneSignalLaunchOptions:(NSDictionary *)launchOptions
{
    
//
//
//    self.oneSignal = [[OneSignal alloc] initWithLaunchOptions:launchOptions
//                                                        appId:PushKey
//                                           handleNotification:^(NSString* message, NSDictionary* additionalData, BOOL isActive)
//                      {
//                          //        1、商品详情 2、店铺 、3积分商城，4、活动， 5、网页、
//
//                          if (isActive) {
//
//                          }
//                          else
//                          {
//
//    NSString * sting = [NSString stringWithFormat:@"%@",additionalData[@"type"]];
//    // 1、商品详情 2、店铺 、3积分商城，4、活动， 5、网页 6、订单
//    if(additionalData.count == 0)
//    {
//        return;
//    }
//    NSString * value =  [NSString stringWithFormat:@"%@",additionalData[@"value"]];
//     UITabBarController * tabar = (UITabBarController *)self.window.rootViewController;
////     tabar.tabBar.hidden = YES;
//    [[tabar.viewControllers firstObject] pushViewController:[ShufflingManager ShufflingManagerPushType:sting withValue:value] animated:YES];
//
//    }
//    }];
    
    
}
-(void)GetLogoImageView:(void(^)(BOOL success))block
{
    [NetWork PostNetWorkWithUrl:@"/init_logo" with:nil successBlock:^(NSDictionary *dic)
    {
        [UserAccountManager shareUserAccountManager].logoImageUrl = [NSString stringWithFormat:@"%@",dic[@"data"]];
        [[NSUserDefaults standardUserDefaults] setObject:[UserAccountManager shareUserAccountManager].logoImageUrl forKey:@"logoImage"];
        block(YES);
    } errorBlock:^(NSString *error)
    {
        block(NO);
    }];
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    [[UserAccountManager shareUserAccountManager] saveAccountDefaults];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UserAccountManager shareUserAccountManager] saveAccountDefaults];
    [application setApplicationIconBadgeNumber:0];

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    /**
     *  当重新进入app时，刷新用户信息
     */
    [[UserAccountManager shareUserAccountManager]getUserInfoComplete:nil];
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    /**-设置通知栏为空*/
    long badgeCount = [UIApplication sharedApplication].applicationIconBadgeNumber;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badgeCount];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//本地推送通知
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //成功注册registerUserNotificationSettings:后，回调的方法
//    NSLog(@"%@",notificationSettings);
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    //收到本地推送消息后调用的方法
//    NSLog(@"%@",notification);
}

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler
{
    //在非本App界面时收到本地消息，下拉消息会有快捷回复的按钮，点击按钮后调用的方法，根据identifier来判断点击的哪个按钮，notification为消息内容
//    NSLog(@"%@----%@",identifier,notification);
    
    completionHandler();//处理完消息，最后一定要调用这个代码块
    
}

//远程推送通知
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //向APNS注册成功，收到返回的deviceToken
    // [3]:向个推服务器注册deviceToken 为了方便开发者，建议使用新方法
    [GeTuiSdk registerDeviceTokenData:deviceToken];

}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    //向APNS注册失败，返回错误信息error
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    //收到远程推送通知消息
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    // 将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler
{
    //在没有启动本App时，收到服务器推送消息，下拉消息会有快捷回复的按钮，点击按钮后调用的方法，根据identifier来判断点击的哪个按钮
}
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

//  iOS 10: App在前台获取到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    // 根据APP需要，判断是否要提示用户Badge、Sound、Alert
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

//  iOS 10: 点击通知进入App时触发，在该方法内统计有效用户点击数
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSError *err;
    if (response.notification.request.content.userInfo[@"payload"] == nil ) {
        return;
    }
    NSDictionary *payLoadIdc = [NSJSONSerialization JSONObjectWithData:[response.notification.request.content.userInfo[@"payload"] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&err];
    if (payLoadIdc == nil) {
        return;
    }
    NSString * sting = [NSString stringWithFormat:@"%@",payLoadIdc[@"type"]];
    // 0不跳 1内部 2外部
    if(payLoadIdc.count == 0)
    {
        return;
    }
    NSString * value =  [NSString stringWithFormat:@"%@",payLoadIdc[@"value"]];
    UINavigationController * navi = (UINavigationController *)self.window.rootViewController;
    [navi pushViewController:[ShufflingManager ShufflingManagerPushType:sting withValue:value] animated:YES];
    
    // [ GTSdk ]：将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:response.notification.request.content.userInfo];
    
    completionHandler();
}

#endif

#pragma MARK --

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSInteger orderState=[resultDic[@"resultStatus"] integerValue];
            if (orderState==9000)
            {

                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AliPaySucceed" object:nil userInfo:@{}];
            }
            else
            {
                NSString *returnStr;
                switch (orderState)
                {
                    case 8000:
                        returnStr=@"订单正在处理中";
                        break;
                    case 4000:
                        returnStr=@"订单支付失败";
                        break;
                    case 6001:
                        returnStr=@"订单支付取消";
                        break;
                    case 6002:
                        returnStr=@"网络连接出错";
                        break;
                    default:
                        break;
                }
                [HUDManager showWarningWithText:returnStr];
            }
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSInteger orderState=[resultDic[@"resultStatus"] integerValue];
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            if (orderState==9000)
            {
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AliPaySucceed" object:nil userInfo:@{}];
            }
            else
            {
                NSString *returnStr;
                switch (orderState)
                {
                    case 8000:
                        returnStr=@"订单正在处理中";
                        break;
                    case 4000:
                        returnStr=@"订单支付失败";
                        break;
                    case 6001:
                        returnStr=@"订单取消";
                        break;
                    case 6002:
                        returnStr=@"网络连接出错";
                        break;
                    default:
                        break;
                }
                [HUDManager showWarningWithText:returnStr];
            }

            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return  [WXApi handleOpenURL:url delegate:self];
}
#pragma mark 微信回调方法

- (void)onResp:(BaseResp *)resp
{
    NSString * strMsg = [NSString stringWithFormat:@"errorCode: %d",resp.errCode];
    NSLog(@"strMsg: %@",strMsg);
    
    NSString * errStr       = [NSString stringWithFormat:@"errStr: %@",resp.errStr];
    NSLog(@"errStr: %@",errStr);
    
    
    NSString * strTitle;
    //判断是微信消息的回调 --> 是支付回调回来的还是消息回调回来的.
    if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息的结果"];
    }
    
    NSString * wxPayResult;
    //判断是否是微信支付回调 (注意是PayResp 而不是PayReq)
    
    if ([resp isKindOfClass:[PayResp class]])
    {
        //支付返回的结果, 实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode)
        {
            case WXSuccess:
            {
                strMsg = @"支付结果:";
                NSLog(@"支付成功: %d",resp.errCode);
                wxPayResult = @"success";
                //发出通知 从微信回调回来之后,发一个通知,让请求支付的页面接收消息,并且展示出来,或者进行一些自定义的展示或者跳转
                NSNotification * notification = [NSNotification notificationWithName:@"AliPaySucceed" object:wxPayResult];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
            case WXErrCodeUserCancel:
            {
                strMsg = @"用户取消了支付";
                NSLog(@"用户取消支付: %d",resp.errCode);
                wxPayResult = @"cancel";
                [HUDManager showWarningWithText:strMsg];
                break;
            }
            default:
            {
                strMsg = [NSString stringWithFormat:@"支付失败! code: %d  errorStr: %@",resp.errCode,resp.errStr];
                NSLog(@":支付失败: code: %d str: %@",resp.errCode,resp.errStr);
                wxPayResult = @"faile";
                [HUDManager showWarningWithText:strMsg];
                break;
            }
        }
    }
}
#pragma mark --/** 注册 APNs */
- (void)registerRemoteNotification {
    /*
     警告：Xcode8 需要手动开启"TARGETS -> Capabilities -> Push Notifications"
     */
    
    /*
     警告：该方法需要开发者自定义，以下代码根据 APP 支持的 iOS 系统不同，代码可以对应修改。
     以下为演示代码，注意根据实际需要修改，注意测试支持的 iOS 系统都能获取到 DeviceToken
     */
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0 // Xcode 8编译会调用
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#else // Xcode 7编译会调用
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#endif
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                       UIRemoteNotificationTypeSound |
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
}
#pragma mark --/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    //个推SDK已注册，返回clientId
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
    [UserAccountManager shareUserAccountManager].pushUserID = clientId;
}

#pragma mark --/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    //收到个推消息
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
    }
    
    if (!offLine) {
        UIUserNotificationType types = UIUserNotificationTypeAlert;
        UIUserNotificationSettings *mySettings =[UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        
        //如果程序在后台运行，收到消息以通知类型来显示
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.alertAction = @"查看";
        localNotification.alertBody = @"您有一条新消息";//通知主体
        localNotification.soundName = UILocalNotificationDefaultSoundName;//通知声音
        localNotification.applicationIconBadgeNumber++;//标记数
        localNotification.userInfo = @{@"payload":payloadMsg};
        [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];//发送通知
        
    }
    
    NSString *msg = [NSString stringWithFormat:@"taskId=%@,messageId:%@,payloadMsg:%@%@",taskId,msgId, payloadMsg,offLine ? @"<离线消息>" : @""];
    NSLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);
}
@end
@implementation NSURLRequest(DataController)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}
@end

