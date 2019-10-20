//
//  MineShopManagerCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineShopBaseCell.h"
@protocol MineShopManagerCellDelegate <NSObject>
- (void)mineShopManagerWithType:(NSInteger)type;
@end
@interface MineShopManagerCell : MineShopBaseCell
@property (nonatomic , weak) id <MineShopManagerCellDelegate> delegate;

@end


