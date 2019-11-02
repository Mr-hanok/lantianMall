//
//  IntegralHomeModel.h
//  TheProjectFrameWork
//
//  Created by yuntai on 16/8/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
/**积分商城首页模型*/
@interface IntegralHomeModel : NSObject

@property (nonatomic, copy) NSString *goodsId;
@property (nonatomic, copy) NSString *addTime;

@property (nonatomic, copy) NSString *ig_goods_name;
@property (nonatomic, copy) NSString *ig_goods_price;
@property (nonatomic, copy) NSString *ig_goods_integral;
@property (nonatomic, copy) NSString *ig_goods_sn;
@property (nonatomic, copy) NSString *ig_goods_count;
@property (nonatomic, copy) NSString *deleteStatus;
@property (nonatomic, copy) NSString *ig_content;
@property (nonatomic, copy) NSString *ig_begin_time;
@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *ig_limit_count;
/**结束时间*/
@property (nonatomic, copy) NSString *ig_end_time;
/**1 限制 */
@property (nonatomic, copy) NSString *ig_time_type;
/**上下架*/
@property (nonatomic, assign) BOOL ig_show;
@end

