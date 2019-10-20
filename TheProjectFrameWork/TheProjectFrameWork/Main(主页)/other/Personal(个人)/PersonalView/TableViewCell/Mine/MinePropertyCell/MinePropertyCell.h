//
//  MinePropertyCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/30.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
@protocol MinePropertyCellDelegate <NSObject>
@optional
- (void)minePropertyClickEventWithIndex:(NSInteger)tag;
- (void)minePropertyIntegralMallClickEvent;
@end
@interface MinePropertyCell : BaseTableViewCell
@property (nonatomic , weak) id <MinePropertyCellDelegate> delegate;

- (void)loadWithModel:(id)model;
@end
