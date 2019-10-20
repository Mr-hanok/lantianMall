//
//  ArefundOrderDetailViewModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/9/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^completedBlock) (id error);
@class RefundDetailDerailModel;
@interface ArefundOrderDetailViewModel : NSObject
@property (nonatomic , copy) NSString * refundAmount;
@property (nonatomic , strong) NSArray <RefundDetailDerailModel *>* refundDetails;
- (void)getArefundOrderDetailInfoWithOrderid:(NSString *)order_id complete:(completedBlock)block;
@end


@interface RefundDetailDerailModel : NSObject
@property (nonatomic , copy) NSString * reasonInfo;///< 退款原因
@property (nonatomic , copy) NSString * time; ///< 时间
@property (nonatomic , copy) NSString * operate; ///< 操作
@property (nonatomic , copy) NSString * reason; ///< ？？？



@end