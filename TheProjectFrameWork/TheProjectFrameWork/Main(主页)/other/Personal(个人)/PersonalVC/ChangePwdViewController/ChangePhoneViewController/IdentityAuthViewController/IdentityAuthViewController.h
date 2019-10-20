//
//  IdentityAuthViewController.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  身份验证页面

#import "LeftViewController.h"
@class MineShopAccountModel;
@interface IdentityAuthViewController : LeftViewController
@property (nonatomic , assign) NSInteger type;
@property (nonatomic , assign) BOOL buyer;
@property (nonatomic , strong) MineShopAccountModel * shopModel;
@end

