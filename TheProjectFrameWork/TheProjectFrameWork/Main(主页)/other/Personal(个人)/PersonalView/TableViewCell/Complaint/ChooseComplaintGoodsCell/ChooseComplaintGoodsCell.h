//
//  ChooseComplaintGoodsCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseTableViewCell.h"
@class OrderGoodsModel,ChooseComplaintGoodsCell;
@protocol ChooseComplaintGoodsCellDelegate <NSObject>

- (void)chooseComplaintGoodsCell:(ChooseComplaintGoodsCell *)cell;

@end
@interface ChooseComplaintGoodsCell : BaseTableViewCell

@property (nonatomic , weak) id <ChooseComplaintGoodsCellDelegate> delegate;
@property (nonatomic , assign) NSInteger row;
@property (nonatomic , assign) BOOL goodsSelected;
@property (nonatomic , strong) OrderGoodsModel * model;
@end
