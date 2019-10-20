//
//  VipPriceModel.h
//  TheProjectFrameWork
//
//  Created by yuntai on 2017/12/23.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
/**优惠券model*/
@interface VipPriceModel : NSObject
@property (nonatomic, copy) NSString *modelId;
@property (nonatomic, copy) NSString *coupon_amount;
@property (nonatomic, copy) NSString *store_id;
@property (nonatomic, copy) NSString *coupon_begin_time;
@property (nonatomic, copy) NSString *coupon_end_time;
@property (nonatomic, copy) NSString *coupon_order_amount;
@property (nonatomic, copy) NSString *coupon_desc;
@property (nonatomic, copy) NSString *coupon_name;
@property (nonatomic, copy) NSString *coupon_type;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *store_name;
@property (nonatomic, copy) NSString *overdue;
@end


@interface VipPriceShopModel : NSObject
@property (nonatomic, copy) NSString *modelId;
@property (nonatomic, copy) NSString *available;
@property (nonatomic, copy) NSString *couponAmount;
@property (nonatomic, copy) NSString *couponBeginTime;
@property (nonatomic, copy) NSString *couponEndTime;
@property (nonatomic, copy) NSString *couponId;
@property (nonatomic, copy) NSString *couponName;
@property (nonatomic, copy) NSString *couponStoreId;
@property (nonatomic, copy) NSString *couponStoreName;
@property (nonatomic, copy) NSString *couponType;
@property (nonatomic, copy) NSString *coupon_order_amount;
/**0 未领取 1已经领取*/
@property (nonatomic, copy) NSString *receive;

/******选择优惠券字段*********/

@property (nonatomic, copy) NSString *vipPriceId;
@property (nonatomic, copy) NSString *coupon_name;
@property (nonatomic, copy) NSString *coupon_end_time;
@property (nonatomic, copy) NSString *coupon_begin_time;
@property (nonatomic, copy) NSString *coupon_order_amountss;
@property (nonatomic, copy) NSString *coupon_count;
@property (nonatomic, copy) NSString *coupon_amount;
@property (nonatomic, copy) NSString *couponTypetype;

@property (nonatomic, copy) NSString *tempstr;
@end
