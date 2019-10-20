//
//  RetrievePwdNextViewController.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"

@interface RetrievePwdNextViewController : LeftViewController

@property (nonatomic , strong) UserModel * user;
@property (nonatomic , assign) NSInteger type;///< 1 邮箱 2 手机号
@property (nonatomic , copy) NSString * code; ///< 接收到的验证码

@end
