//
//  PopApplyRefund.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"

typedef void(^PopApplyBlock)(BOOL success);
@interface PopApplyRefund : BaseView
/** 不同意 */
@property (weak, nonatomic) IBOutlet UIButton *disAgreeButton;
/** 同意 */
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
/** 申请说明 */
@property (weak, nonatomic) IBOutlet UILabel *ApplyforinstructionsLabel;
/** 买家申请退款 */
@property (weak, nonatomic) IBOutlet UILabel *buyerapplyforrefundLabel;
@property (weak, nonatomic) IBOutlet UILabel *reasonLabel;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property(copy ,nonatomic) PopApplyBlock block;



@property(assign,nonatomic) BOOL isShow;

/** 商品ID */
@property(strong,nonatomic) NSString * orderID;

/** 获取信息 */
-(void)GetBlockInfoMation:(PopApplyBlock)block;

/**
 *  移除视图
 */
-(void)viewDissMissFromWindow;
/**
 *  显示视图
 */
-(void)showView;

-(void)ShowView:(NSString*)orderID;
@end
