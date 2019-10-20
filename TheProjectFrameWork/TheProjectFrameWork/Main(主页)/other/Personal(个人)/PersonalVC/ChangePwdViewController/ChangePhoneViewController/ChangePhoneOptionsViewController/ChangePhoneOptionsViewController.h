//
//  ChangePhoneOptionsViewController.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"
@class MineShopAccountModel;
@interface ChangePhoneOptionsViewController : LeftViewController
@property (nonatomic , assign) PopVerifyTypes type;
@property (nonatomic , assign) BOOL buyer;
@property (nonatomic , strong) MineShopAccountModel * shopUserModel;

@end
