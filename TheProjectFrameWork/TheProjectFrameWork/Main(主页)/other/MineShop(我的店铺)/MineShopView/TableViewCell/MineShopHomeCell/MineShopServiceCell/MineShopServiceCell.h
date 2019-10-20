//
//  MineShopServiceCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/2.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineShopBaseCell.h"
@protocol MineShopServiceCellDelegate <NSObject>
- (void)mineShopServiceWithType:(NSInteger)type;
@end
@interface MineShopServiceCell : MineShopBaseCell
@property (nonatomic , weak) id <MineShopServiceCellDelegate> delegate;

@end
