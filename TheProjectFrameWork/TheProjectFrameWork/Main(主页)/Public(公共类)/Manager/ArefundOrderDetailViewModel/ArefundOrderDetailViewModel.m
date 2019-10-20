//
//  ArefundOrderDetailViewModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/9/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ArefundOrderDetailViewModel.h"

@implementation ArefundOrderDetailViewModel
- (void)getArefundOrderDetailInfoWithOrderid:(NSString *)order_id complete:(completedBlock)block
{
    [NetWork PostNetWorkWithUrl:@"/buyer/watch_refundLog" with:@{@"of_id":order_id} successBlock:^(NSDictionary *dic) {
        _refundAmount = dic[@"data"][@"rfrecord"][@"refundAmount"];
        _refundDetails = [RefundDetailDerailModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"rfrecord"][@"rm"]];
        block(nil);
    } FailureBlock:^(NSString *msg) {
        block(msg);
    } errorBlock:^(id error) {
        block(error);
    }];
}
@end


@implementation RefundDetailDerailModel



@end
