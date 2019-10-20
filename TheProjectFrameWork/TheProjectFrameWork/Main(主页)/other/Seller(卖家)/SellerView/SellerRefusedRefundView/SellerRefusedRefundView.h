//
//  SellerRefusedRefundView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/9/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"

typedef void(^SellerBlock)(BOOL success);
@interface SellerRefusedRefundView : BaseView
@property (weak, nonatomic) IBOutlet UILabel *desclabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelbtn;
@property (weak, nonatomic) IBOutlet UIButton *surebtn;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UIView *popView;
/** 退款原因 */
@property (weak, nonatomic) IBOutlet UITextField *ReasonTextView;
/** 拒绝回调 */
@property(copy,nonatomic) SellerBlock block;
/** 订单ID */
@property(strong,nonatomic) NSString * orderID;

-(void)viewDissMissFromWindow;
/**
 
 *  显示视图
 
 */
-(void)showView;
/** <#注释#> */
-(void)showViewWith:(NSString*)orderID;
/** 获取回调信息 */
-(void)GetBlockInfo:(SellerBlock)block;

@end
