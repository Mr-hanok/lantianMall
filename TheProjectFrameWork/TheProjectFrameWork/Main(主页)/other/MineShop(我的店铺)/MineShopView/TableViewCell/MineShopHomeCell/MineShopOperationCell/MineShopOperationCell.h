//
//  MineShopOperationCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/2.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineShopBaseCell.h"
@class MineShopOperationCell;
@protocol MineShopOperationCellDelegate <NSObject>
- (void)mineShopOperationCell:(MineShopOperationCell *)cell type:(NSInteger)type;
@end
@interface MineShopOperationCell : MineShopBaseCell
@property (nonatomic , weak) id<MineShopOperationCellDelegate>  delegate;

@end
