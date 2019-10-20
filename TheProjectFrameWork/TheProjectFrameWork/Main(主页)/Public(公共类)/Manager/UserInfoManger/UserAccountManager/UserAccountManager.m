//
//  UserAccountManager.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/23.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "UserAccountManager.h"
#import "UserModel.h"
#import "ShopModel.h"
#import "AppAsiaShare.h"
@implementation UserAccountManager
static UserAccountManager * manager;

+ (instancetype)shareUserAccountManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserAccountManager alloc] init];
        NSString * logoimage = [[NSUserDefaults standardUserDefaults] objectForKey:@"logoImage"];
        manager.logoImageUrl = logoimage;
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    
    if(!self) return nil;

    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userDic = [userDefaults objectForKey:kLoginStageKey];
    NSDictionary * facebookDic = [userDefaults objectForKey:kFacebookLoginState];
    if(userDic)
    {
        _userModel = [UserModel mj_objectWithKeyValues:userDic];
        _loginStatus = YES;
    }
    if(facebookDic)
    {
        _FacebookModel = [FacebookUserModel mj_objectWithKeyValues:facebookDic];
        _loginStatus = YES;
    }
    return self;
}

- (void)loginWithModel:(UserModel *)user
{
    _userModel = user;
    _loginStatus = YES;
    [self saveAccountDefaults];
}
- (void)loginWithUserDic:(NSDictionary *)userDic
{
    UserModel * userModel = [UserModel mj_objectWithKeyValues:userDic];
    _userModel = userModel;
    _loginStatus = YES;
    _cartUserAddress = userModel.defaultAdddress;
    [self saveAccountDefaults];
}
- (void)logout
{
    _userModel = nil;
    _FacebookModel = nil;
    _shopModel = nil;
    [self removeAccountDefaults];
    [AppAsiaShare cancelCurrentAuthorization];
}
- (void)getUserInfoComplete:(getUserInfoBlock)completed
{
    if(!_loginStatus)
    {
        if(completed)
        {
            completed(nil,NO);
        }
        return;
    }
    [NetWork PostNetWorkWithUrl:@"/getUserInfo" with:@{@"user_id":@(_userModel.userId)} successBlock:^(NSDictionary *dic) {
        [[UserAccountManager shareUserAccountManager] loginWithUserDic:dic[@"data"]];
        if(completed)
        {
            completed(nil,YES);
        }
    } FailureBlock:^(NSString *msg) {
        if(completed)
        {
            completed(msg,NO);
        }
    } errorBlock:^(id error) {
        if(completed)
        {
            completed(error,NO);
        }
    }];
}

- (void)loadShopInfoWith:(NSDictionary *)dic
{
    _shopModel = [ShopModel mj_objectWithKeyValues:dic];
}
- (void)facebookLoginWithUserModel:(UserModel *)user facebookModel:(FacebookUserModel *)facebook
{
    _userModel = user;
    _FacebookModel = facebook;
    _loginStatus = YES;
    [self saveAccountDefaults];
    [self saveFacebookInfoDefaults];
}


#pragma mark - private
/**
 *  保存用户信息至NSUserDefaults
 */
- (void)saveAccountDefaults
{
    if(!_loginStatus)
    {
        return;
    }
    NSDictionary * dic = [_userModel mj_keyValues];
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dic forKey:kLoginStageKey];
}
/**
 *  保存Facebook信息至NSUserDefaults
 */
- (void)saveFacebookInfoDefaults
{
    NSDictionary * dic = [_FacebookModel mj_keyValues];
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dic forKey:kFacebookLoginState];
    _loginStatus = YES;
}
/**
 *  删除NSUserDefaults中的用户信息
 */
- (void)removeAccountDefaults
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:kLoginStageKey];
    [userDefaults removeObjectForKey:kFacebookLoginState];
    _loginStatus = NO;

}
#pragma mark - setter and getter
- (NSString *)cartUserID
{
    if(_cartUserID.length == 0 || _cartUserID == nil)
    {
        return @"";
    }
    return _cartUserID;
}
@end
