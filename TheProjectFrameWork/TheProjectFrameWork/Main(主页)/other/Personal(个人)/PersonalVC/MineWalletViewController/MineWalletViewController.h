//
//  MineWalletViewController.h
//  TheProjectFrameWork
//
//  Created by ZengPengYuan on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"
typedef NS_ENUM(NSInteger , MineWalletOptions) {
    /**
     *  钱包余额
     */
    MineWalletOptionBalance = 0,
    /**
     *  返利金额
     */
    MineWalletOptionRebate = 1,
    /**
     *  充值管理
     */
    MineWalletOptionManagement = 2,
    /**
     *  交易明细（卖家）
     */
    MineWalletOptionTransactionDetails = 3,
    /**
     *  提现管理（卖家）
     */
    MineWalletOptionTiXianGuanLi = 4,
};
@interface MineWalletViewController : LeftViewController
@property (nonatomic , assign) BOOL buyer;
@property (nonatomic , strong) ShopModel * model;

@end
