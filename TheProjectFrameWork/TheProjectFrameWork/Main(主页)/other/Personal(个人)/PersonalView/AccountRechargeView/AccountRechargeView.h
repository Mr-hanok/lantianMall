//
//  AccountRechargeView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RechargeTypePopView.h"
@class AccountRechargeTypeView;
@interface AccountRechargeView : UIView
@property (nonatomic , weak) UILabel * titleLabel;

@end


@protocol AccountRechargeTypeViewDelegate <NSObject>

- (void)accountRechargeTypeSelectWithView:(AccountRechargeTypeView *)view;

@end

@interface AccountRechargeTypeView : AccountRechargeView<RechargeTypePopViewDelegate>
@property (nonatomic , weak) id <AccountRechargeTypeViewDelegate> delegate;
@property (nonatomic , copy) NSString * content;

@end


@interface AccountRechargeMoneyView : AccountRechargeView
@property (nonatomic , assign) double value;
@end


@interface AccountRechargeRemarkView : AccountRechargeView
@property (nonatomic , copy) NSString *value;
@end
