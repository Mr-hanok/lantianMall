//
//  BindingPhoneViewController.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"
@class MineShopAccountModel;
@interface BindingPhoneViewController : LeftViewController

@property (nonatomic , assign) NSInteger type;
@property (nonatomic , assign) BOOL buyer;
@property (nonatomic , strong) MineShopAccountModel * shopModel;
@end
