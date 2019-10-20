//
//  RefundDetailsCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/9/13.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseSpaceTableViewCell.h"
#import "BaseTableViewCell.h"
@class RefundDetailDerailModel;
@interface RefundAmountCell : BaseTableViewCell

@property (nonatomic , copy) NSString * amount;

@end

@interface RefundDetailsCell : BaseSpaceTableViewCell
@property (nonatomic , strong) RefundDetailDerailModel * model;
@end
