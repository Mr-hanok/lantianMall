//
//  MineBalanceViewController.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"

@interface MineBalanceViewController : LeftViewController
@property (nonatomic , assign) NSInteger type; ///< 1 = 账户余额  2 = 金币余额
@property (nonatomic , assign) BOOL buyer;
@property (nonatomic, strong) ShopModel *shopmodel;
@end
