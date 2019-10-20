//
//  AccountBalanceModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountBalanceModel : NSObject

@property (nonatomic , copy) NSString * addTime;
@property (nonatomic , copy) NSString * pd_log_amount;
@property (nonatomic , copy) NSString * pd_op_type;

@property (nonatomic, copy) NSString *gl_count;
@property (nonatomic, copy) NSString *gl_money;
@property (nonatomic, copy) NSString *gl_type;
@property (nonatomic, copy) NSString *gl_content;
@property (nonatomic , copy) NSString * pd_log_info;
@property (nonatomic , assign) NSInteger status;
@property (nonatomic, copy) NSString *payTypeStr;


@end
