//
//  DefaultTableViewCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/30.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
@class AccountCellModel;
@interface DefaultTableViewCell : BaseTableViewCell
@property (nonatomic , copy) NSString * title;
@property (nonatomic , copy) NSString * prompt;
@property (nonatomic , assign) double value;
@property (nonatomic , assign) BOOL isAccessory;
@property (nonatomic , assign) BOOL alignment;
- (void)loadWithModel:(AccountCellModel *)model;
- (void)loadWithTitle:(NSString *)title;
@end
