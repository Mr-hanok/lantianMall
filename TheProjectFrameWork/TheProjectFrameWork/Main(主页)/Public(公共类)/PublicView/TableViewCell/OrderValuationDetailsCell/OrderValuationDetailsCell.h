//
//  OrderValuationDetailsCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/9/19.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseTableViewCell.h"
@class OrdereValuationDetailsModel,OrdereValuationGoodsModel;
@interface OrderValuationDetailsCell : BaseTableViewCell

@property (nonatomic , weak) OrdereValuationDetailsModel * model;

@end


@interface OrderValuationInfoCell : BaseTableViewCell

@property (nonatomic , weak) OrdereValuationGoodsModel * model;

@end
