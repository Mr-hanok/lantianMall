//
//  AccoutTiXianManagerController.h
//  TheProjectFrameWork
//
//  Created by yuntai on 2017/3/30.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"
/**提现管理*/
@interface AccoutTiXianManagerController : LeftViewController
/**卖家买家*/
@property (nonatomic, assign) NSInteger role;
@end


@interface TiXianManagerModel : NSObject
@property (nonatomic, copy) NSString *appliyDate;
@property (nonatomic, copy) NSString *depositType;
@property (nonatomic, copy) NSString *appliyDepositSum;
@property (nonatomic, copy) NSString *depositMark;
@property (nonatomic, copy) NSString *depositStatus;
@property (nonatomic, copy) NSString *depositAccount;
@end
