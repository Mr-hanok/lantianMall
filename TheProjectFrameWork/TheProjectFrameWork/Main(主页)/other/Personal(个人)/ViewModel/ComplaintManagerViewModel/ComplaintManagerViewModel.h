//
//  ComplaintManagerViewModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ComplaintModel;
typedef void(^completeBlock) (id error);
@interface ComplaintManagerViewModel : NSObject
@property (nonatomic , strong) NSMutableArray <ComplaintModel *> * dataArray;
- (void)getDataCompletionHandle:(completeBlock)block;
/**
 *  分页
 *
 *  @param block <#block description#>
 */
- (void)getPageCompletionHandle:(completeBlock)block;

/**
 *  取消投诉
 *
 *  @param model <#model description#>
 *  @param block <#block description#>
 */
- (void)cancelComplaintWithModel:(ComplaintModel *)model completionHandle:(completeBlock)block;
@end
