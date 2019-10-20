//
//  WalletDetailsCell.h
//  TheProjectFrameWork
//
//  Created by ZengPengYuan on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseTableViewCell.h"
@class AccountBalanceModel;
typedef NS_ENUM(NSInteger , WalletDetailsTypes) {
    /**
     *  付款记录
     */
    WalletDetailsTypePayment,
    /**
     *  充值记录
     */
    WalletDetailsTypeRecharge,
};
@interface WalletDetailsCell : BaseTableViewCell
@property (nonatomic , strong) AccountBalanceModel * balanceModel;
@property (nonatomic, assign) BOOL isGold;
@end
