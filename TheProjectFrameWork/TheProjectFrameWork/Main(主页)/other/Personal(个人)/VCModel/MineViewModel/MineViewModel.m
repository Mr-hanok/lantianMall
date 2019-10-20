//
//  MineViewModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/19.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineViewModel.h"
@implementation MineViewModel

+ (void)getMineInfo:(completeBlock)block
{
     __block MineViewModel * model = [[MineViewModel alloc] init];
    [NetWork PostNetWorkWithUrl:@"/buyer/member_info" with:@{@"user_id":@([UserAccountManager shareUserAccountManager].userModel.userId)} successBlock:^(NSDictionary *dic) {
        NSDictionary * contentDic = dic[@"data"][@"user"];
        model = [MineViewModel mj_objectWithKeyValues:contentDic];
        model.AccountSafe = @"可修改密码";
           if (block) block(model,nil);
        } FailureBlock:^(NSString * msg) {
           if (block) block(nil,msg);
        } errorBlock:^(id error) {
           if (block) block(nil,error);
        }];
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"telephone":@"mobile"};
}
@end


