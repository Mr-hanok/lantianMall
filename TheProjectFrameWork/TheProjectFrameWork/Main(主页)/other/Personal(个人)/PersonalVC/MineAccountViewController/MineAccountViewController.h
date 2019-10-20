//
//  MineAccountViewController.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"

typedef void (^LogoutBackCallBlock) ();
typedef NS_ENUM(NSInteger , MineAccountOptions)
{
    /**
     *  用户名称
     */
    MineAccountOptionAccount = 0,
    /**
     *  可用余额
     */
    MineAccountOptionBalance = 1,
    /**
     *  电子邮箱
     */
    MineAccountOptionEmail = 2,
    /**
     *  手机号码
     */
    MineAccountOptionPhone = 3,
    /**
     *  真实姓名
     */
    MineAccountOptionName = 4,
    /**
     *  性别
     */
    MineAccountOptionSex = 5,
    /**
     *  出生日期
     */
    MineAccountOptionBirthdate = 6,
    /**
     *  期限日期
     */
    MineAccountOptionQiXian = 10,
    /**
     *  地址管理
     */
    MineAccountOptionAddressManagr = 7,
    /**
     *  账户安全
     */
    MineAccountOptionAccountSafe = 8,
    /**
     *  实名认证
     */
    MineAccountOptionCertification = 9,
};
@interface MineAccountViewController : LeftViewController
- (instancetype)initWithLogoutBackCall:(LogoutBackCallBlock)logout;
@property (nonatomic , copy) LogoutBackCallBlock logoutEvent;

@end
