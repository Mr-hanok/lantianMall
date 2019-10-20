//
//  NewPayAttentGoodsTableViewCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/10/19.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseSpaceTableViewCell.h"
@class AttentGoodsModel;
@class NewPayAttentGoodsTableViewCell;
@protocol NewPayAttentGoodsTableViewCellDelegate <NSObject>

@optional
/**
 *  添加购物车
 */
- (void)payAttentGoodsAddCartWithCell:(NewPayAttentGoodsTableViewCell *)cell;
/**
 *  分享
 */
- (void)payAttentGoodsShareWithCell:(NewPayAttentGoodsTableViewCell *)cell;
/**
 *  删除
 */
- (void)payAttentGoodsDeleteWithCell:(NewPayAttentGoodsTableViewCell *)cell;

@end
@interface NewPayAttentGoodsTableViewCell : BaseSpaceTableViewCell

@property (nonatomic , weak) AttentGoodsModel * model;
@property (nonatomic , assign) NSInteger indexRow;
@property (nonatomic , weak) id <NewPayAttentGoodsTableViewCellDelegate> delegate;

@end
