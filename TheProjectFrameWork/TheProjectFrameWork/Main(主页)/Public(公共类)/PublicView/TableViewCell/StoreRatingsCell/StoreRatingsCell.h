//
//  StoreRatingsCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseTableViewCell.h"
@class StoreRatingsCell;
@protocol StoreRatingsCellDelegate <NSObject>
- (void)storeRatingsWithCell:(StoreRatingsCell *)cell;
@end
/**
 *  店铺评分
 */
@interface StoreRatingsCell : BaseTableViewCell
@property (nonatomic , weak) id <StoreRatingsCellDelegate> delegate;

@property (nonatomic , assign) CGFloat descriptionMatch; ///< 描述相符
@property (nonatomic , assign) CGFloat deliverySpeed; ///< 发货速度
@property (nonatomic , assign) CGFloat serviceAttitude; ///< 服务态度

@end
