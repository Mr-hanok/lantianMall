//
//  MineRebateViewModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/9/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineRebateViewModel.h"
#import "MineRebateModel.h"

@implementation MineRebateViewModel

- (void)getRebateInfoWithType:(NSInteger)type complete:(completeBlock)complete
{
    NSDictionary * params = @{@"user_id":kUserId,@"status":@(type)};
    [HUDManager showLoadingHUDView:Kwindow withText:@"请稍候"];
    [NetWork PostNetWorkWithUrl:@"/getRebateLogInfo" with:params successBlock:^(NSDictionary *dic) {
        [HUDManager hideHUDView];
        _dataArray = [MineRebateModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"reList"]];
        NSNumber * tatal = dic[@"data"][@"rebate_total"];
        CGFloat tatalFloat = [tatal floatValue];
        _rebate_total = [NSString stringWithFormat:@"%.2f",tatalFloat];
        complete(nil);
    } FailureBlock:^(NSString *msg) {
        [HUDManager hideHUDView];
        _dataArray = nil;
        complete(msg);
    } errorBlock:^(id error) {
        [HUDManager hideHUDView];
        _dataArray = nil;
        complete(error);
    }];
}

@end
