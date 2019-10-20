//
//  ComplaintDetailedViewModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ComplaintDetailedViewModel.h"
#import "ComplaintDetailedModel.h"
#import "PhotoInfoModel.h"

@implementation ComplaintDetailedViewModel
{
    NSInteger complaint_id;
}
- (void)getComplaintDetailedWithID:(NSInteger)complaintID CompleteHandle:(completeBlock)block
{
    complaint_id = complaintID;
    [NetWork PostNetWorkWithUrl:@"/buyer/complaint_view" with:@{@"complaint_id":@(complaint_id)} successBlock:^(NSDictionary *dic) {
        _model = [ComplaintDetailedModel mj_objectWithKeyValues:dic[@"data"]];
        block(nil);
    } FailureBlock:^(NSString *msg) {
        block(msg);
    } errorBlock:^(id error) {
        block(error);
    }];
}
- (void)submitArbitrationCompleteHandle:(completeBlock)block
{
    [NetWork PostNetWorkWithUrl:@"/buyer/complaint_arbitrate" with:@{@"complaint_id":@(complaint_id)} successBlock:^(NSDictionary *dic) {
        block(nil);
    } FailureBlock:^(NSString *msg) {
        block(msg);
    } errorBlock:^(id error) {
        block(error);
    }];
}
- (void)updateDialogueCompleteHandle:(dialogueInfoBlock)block
{
    [NetWork PostNetWorkWithUrl:@"/buyer/refresh_talk" with:@{@"complaint_id":@(complaint_id)} successBlock:^(NSDictionary *dic) {
        block(dic[@"data"][@"talk_list"],nil);
    } FailureBlock:^(NSString *msg) {
        block(nil,msg);
    } errorBlock:^(id error) {
        block(nil,error);
    }];
}
- (void)publishDialogueWithContent:(NSString *)content CompleteHandle:(completeBlock)block
{
    [NetWork PostNetWorkWithUrl:@"/buyer/complaint_talk" with:@{@"user_id":kUserId,@"complaint_id":@(complaint_id),@"talk_content":content} successBlock:^(NSDictionary *dic) {
        block(nil);
    } FailureBlock:^(NSString *msg) {
        block(msg);
    } errorBlock:^(id error) {
        block(error);
    }];
}
- (void)appealSubmitWithImages:(NSArray <UIImage *>*)images content:(NSString *)content completeHandle:(completeBlock)block
{
    NSString * imageStr = nil;
    if(!(images.count == 0 || images == nil))
    {
        [NetWork PostUpLoadImageWithImages:images successBlock:^(NSArray<PhotoInfoModel *> *photoInfoArray) {
            [self getSubmitImageModels:photoInfoArray content:content completeHandle:block];
        } FailureBlock:^(NSString *msg) {
            block(msg);
        } errorBlock:^(id error) {
            block(error);
        }];
    }else
    {
        [NetWork PostNetWorkWithUrl:@"/buyer/save_appeal" with:@{@"complaint_id":@(complaint_id),@"photo":imageStr?:@"",@"content":content} successBlock:^(NSDictionary *dic) {
            block(nil);
        } FailureBlock:^(NSString *msg) {
            block(msg);
        } errorBlock:^(id error) {
            block(error);
        }];
    }
}
- (void)getSubmitImageModels:(NSArray <PhotoInfoModel * > *)models content:(NSString *)content completeHandle:(completeBlock)block
{
    NSMutableArray * images = [@[] mutableCopy];
    for (PhotoInfoModel * model in models) {
        [images addObject:@(model.photoID)];
    }
    NSString * imageStr = nil;
    if(images)
    {
        imageStr = [images componentsJoinedByString:@","];
    }
    [NetWork PostNetWorkWithUrl:@"/buyer/save_appeal" with:@{@"complaint_id":@(complaint_id),@"photo":imageStr,@"content":content} successBlock:^(NSDictionary *dic) {
        block(nil);
    } FailureBlock:^(NSString *msg) {
        block(msg);
    } errorBlock:^(id error) {
        block(error);
    }];
}
- (void)cancelComplaintWithCompleted:(completeBlock)completed
{
    [NetWork PostNetWorkWithUrl:@"/buyer/cancle_complaint" with:@{@"complaint_id":@(complaint_id)} successBlock:^(NSDictionary *dic) {
        completed(nil);
    } FailureBlock:^(NSString *msg) {
        completed(msg);
    } errorBlock:^(id error) {
        completed(error);
    }];
}
@end
