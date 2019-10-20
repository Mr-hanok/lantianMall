//
//  RechargeFinishViewController.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  支付成功

#import "BaseViewController.h"
@protocol RechargeFinishViewControllerDelegate <NSObject>
@optional
- (void)rechargeFinish;
@end
@interface RechargeFinishViewController : BaseViewController
@property (nonatomic , weak) id <RechargeFinishViewControllerDelegate> delegate;
@property (nonatomic, assign) CGFloat money;
@property (nonatomic , assign) NSInteger type;
@end

@interface RechargeFinishView : UIView
@property (nonatomic , assign) NSInteger type;
@property (nonatomic , assign) CGFloat numberValue;


@end
