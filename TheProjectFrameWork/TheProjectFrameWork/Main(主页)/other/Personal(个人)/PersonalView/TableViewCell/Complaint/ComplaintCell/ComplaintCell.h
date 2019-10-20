//
//  ComplaintCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseSpaceTableViewCell.h"
@class ComplaintModel,ComplaintCell;

@protocol ComplaintCellDelegate <NSObject>
- (void)complaintCancel:(ComplaintCell *)cell;
@end
@interface ComplaintCell : BaseSpaceTableViewCell
@property (nonatomic , strong) ComplaintModel * model;
@property (nonatomic , weak) UIView * lastView;
@property (nonatomic , weak) id <ComplaintCellDelegate> delegate;

@end
