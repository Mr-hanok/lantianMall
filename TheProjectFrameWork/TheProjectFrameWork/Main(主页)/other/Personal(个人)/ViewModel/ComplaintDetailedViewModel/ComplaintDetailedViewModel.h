//
//  ComplaintDetailedViewModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ComplaintDetailedModel.h"
@class ComplaintDetailedModel;
typedef void(^completeBlock) (id error);
typedef void(^dialogueInfoBlock) (NSArray * array , id error);
@interface ComplaintDetailedViewModel : NSObject
@property (nonatomic , strong) ComplaintDetailedModel * model;
- (void)getComplaintDetailedWithID:(NSInteger)complaintID CompleteHandle:(completeBlock)block;

/**
 *  提交仲裁
 *
 *  @param complaintID <#complaintID description#>
 *  @param block       <#block description#>
 */
- (void)submitArbitrationCompleteHandle:(completeBlock)block;

/**
 *  刷新对话
 *
 *  @param complaintID <#complaintID description#>
 *  @param block       <#block description#>
 */
- (void)updateDialogueCompleteHandle:(dialogueInfoBlock)block;
/**
 *  发布对话
 *
 *  @param complaintID <#complaintID description#>
 *  @param content     <#content description#>
 *  @param block       <#block description#>
 */
- (void)publishDialogueWithContent:(NSString *)content CompleteHandle:(completeBlock)block;


/**
 *  待申诉中发起申诉
 *
 *  @param images  <#images description#>
 *  @param content <#content description#>
 *  @param block   <#block description#>
 */
- (void)appealSubmitWithImages:(NSArray <UIImage *>*)images content:(NSString *)content completeHandle:(completeBlock)block;

/**
 *  取消投诉
 *
 *  @param completed <#completed description#>
 */
- (void)cancelComplaintWithCompleted:(completeBlock)completed;
@end

