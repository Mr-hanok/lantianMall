//
//  RechargeTypePopView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RechargeTypePopViewDelegate <NSObject>
@optional
- (void)RechargeTypePopViewWithType:(NSInteger)type;
@end
@interface RechargeTypePopView : UIView
@property (nonatomic , weak) id <RechargeTypePopViewDelegate> delegate;
/**原来写死的两种支付方式*/
- (void)displayToWindow;
/**待支付宝微信支付方式*/
- (void)displayToWindoWithAliWX:(BOOL)isHaveAliWX;
- (void)removeFromWindow;
-(void)displayToWindoWithConfigType;
@end
