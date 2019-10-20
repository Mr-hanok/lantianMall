//
//  WalletValueCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseTableViewCell.h"
@protocol WalletValueCellDelegate <NSObject>
@optional
/**
 *  点击明细
 */
- (void)walletValueViewDetails;
/**
 *  点击积分商城
 */
- (void)walletValuePointsShop;
/**点击积分商城*/
- (void)clickIntegralDetailBtn;
@end

@interface WalletValueCell : BaseTableViewCell
@property (nonatomic , weak) id <WalletValueCellDelegate> delegate;

/**
 *  加载数据
 *
 *  @param title   <#title description#>
 *  @param value   <#value description#>
 *  @param details <#details description#>
 */
- (void)loadTitle:(NSString *)title value:(CGFloat)value isViewDetails:(BOOL)details;

- (void)loadPointsTitle:(NSString *)title value:(CGFloat)value;
@end
