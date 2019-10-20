//
//  PopInformationView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/2.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"
#import <IQTextView.h>
/**卖家发货弹出视图 修改物流弹出视图*/
@interface PopInformationView : BaseView
typedef void(^PopSellerSendBlcok)(BOOL success);

@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property(assign,nonatomic) BOOL isShow;
@property (weak, nonatomic) IBOutlet UIView *logisticsbackView;
@property (weak, nonatomic) IBOutlet UIView *OrdernumberbackView;
@property (weak, nonatomic) IBOutlet UIButton *sendGoodButton;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property(strong,nonatomic) NSString * orderID;

@property(strong,nonatomic) NSString * company;

@property(assign,nonatomic) BOOL ISChange;


@property(strong,nonatomic) NSString * logistNumber;
@property (weak, nonatomic) IBOutlet UILabel *confirmLabel;
@property (weak, nonatomic) IBOutlet UILabel *LogisticsNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *LogisticsCompanyLabel;
@property (weak, nonatomic) IBOutlet UILabel *LogisticsCompany;
/** 物流单号输入框 */
@property (weak, nonatomic) IBOutlet UITextField *logisticsTextField;
@property(copy,nonatomic) PopSellerSendBlcok block;


/**
 *  移除视图
 */
-(void)viewDissMissFromWindow;
/**
 *  显示视图
 */
-(void)showView;
/**
 *  显示视图
 */
-(void)showViewWithModel:(NSString*)orderId;

/** 点击确定回调 */
-(void)GetBlocksWith:(PopSellerSendBlcok)block;
@end
