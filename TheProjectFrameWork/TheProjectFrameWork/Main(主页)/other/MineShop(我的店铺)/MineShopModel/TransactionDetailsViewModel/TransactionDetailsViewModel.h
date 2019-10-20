//
//  TransactionDetailsViewModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/16.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TransactionDetailsModel;
typedef void(^completeBlock) (id error);
/**兑换model明细*/
@interface TransactionDetailsViewModel : NSObject
@property (nonatomic , strong) NSArray <TransactionDetailsModel *>* dataArray;
- (void)getTransactionDetailsCompleteHandle:(completeBlock)block;
- (void)getTransactionDetailsPageCompleteHandle:(completeBlock)block;
@end
