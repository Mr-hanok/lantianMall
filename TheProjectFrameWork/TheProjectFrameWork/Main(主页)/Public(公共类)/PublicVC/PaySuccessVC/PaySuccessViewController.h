//
//  PaySuccessViewController.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseViewController.h"

@interface PaySuccessViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *payTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *walletLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (nonatomic, copy) NSString *moneyStr;
@property(strong,nonatomic) NSString * payType;
@property(assign,nonatomic) BOOL ISIntegralConvert;



@end
