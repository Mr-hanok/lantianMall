//
//  MineRebateViewModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/9/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^completeBlock) (id error);
@interface MineRebateViewModel : NSObject
@property (nonatomic , strong) NSArray * dataArray;
@property (nonatomic , copy) NSString * rebate_total;
/**
 *  查询返利记录
 *
 *  @param type     Type 1:收入，2:支出，0:全部，
 *  @param complete 成功回调
 */
- (void)getRebateInfoWithType:(NSInteger)type complete:(completeBlock)complete;
@end
