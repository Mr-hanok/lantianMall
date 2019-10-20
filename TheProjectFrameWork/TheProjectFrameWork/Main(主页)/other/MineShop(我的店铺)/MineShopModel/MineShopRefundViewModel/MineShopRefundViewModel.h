//
//  MineShopRefundViewModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/16.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ShopRefundModel;
typedef void(^completeBlock) (id error);
@interface MineShopRefundViewModel : NSObject
@property (nonatomic , strong) NSMutableArray<ShopRefundModel *> * refundList;
- (void)getMineShopRefundDataCompleteHandle:(completeBlock)block;
- (void)getPageShopRefundDataCompleteHandle:(completeBlock)block;
@end
