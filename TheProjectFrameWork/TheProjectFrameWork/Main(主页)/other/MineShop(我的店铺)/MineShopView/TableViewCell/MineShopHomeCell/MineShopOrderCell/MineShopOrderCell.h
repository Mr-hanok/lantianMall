//
//  MineShopOrderCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseTableViewCell.h"
@protocol MineShopOrderCellDelegate <NSObject>
- (void)mineShopOrderWithType:(SellerOrderTypes)type;
@end
@interface MineShopOrderCell : BaseTableViewCell
@property (nonatomic , weak) id <MineShopOrderCellDelegate> delegate;

@end
