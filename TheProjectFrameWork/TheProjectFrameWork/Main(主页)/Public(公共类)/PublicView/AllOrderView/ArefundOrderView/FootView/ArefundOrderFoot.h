//
//  ArefundOrderFoot.h
//  TheProjectFrameWork
//
//  Created by maple on 16/9/13.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArefundOrderFoot : UITableViewHeaderFooterView
/** 交易金额 */
@property (weak, nonatomic) IBOutlet UILabel *TransactionAmountLabel;
/** 退款金额 */
@property (weak, nonatomic) IBOutlet UILabel *ArefundAmountLabel;

@end
