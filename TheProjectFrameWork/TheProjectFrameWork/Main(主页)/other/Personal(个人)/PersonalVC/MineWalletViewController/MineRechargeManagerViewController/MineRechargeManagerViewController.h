//
//  MineRechargeManagerViewController.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/14.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"
/**
 *  充值管理
 */
@interface MineRechargeManagerViewController : LeftViewController
@property (nonatomic , assign) NSInteger role; ///< 1 买家,2 卖家

@end



@protocol RechargeEditViewDelegate <NSObject>

@optional
- (void)rechargeEditCancel; ///< 取消
- (void)rechargeEditDelete; ///< 删除

@end
/**
 *  编辑操作视图
 */
@interface RechargeEditView : UIView
@property (nonatomic , assign) NSInteger count; ///< 删除数量
@property (nonatomic , weak) id <RechargeEditViewDelegate> delegate;
@end