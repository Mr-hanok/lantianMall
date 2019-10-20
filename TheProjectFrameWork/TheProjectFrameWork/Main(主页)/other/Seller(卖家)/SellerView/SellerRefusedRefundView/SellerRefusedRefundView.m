//
//  SellerRefusedRefundView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/9/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "SellerRefusedRefundView.h"

@implementation SellerRefusedRefundView

-(void)showViewWith:(NSString*)orderID
{
    self.orderID = orderID;
    [self showView];
    
}
-(void)showView
{
    [KeyWindow addSubview:self];
    self.frame =kScreenFreameBound;
    self.popView.center = CGPointMake(KScreenBoundWidth/2, KScreenBoundHeight*2);
    self.titlelabel.text = LaguageControl(@"拒绝退款");
    self.desclabel.text = LaguageControl(@"请填写拒绝退款原因:");
    [self.cancelbtn setTitle:LaguageControl(@"取消") forState:UIControlStateNormal];
    [self.surebtn setTitle:LaguageControl(@"确定") forState:UIControlStateNormal];
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
-(void)GetBlockInfo:(SellerBlock)block
{
    self.block = block;
    
}
/** 取消 */
- (IBAction)cancelButtonClicked:(UIButton *)sender
{
    [self viewDissMissFromWindow];
}
/** 确定 */
- (IBAction)confirmButtonClicked:(UIButton *)sender
{
    if (self.ReasonTextView.text.length) {
        
    }
    if (self.ReasonTextView.text)
    {
        [self NetWork];
    }
}
-(void)NetWork
{
    [HUDManager showLoadingHUDView:self];
    __weak SellerRefusedRefundView * weakself = self;
    NSDictionary *dic=@{@"of_id":self.orderID,
                        @"content":self.ReasonTextView.text,
                        @"user_id":kUserId};
    [NetWork PostNetWorkWithUrl:@"/buyer/seller_refuse_refund_save" with:dic successBlock:^(NSDictionary *dic)
    {
        [HUDManager hideHUDView];
        if (self.block)
        {
            self.block(YES);
        }
        [weakself viewDissMissFromWindow];

    } errorBlock:^(NSString *error) {
        [HUDManager hideHUDView];
        [weakself viewDissMissFromWindow];

    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
