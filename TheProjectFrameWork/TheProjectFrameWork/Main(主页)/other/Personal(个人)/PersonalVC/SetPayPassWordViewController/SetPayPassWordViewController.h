//
//  SetPayPassWordViewController.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/14.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"
/**
 *  设置支付密码
 */
@interface SetPayPassWordViewController : LeftViewController
@property (nonatomic , assign) BOOL buyer;
@property (nonatomic , copy) NSString * userName;
@property (nonatomic , assign) BOOL isCreat;
@property (nonatomic, copy) NSString *code;
@end
