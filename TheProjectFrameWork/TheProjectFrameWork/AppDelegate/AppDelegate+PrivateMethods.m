//
//  AppDelegate+PrivateMethods.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AppDelegate+PrivateMethods.h"
#import "BaseWebViewController.h"
#import "ClassificationViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate (PrivateMethods)
#define MainURL @"/index_mall"
#define AdvertURL  @"/buyer/advertListByCode"
-(void)ProjectSetRootViewController{
    
    self.window = [[UIWindow alloc] initWithFrame:kScreenFreameBound];
    self.window.backgroundColor = [UIColor whiteColor];
    NSString *temprooturl = [[KAppRootUrl componentsSeparatedByString:@"/mobile"] firstObject];

    
    
    

//    BaseWebViewController * tempweb1 = [[BaseWebViewController alloc] init];
//    tempweb1.webUrl = [NSString stringWithFormat:@"%@%@",temprooturl,@"/phoneh5_zh/index.html"];
//    UINavigationController *tempnavi = [[UINavigationController alloc]initWithRootViewController:tempweb1];
//    self.window.rootViewController = tempnavi;
//    [self.window makeKeyAndVisible];

    
    UITabBarController * mianTabBar = [[UITabBarController alloc] init];
    // 首页
    UIStoryboard * homeStoryBoard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    UINavigationController * homeNaV = [homeStoryBoard instantiateInitialViewController];
    NSString * string =[LaguageControl languageWithString:@"首页"];
    homeNaV.tabBarItem.title =string;
    [LaguageControl shareControl].MainTarBar = homeNaV.tabBarItem;
    homeNaV.tabBarItem.image = [UIImage imageNamed:@"shouye"];
    homeNaV.tabBarItem.selectedImage = [UIImage imageNamed:@"shouye1"];
    
    
    // 积分商城
    UIStoryboard * integralMallStoryBoard = [UIStoryboard storyboardWithName:@"IntegralMall" bundle:nil];
    UINavigationController * integralMallNaV = [integralMallStoryBoard instantiateInitialViewController];
    [LaguageControl shareControl].IntegralMallTarBar = integralMallNaV.tabBarItem;

    NSString * integralMallstring =[LaguageControl languageWithString:@"积分商城"];
    integralMallNaV.tabBarItem.title = integralMallstring;
    integralMallNaV.tabBarItem.image = [UIImage imageNamed:@"jficon-n"];
    integralMallNaV.tabBarItem.selectedImage = [UIImage imageNamed:@"jficon-h"];
    
    
    //购物车
    UIStoryboard * shoppingCartStoryBoard = [UIStoryboard storyboardWithName:@"ShoppingCart" bundle:nil];
    UINavigationController *shoppingCartNaV = [shoppingCartStoryBoard instantiateInitialViewController];
    [LaguageControl shareControl].CattTarBar = shoppingCartNaV.tabBarItem;
    NSString * shopstring =[LaguageControl languageWithString:@"购物车"];
    shoppingCartNaV.tabBarItem.title = shopstring;
    shoppingCartNaV.tabBarItem.image = [UIImage imageNamed:@"gouwuche"];
    shoppingCartNaV.tabBarItem.selectedImage = [UIImage imageNamed:@"gouwuche1"];
    
    //个人
    UIStoryboard * personalStoryBoard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
    UINavigationController * personalNaV = [personalStoryBoard instantiateInitialViewController];
    [LaguageControl shareControl].PresonTarBar = personalNaV.tabBarItem;

    NSString * personstring =[LaguageControl languageWithString:@"我的"];

    personalNaV.tabBarItem.title = personstring;
    personalNaV.tabBarItem.image = [UIImage imageNamed:@"wode"];
    personalNaV.tabBarItem.selectedImage = [UIImage imageNamed:@"wode1"];
    
    /**分类*/
       ClassificationViewController *classVc = [[ClassificationViewController alloc]init];
       UINavigationController *classNavi =[[UINavigationController alloc]initWithRootViewController:classVc];
       classNavi.title = @"分类";;
       classNavi.navigationBar.translucent = NO;
       classNavi.tabBarItem.image = [UIImage imageNamed:@"xinwen"];
       classNavi.tabBarItem.selectedImage = [UIImage imageNamed:@"xinwen1"];
    
    
    // 设置tabBarController
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"integralStoreSwitch"]) {
        mianTabBar.viewControllers = @[homeNaV,classNavi,integralMallNaV,shoppingCartNaV,personalNaV];

    }else{
        mianTabBar.viewControllers = @[homeNaV,classNavi,shoppingCartNaV,personalNaV];

    }
    
    mianTabBar.delegate = self;
    mianTabBar.tabBar.tintColor=kNavigationColor;
    self.window.rootViewController = mianTabBar;
    
    
    //字体大小，颜色（未被选中时）
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica"size:12.0f],NSFontAttributeName,nil]forState:UIControlStateNormal];
    //字体大小，颜色（被选中时）
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kNavigationColor,NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica"size:12.0f],NSFontAttributeName,nil]forState:UIControlStateSelected];
    /**黑线颜色*/
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -0.5, KSCREEN_WIDTH, 0.5)];
    view.backgroundColor = [UIColor colorWithString:@"#f5f5f5"];
    [[UITabBar appearance] insertSubview:view atIndex:0];
    
    //设置图片位置
    UIEdgeInsets insets=UIEdgeInsetsMake(-3, 0, 3, 0);
    personalNaV.tabBarItem.imageInsets = shoppingCartNaV.tabBarItem.imageInsets =   classNavi.tabBarItem.imageInsets = homeNaV.tabBarItem.imageInsets =integralMallNaV.tabBarItem.imageInsets= insets;
    //设置文字位置
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -4)];
    
    
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
