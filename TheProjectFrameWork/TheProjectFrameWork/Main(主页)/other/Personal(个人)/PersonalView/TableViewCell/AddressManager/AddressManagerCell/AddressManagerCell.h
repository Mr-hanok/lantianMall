//
//  AddressManagerCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  地址管理页面 cell

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
@class AddressModel,AddressManagerCell;
@protocol AddressManagerCellDelegate <NSObject>

@optional
/**
 *  设置是否默认
 */
- (void)addressManagerIsDefaultWithCell:(AddressManagerCell *)cell;
/**
 *  点击编辑
 */
- (void)addressManagerEditWithCell:(AddressManagerCell *)cell;
/**
 *  点击删除
 */
- (void)addressManagerDeleteWithCell:(AddressManagerCell *)cell;
@end
@interface AddressManagerCell : BaseTableViewCell
@property (nonatomic , strong) AddressModel * model; ///< 地址管理数据模型
@property (nonatomic , strong) NSIndexPath * indexPath;
@property (nonatomic , weak) id <AddressManagerCellDelegate> delegate;
@property (nonatomic , assign) BOOL isDefault;
@end
