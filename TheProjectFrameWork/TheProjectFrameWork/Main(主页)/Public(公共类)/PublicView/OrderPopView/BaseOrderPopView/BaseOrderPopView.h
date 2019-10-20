//
//  BaseOrderPopView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/20.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BasePopView.h"
@class BaseOrderPopView;
@protocol BaseOrderPopViewDelegate <NSObject>
- (void)baseOrderPop:(BaseOrderPopView *)view content:(id)content;
@end
@interface BaseOrderPopView : BasePopView
@property (nonatomic , weak) UILabel * titleLabel;
@property (nonatomic , weak) UIButton * cancel;
@property (nonatomic , weak) UIButton * sure;


@property (nonatomic , weak) id <BaseOrderPopViewDelegate> delegate;
/**
 *  点击确定
 */
- (void)sureEvent;
@end
