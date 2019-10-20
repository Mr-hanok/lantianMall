//
//  AddressRegionCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
@class AddressRegionCell;
@protocol AddressRegionCellDelegate <NSObject>
@optional
- (void)addressRegionClick:(AddressRegionCell *)cell;
@end
@interface AddressRegionCell : BaseTableViewCell

@property (nonatomic , weak) id <AddressRegionCellDelegate> delegate;
@property (nonatomic , copy) NSString * country;

@end
