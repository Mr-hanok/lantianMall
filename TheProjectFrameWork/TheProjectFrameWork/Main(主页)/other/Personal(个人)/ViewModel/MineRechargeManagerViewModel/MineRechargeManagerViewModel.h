//
//  MineRechargeManagerViewModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/16.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^completeBlock) (id  error);
@class RechargeManagerModel;
@interface MineRechargeManagerViewModel : NSObject
@property (nonatomic , strong) NSMutableArray<RechargeManagerModel *> * dataArray;
- (void)getMineRechargeManagerWithRole:(NSInteger)role completeHandle:(completeBlock)block;
- (void)getMineRechargeManagerPageCompleteHandle:(completeBlock)block;
@end
