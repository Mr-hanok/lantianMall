//
//  PopSellerRefundView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/9/21.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"

typedef void(^PopSellerBlock)(BOOL Success);

@interface PopSellerRefundView : BaseView

@property (weak, nonatomic) IBOutlet UIView *popView;

@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
/** 退款原因 */
@property (weak, nonatomic) IBOutlet UILabel *ArefundreasonLabel;
/** 其他原因 */
@property (weak, nonatomic) IBOutlet UILabel *ortherReasonLabel;
/** 商品缺货 */
@property (weak, nonatomic) IBOutlet UILabel *GoodsOutofstockLabel;
/** 买家要求退款 */
@property (weak, nonatomic) IBOutlet UILabel *BuyersAskforArefundLabel;
/** 其他原因 */
@property (weak, nonatomic) IBOutlet UIButton *otherReasonButton;
/** 商品缺货 */
@property (weak, nonatomic) IBOutlet UIButton *goodsoutofButton;
/** 买家要求退款 */
@property (weak, nonatomic) IBOutlet UIButton *buyerAskButton;
/** 其他原因 */
@property (weak, nonatomic) IBOutlet UITextField *otherReasonTextView;
/** 取消按钮 */
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
/** 确认按钮 */
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
/** 退款原因 */
@property(strong,nonatomic) NSString * refunfReason;

@property(strong,nonatomic) NSString * orderID;

@property(copy,nonatomic) PopSellerBlock block;


-(void)GetBlcokInfo:(PopSellerBlock)block;


-(void)ShowViewWith:(NSString*)string with:(NSString*)orderNUmber;

/**
 
 *  移除视图
 
 */
-(void)viewDissMissFromWindow;
/**
 
 *  显示视图
 
 */
-(void)showView;
@end
