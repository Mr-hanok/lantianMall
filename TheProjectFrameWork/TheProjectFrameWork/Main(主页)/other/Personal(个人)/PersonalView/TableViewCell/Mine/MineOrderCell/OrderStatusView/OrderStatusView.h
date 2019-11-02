//
//  OrderStatusView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OrderStatusViewDelegate <NSObject>
@optional
/**
 *  卖家返回订单类型
 *
 *  @param type <#type description#>
 */
- (void)orderStatusWithType:(SellerOrderTypes)type;
/**
 *  买家返回订单类型
 *
 *  @param type <#type description#>
 */
- (void)buyerStatusWithType:(OrderTypes)type;
@end
@interface OrderStatusView : UIView
@property (nonatomic , weak) id <OrderStatusViewDelegate> delegate;
@property (nonatomic, copy) NSString *countStr;
@property (nonatomic , assign) NSInteger count;
@property (nonatomic , copy) NSString * text;
@property (nonatomic , strong) UIImage * image;
- (instancetype)initWithText:(NSString *)text
                       image:(UIImage *)image;
@end
