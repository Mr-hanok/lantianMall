//
//  PopApplyRefund.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PopApplyRefund.h"

@implementation PopApplyRefund

+(id)loadView
{
    PopApplyRefund * view = [super loadView];
    view.contentView.layer.masksToBounds = YES;
    view.contentView.layer.borderWidth=1;
    view.contentView.layer.cornerRadius=10;
    view.contentView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    view.buyerapplyforrefundLabel.text = LaguageControl(@"买家申请退款");
    view.ApplyforinstructionsLabel.text= LaguageControl(@"申请说明");
    [view.agreeButton setTitle:LaguageControl(@"不同意") forState:UIControlStateNormal];
    [view.disAgreeButton setTitle:LaguageControl(@"同意") forState:UIControlStateNormal];

    return view;
}
-(void)ShowView:(NSString*)orderID
{
    self.orderID = orderID;
    [self NetWorkWith];
    [self showView];
    
}
-(void)NetWorkWith
{
    NSDictionary * dic=@{@"of_id":self.orderID};
    [HUDManager showLoadingHUDView:self];
    [NetWork PostNetWorkWithUrl:@"/buyer/buyer_refund_info" with:dic successBlock:^(NSDictionary *dic)
    {
        [HUDManager hideHUDView];
        self.reasonLabel.text= [NSString stringWithFormat:@"%@",dic[@"data"][@"remark"]];
    } errorBlock:^(NSString *error) {
        [HUDManager hideHUDView];
    }];
    
}
-(void)showView
{
    self.isShow = YES;
    [KeyWindow addSubview:self];
    self.frame =kScreenFreameBound;
    self.contentView.center = CGPointMake(KScreenBoundWidth/2, KScreenBoundHeight*2);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.center = CGPointMake(KScreenBoundWidth/2, KScreenBoundHeight/2);
    } completion:^(BOOL finished) {
    }];
}
-(void)tapTheView
{
    
    [self viewDissMissFromWindow];
}
-(void)viewDissMissFromWindow{
    self.isShow = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.center = CGPointMake(KScreenBoundWidth/2, KScreenBoundHeight*2);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}
- (IBAction)cancelClicked:(UIButton *)sender
{
    [self viewDissMissFromWindow];

}
- (IBAction)DontAgreeButtonclicked:(UIButton *)sender
{
    [self viewDissMissFromWindow];
    if (self.block) {
        self.block(NO);
    }

}
- (IBAction)agreeButtonClicked:(UIButton *)sender
{
    [self NetWorkRefound];

}
-(void)GetBlockInfoMation:(PopApplyBlock)block
{
    self.block  = block;
    
    
}
-(void)NetWorkRefound
{
    
    NSDictionary * dic=@{@"of_id":self.orderID,
                         @"user_id":kUserId};
    [HUDManager showLoadingHUDView:self];
    [NetWork PostNetWorkWithUrl:@"/buyer/seller_refund_return_save" with:dic successBlock:^(NSDictionary *dic)
     {
         [HUDManager hideHUDView];
         if ([dic[@"status"] boolValue])
         {
             if (self.block)
             {
                 self.block(YES);
             }
         }
         else
         {
             [HUDManager showWarningWithText:dic[@"message"]];
         }
     } errorBlock:^(NSString *error) {
         [HUDManager hideHUDView];
     }];
    [self viewDissMissFromWindow];


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
