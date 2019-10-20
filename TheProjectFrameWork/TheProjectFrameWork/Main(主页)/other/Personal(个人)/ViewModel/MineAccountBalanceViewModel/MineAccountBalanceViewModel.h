//
//  MineAccountBalanceViewModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AccountBalanceModel;
typedef void(^completeBlock) (id error);
@interface MineAccountBalanceViewModel : NSObject
@property (nonatomic , strong) NSMutableArray <AccountBalanceModel *>* balanceArray;
@property (nonatomic , assign) double balance;

/**
 *  获取账户余额
 *
 *  @param buyer 是否是买家
 *  @param type  判断全部，支出，收入
 *  @param block 完成返回回调
 */
- (void)getMineAccountBalanceDataWithBuyer:(BOOL)buyer type:(NSInteger)type complete:(completeBlock)block;
/**
 *  获取金币交易记录
 *
 *  @param type  全部，支出，收入
 *  @param block 完成返回回调
 */
- (void)getMineAccountGoldDataWithType:(NSInteger)type complete:(completeBlock)block;
@end
