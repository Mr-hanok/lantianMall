//
//  AppDelegate+PrivateMethods.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AppDelegate+PrivateMethods.h"
#import "BaseWebViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate (PrivateMethods)
#define MainURL @"/index_mall"
#define AdvertURL  @"/buyer/advertListByCode"
-(void)ProjectSetRootViewController{
    
    self.window = [[UIWindow alloc] initWithFrame:kScreenFreameBound];
    self.window.backgroundColor = [UIColor whiteColor];
    NSString *temprooturl = [[KAppRootUrl componentsSeparatedByString:@"/mobile"] firstObject];

    
    
    

    BaseWebViewController * tempweb1 = [[BaseWebViewController alloc] init];
    tempweb1.webUrl = [NSString stringWithFormat:@"%@%@",temprooturl,@"/phoneh5_zh/index.html"];
    UINavigationController *tempnavi = [[UINavigationController alloc]initWithRootViewController:tempweb1];
    
//    BaseWebViewController * tempweb2 = [[BaseWebViewController alloc] init];
//    tempweb2.webUrl = [NSString stringWithFormat:@"%@%@",temprooturl,@"/phoneh5_zh/classificationl.html"];
//    UINavigationController *tempnavi2 = [[UINavigationController alloc]initWithRootViewController:tempweb2];
//
//
//    BaseWebViewController * tempweb3 = [[BaseWebViewController alloc] init];
//    tempweb3.webUrl = [NSString stringWithFormat:@"%@%@",temprooturl,@"/phoneh5_zh/myIntegral.html"];
//    UINavigationController *tempnavi3 = [[UINavigationController alloc]initWithRootViewController:tempweb3];
//
//    BaseWebViewController * tempweb4 = [[BaseWebViewController alloc] init];
//    tempweb4.webUrl = [NSString stringWithFormat:@"%@%@",temprooturl,@"/phoneh5_zh/shopping_cars.html"];
//    UINavigationController *tempnavi4 = [[UINavigationController alloc]initWithRootViewController:tempweb4];
//
//    BaseWebViewController * tempweb5 = [[BaseWebViewController alloc] init];
//    tempweb5.webUrl = [NSString stringWithFormat:@"%@%@",temprooturl,@"/phoneh5_zh/aboutMe.html"];
//    UINavigationController *tempnavi5 = [[UINavigationController alloc]initWithRootViewController:tempweb5];
//
//    // 设置tabBarController
//    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"integralStoreSwitch"]) {
//        mTabBar.viewControllers = @[tempnavi,tempnavi2,tempnavi3,tempnavi4,tempnavi5];
//
//    }else{
//        mTabBar.viewControllers = @[tempnavi,tempnavi2,tempnavi4,tempnavi5];
//
//    }
    
    self.window.rootViewController = tempnavi;
    [self.window makeKeyAndVisible];
    return;
    

    
}
-(void)NetWork
{
    NSDictionary * dic =@{@"id":@"262162",
                          @"user_id":[UserAccountManager shareUserAccountManager].loginStatus?kUserId:@"",};
    [NetWork PostNetWorkWithUrl:MainURL with:dic successBlock:^(NSDictionary *dic)
     {
         if ([dic[@"status"] boolValue])
         {
             [dic ds_writefiletohomePath:MainURL];
         }
     } errorBlock:^(NSString *error)
     {

     }];
    
}
-(void)getMianDataFromServer
{
    NSDictionary * dic = [NSDictionary ds_readfiletohomePath:MainURL];
    if ([[dic allKeys]count])
    {
    }else{
        [self NetWork];
    }
}
-(void)NetWorkAdver:(void (^)(BOOL isSuccess))resultBloclk
{
    NSDictionary * dic =@{@"code":@"['AP100004','AP100005','AP100006','AP100008']",
                          @"user_id":[UserAccountManager shareUserAccountManager].loginStatus?kUserId:@"",};
    [NetWork PostNetWorkWithUrl:AdvertURL with:dic successBlock:^(NSDictionary *dic)
     {
         if ([dic[@"status"] boolValue])
         {
             NSArray *tempArray = dic[@"data"];
             for (NSDictionary *temdic in tempArray) {
                 if ([temdic[@"ap_encoding"] isEqualToString:@"AP100004"]) {
                     [UserAccountManager shareUserAccountManager].homeSliderModelArray = [AdvertListModel mj_objectArrayWithKeyValuesArray:temdic[@"advs"]];
                 }else if ([temdic[@"ap_encoding"] isEqualToString:@"AP100005"]){
                     [UserAccountManager shareUserAccountManager].homeMarkSliderModelArray = [AdvertListModel mj_objectArrayWithKeyValuesArray:temdic[@"advs"]];

                 }else if ([temdic[@"ap_encoding"] isEqualToString:@"AP100006"]){
                     [UserAccountManager shareUserAccountManager].interSliderModelArray = [AdvertListModel mj_objectArrayWithKeyValuesArray:temdic[@"advs"]];
                 }else if ([temdic[@"ap_encoding"] isEqualToString:@"AP100008"]){
                     [UserAccountManager shareUserAccountManager].homeAdPopModel =[[AdvertListModel mj_objectArrayWithKeyValuesArray:temdic[@"advs"]] firstObject];
                     
                     static dispatch_once_t onceToken;
                     dispatch_once(&onceToken, ^{
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             [[NSNotificationCenter defaultCenter] postNotificationName:@"homeAdPopNoti" object:nil];
                             
                         });
                     });
                 }
             }
             resultBloclk(YES);
         }
     } errorBlock:^(NSString *error)
     {
         
     }];
    
}
@end
