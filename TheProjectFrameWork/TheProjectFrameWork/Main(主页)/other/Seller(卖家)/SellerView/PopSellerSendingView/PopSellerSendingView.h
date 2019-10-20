//
//  PopSellerSendingView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/9/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"

typedef void(^PopSellerSendBlcok)(BOOL success);

@interface PopSellerSendingView : BaseView

@property (weak, nonatomic) IBOutlet UIView *popView;

@property (weak, nonatomic) IBOutlet UILabel *preparLabel;

@property (weak, nonatomic) IBOutlet UILabel *shippingNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *shipcomparyLabel;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@property(strong,nonatomic) NSString * orderNumberID;

@property(copy,nonatomic) PopSellerSendBlcok block;

/**
 
 *  移除视图
 
 */
-(void)viewDissMissFromWindow;
/**
 
 *  显示视图
 
 */
-(void)showViewWithString:(NSString*)string;

/** 点击确定回调 */
-(void)GetBlocksWith:(PopSellerSendBlcok)block;

@end
