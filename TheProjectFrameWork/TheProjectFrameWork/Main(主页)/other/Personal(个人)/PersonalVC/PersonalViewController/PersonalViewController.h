//
//  PersonalViewController.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  我的

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger ,PersonalTypes) {

    /**
     *  订单
     */
    PersonalTypeOrder  = 1 << 1,
    /**
     *  钱包
     */
    PersonalTypeWallet = 1 << 2,
    /**
     *  积分 
     */
    PersonalTypePoint  = 1 << 3,
};
/**
 *   MinePropertyCell返回类型
 */
typedef NS_ENUM(NSInteger , MinePropertyType) {
    /**
     *  账户
     */
    MinePropertyTypeWallet = 101,
    /**
     *  积分商城
     */
    MinePropertyTypePointShop = 102,
    /**
     *  账户明细
     */
    MinePropertyTypeWalletDetails = 201,
    /**
     *  积分明细
     */
    MinePropertyTypePointShopDetails = 202,
};
@interface PersonalViewController : BaseViewController
- (void)reloadUserInfo;
@end
