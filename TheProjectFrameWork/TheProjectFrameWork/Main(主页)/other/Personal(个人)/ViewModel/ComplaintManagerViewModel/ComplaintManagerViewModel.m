//
//  ComplaintManagerViewModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ComplaintManagerViewModel.h"
#import "ComplaintModel.h"

@implementation ComplaintManagerViewModel
{
    NSMutableDictionary * params;
    NSInteger currentPage;
}
- (void)getDataCompletionHandle:(completeBlock)block
{
     __block NSArray * modelArray;
    currentPage = 1;
    params = [@{@"user_id":kUserId,@"currentPage":@(currentPage),@"pageSize":@(10)} mutableCopy];
    [NetWork PostNetWorkWithUrl:@"/buyer/complaint" with:params successBlock:^(NSDictionary *dic) {
        modelArray = [ComplaintModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        _dataArray = [modelArray mutableCopy];
        currentPage ++;
        block(nil);
    } FailureBlock:^(NSString *msg) {
        block(msg);
        [HUDManager showWarningWithText:msg];
    } errorBlock:^(id error) {
        block(error);
    }];
}
- (void)getPageCompletionHandle:(completeBlock)block
{
    [params setObject:@(currentPage) forKey:@"currentPage"];
    __block NSArray * modelArray;
    [NetWork PostNetWorkWithUrl:@"/buyer/complaint" with:params successBlock:^(NSDictionary *dic) {
        modelArray = [ComplaintModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        [_dataArray addObjectsFromArray:modelArray];
        currentPage ++;
        block(nil);
    } FailureBlock:^(NSString * msg) {
        block(msg);
    } errorBlock:^(id error) {
        block(error);
    }];

}
- (void)cancelComplaintWithModel:(ComplaintModel *)model completionHandle:(completeBlock)block
{
    [NetWork PostNetWorkWithUrl:@"/buyer/cancle_complaint" with:@{@"complaint_id":@(model.complaintID)} successBlock:^(NSDictionary *dic) {
        block(nil);
    } FailureBlock:^(NSString *msg) {
        block(msg);
    } errorBlock:^(id error) {
        block(error);
    }];
}
@end
