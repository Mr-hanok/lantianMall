//
//  SelectVipPriceListViewController.h
//  TheProjectFrameWork
//
//  Created by yuntai on 2017/12/24.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"
#import "VipPriceModel.h"
/**选择优惠券*/
@interface SelectVipPriceListViewController : LeftViewController
@property (nonatomic, copy) NSString *storeID;
@property (nonatomic, copy) void (^selectVipPriceBlock)(id  model);
/**价格*/
@property (nonatomic, copy) NSString *useV;
/**是否是领取页面*/
@property (nonatomic, assign) BOOL isLingQu;
@end
