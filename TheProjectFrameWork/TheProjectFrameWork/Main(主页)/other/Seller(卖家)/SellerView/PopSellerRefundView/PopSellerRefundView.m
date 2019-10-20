//
//  PopSellerRefundView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/9/21.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PopSellerRefundView.h"

@implementation PopSellerRefundView


+(id)loadView
{
    PopSellerRefundView * view = [super loadView];
    view.titlelabel.text = LaguageControl(@"您确定要退款给买家？");
    view.ArefundreasonLabel.text = LaguageControlAppend(@"退款原因");
    view.ortherReasonLabel.text = LaguageControl(@"其他原因");
    view.GoodsOutofstockLabel.text =LaguageControl(@"商品缺货");
    view.BuyersAskforArefundLabel.text = LaguageControl(@"买家要求退款");
    view.popView.layer.cornerRadius= 5;
    view.popView.layer.masksToBounds = YES;
    [view.cancelButton setTitle:LaguageControl(@"取消") forState:UIControlStateNormal];
    [view.confirmButton setTitle:LaguageControl(@"确定") forState:UIControlStateNormal];

    return view;
}
-(void)ShowViewWith:(NSString*)string with:(NSString*)orderNUmber
{
    self.orderID = string;
    self.orderNumber.text = LaguageControlAppendStrings(@"订单号", orderNUmber);
    [self performSelector:@selector(goodsoutOfButtonClicked:) withObject:self.goodsoutofButton];
    [self showView];

}

-(void)GetBlcokInfo:(PopSellerBlock)block
{
    self.block = block;
}
-(void)showView
{
    [KeyWindow addSubview:self];
    self.otherReasonTextView.alpha = 0;
    self.frame =kScreenFreameBound;
    self.popView.center = CGPointMake(KScreenBoundWidth/2, KScreenBoundHeight*2);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.popView.center = CGPointMake(KScreenBoundWidth/2, KScreenBoundHeight/2);
    } completion:^(BOOL finished)
     {
    }];
}
-(void)viewDissMissFromWindow{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, KScreenBoundHeight, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}
/** 其他原因 */
- (IBAction)otherReasonButtonClicked:(UIButton *)sender
{
    sender.selected = YES;
    self.goodsoutofButton.selected = NO;
    self.buyerAskButton.selected = NO;
    self.otherReasonTextView.alpha = 1;
    self.refunfReason =LaguageControl(@"其他原因");

}
/** 商品缺货 */
- (IBAction)goodsoutOfButtonClicked:(UIButton *)sender
{
    sender.selected = YES;
    self.otherReasonButton.selected = NO;
    self.buyerAskButton.selected = NO;
    self.otherReasonTextView.alpha = 0;
    self.refunfReason =LaguageControl(@"商品缺货");

    
}
/** 买家要求退款 */
- (IBAction)buyerAskButtonClicked:(UIButton *)sender
{
    sender.selected = YES;
    self.goodsoutofButton.selected = NO;
    self.otherReasonButton.selected = NO;
    self.otherReasonTextView.alpha = 0;
    self.refunfReason =LaguageControl(@"买家要求退款");


}
/** 取消按钮 */
- (IBAction)CancelButtonClicked:(UIButton *)sender
{
    [self viewDissMissFromWindow];
}
/** 确认按钮 */
- (IBAction)confirmButtonClicked:(UIButton *)sender
{
    [self NetWork];
}
-(void)NetWork
{
    NSString * string = @"";

    if ([self.refunfReason isEqualToString:LaguageControl(@"其他原因")]) {
        string = self.otherReasonTextView.text;
    }
    [HUDManager showLoadingHUDView:self];
    NSDictionary * dic = @{@"of_id":self.orderID,
                           @"refund_log":string,
                           @"refund_type":self.refunfReason,
                           @"user_id":kUserId};
    [NetWork PostNetWorkWithUrl:@"/buyer/order_accord_refund_save" with:dic successBlock:^(NSDictionary *dic)
     {
         [HUDManager hideHUDView];
         if ([dic[@"status"] boolValue]) {
             if (self.block) {
                 self.block(YES);
             }
         }
         [self viewDissMissFromWindow];

    } errorBlock:^(NSString *error)
    {
        [HUDManager hideHUDView];
        [self viewDissMissFromWindow];
    }];
}


@end
