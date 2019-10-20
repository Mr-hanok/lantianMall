//
//  PromotionGoodsTableViewCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseTableViewCell.h"
@class PromotionGoodsTableViewCell,PromotionGoodsModel;
@protocol PromotionGoodsTableViewCellDelegate <NSObject>

- (void)promotionGoodsCell:(PromotionGoodsTableViewCell *)cell;

@end
@interface PromotionGoodsTableViewCell : BaseTableViewCell
@property (nonatomic , weak) id <PromotionGoodsTableViewCellDelegate> delegate;

@property (nonatomic , strong) PromotionGoodsModel * model;
@end
