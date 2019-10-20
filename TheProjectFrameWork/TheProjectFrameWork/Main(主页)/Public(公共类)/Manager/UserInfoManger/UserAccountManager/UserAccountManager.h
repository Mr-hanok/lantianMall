//
//  UserAccountManager.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/23.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FacebookUserModel.h"
#import "ShopModel.h"
#import "AdvertListModel.h"
#define kLoginStageKey @"appAsiaUserStage"
#define kFacebookLoginState @"FacebookLogin"

typedef void (^getUserInfoBlock) (id error , BOOL successful);
@class UserModel,ShopModel;
@interface UserAccountManager : NSObject

/**
 *  用户信息管理类单例初始化方法
 *
 *  @return UserAccountManager Instancetype
 */
+ (instancetype)shareUserAccountManager;
/**
 *  给管理类中的UserModel赋值(直接使用模型)
 *
 *  @param user is void
 */
- (void)loginWithModel:(UserModel *)user;
/**
 *  给管理类中的UserModel赋值(直接使用字典)
 *
 *  @param  user is void
 */
- (void)loginWithUserDic:(NSDictionary *)userDic;

/**
 *  使用Facebook登录保存相关信息
 */
- (void)facebookLoginWithUserModel:(UserModel *)user facebookModel:(FacebookUserModel *)facebook;
/**
 *  登出
 */

- (void)logout;

/**
 *  保存用户信息(持久化)
 */
- (void)saveAccountDefaults;

/**
 *  刷新(更新)用户信息
 *
 *  @param completed <#completed description#>
 */
- (void)getUserInfoComplete:(getUserInfoBlock)completed;

@property (nonatomic , strong , readonly) UserModel * userModel;///< 用户信息模型

@property (nonatomic , assign , readonly) BOOL loginStatus;///< 登录状态

@property (nonatomic , strong ) ShopModel * shopModel; ///< 店铺信息

@property (nonatomic , strong , readonly) FacebookUserModel * FacebookModel; ///< Facebook登录信息
@property (nonatomic , assign , readonly) BOOL sell;
/** 用户临时id */
 
/** 判断游客是否点击立即购买 */
@property(strong,nonatomic) NSString * isLogin;

/** 购物车数量 */
@property(strong,nonatomic) NSString * cartnumber;
/** 用户临时地址 */
@property(strong,nonatomic) NSString * cartUserAddress;
/** pushUserID */
@property(strong,nonatomic) NSString * pushUserID;

@property(strong,nonatomic) NSString * logoImageUrl;

@property (nonatomic , copy) NSString * servicePhone;
@property (nonatomic , copy) NSString * cartUserID;

@property (nonatomic, strong) NSArray *homeSliderModelArray;
@property (nonatomic, strong) NSArray *homeMarkSliderModelArray;
@property (nonatomic, strong) NSArray *interSliderModelArray;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) AdvertListModel *homeAdPopModel;

@end
