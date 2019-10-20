//
//  MineOrderCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
@protocol MineOrderCellDelegate <NSObject>
@optional
- (void)mineOrderStatus:(SellerOrderTypes)status; ///< 卖家
- (void)buyerOrderStatus:(OrderTypes)status; ///< 买家
@end
@interface MineOrderCell : BaseTableViewCell

@property (nonatomic , weak) id <MineOrderCellDelegate> delegate;
- (void)loadOrderStatus;
@end
