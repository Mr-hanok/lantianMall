//
//  PopLogisticsView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"
#import <IQTextView.h>

@interface PopLogisticsView : BaseView
/** 修改物流 */
@property (weak, nonatomic) IBOutlet UILabel *ModifythelogisticsLabel;
/** 订单号 */
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
/** 物流单号 */
@property (weak, nonatomic) IBOutlet UILabel *logisticsnumberLabel;

@property (weak, nonatomic) IBOutlet UIView *orderNumerView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *operationView;
@property (weak, nonatomic) IBOutlet UIButton *sendGoodButton;
@property (weak, nonatomic) IBOutlet IQTextView *descrpTextView;
@property(assign,nonatomic) BOOL isChange;
@property(assign,nonatomic) BOOL isShow;
/**
 *  移除视图
 */
-(void)viewDissMissFromWindow;
/**
 *  显示视图
 */
-(void)showView;
@end
