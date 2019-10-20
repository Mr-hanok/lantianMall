//
//  PropertyView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PropertyView : UIView
@property (nonatomic , assign) double value;

@end

@protocol PropertyBalanceViewDelegate <NSObject>
@optional
/**
 *  点击充值
 */
- (void)propertyBalanceRechargeWithTag:(NSInteger)tag;

@end
/**
 *  用户余额
 */
@interface PropertyBalanceView : PropertyView
@property (nonatomic , weak) id <PropertyBalanceViewDelegate> delegate;
@property (nonatomic , copy) NSString * title;
@property (nonatomic , weak) NSString * accessTitle;

- (instancetype)initWithFrame:(CGRect)frame withTyep:(NSInteger )type;
@end
/**
 *  返利金额
 */
@interface PropertyRebateView : PropertyView

@end
