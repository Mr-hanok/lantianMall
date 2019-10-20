//
//  MyWalletSettleMentViewController.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"

@interface MyWalletSettleMentViewController : LeftViewController
@property(strong,nonatomic) NSString * payType;
@property(strong,nonatomic) NSString * orderNumber;
@property(strong,nonatomic) NSString * orderPayTypes;
@property(strong,nonatomic) NSString * orderMoney;
@property (nonatomic, assign) BOOL isIntegralOrder;
@property(assign,nonatomic) BOOL isUserebate;

@end
