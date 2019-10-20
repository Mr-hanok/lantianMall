//
//  RechargeManagerModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/14.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  充值管理数据模型
 */
@interface RechargeManagerModel : NSObject

@property (nonatomic , assign) CGFloat sum; ///< 金额
@property (nonatomic , copy) NSString * payMode; ///< 支付方式
@property (nonatomic , copy) NSString * date; ///< 时间
@property (nonatomic , assign) NSInteger mobile_pay_status; ///< 支付状态


@end
