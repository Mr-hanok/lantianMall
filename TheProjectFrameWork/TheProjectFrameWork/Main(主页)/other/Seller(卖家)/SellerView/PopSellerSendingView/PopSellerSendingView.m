//
//  PopSellerSendingView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/9/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PopSellerSendingView.h"

@implementation PopSellerSendingView

-(void)showViewWithString:(NSString*)string
{
    [self showView];
    [self NetWorkWith:string];
    self.preparLabel.text = LaguageControl(@"准备发货");
    self.shippingNumberLabel.text = LaguageControlAppendStrings(@"物流单号",@"");
    self.shipcomparyLabel.text = LaguageControlAppendStrings(@"发货公司",@"");
    [self.confirmButton setTitle:LaguageControl(@"确定") forState:UIControlStateNormal];
    
}
//TODO: 获取平台发货信息
-(void)NetWorkWith:(NSString*)string
{
    NSDictionary * dic =@{@"of_id":string,
                          @"user_id":kUserId};
    self.orderNumberID = string;
    [HUDManager showLoadingHUDView:self];
    [NetWork PostNetWorkWithUrl:@"/seller/order_shipping" with:dic successBlock:^(NSDictionary *dic)
    {
        [HUDManager hideHUDView];
        if ([dic[@"status"] boolValue])
        {
            NSString * string = [NSString stringWithFormat:@"%@",dic[@"data"][@"company"]];
            NSString * number = [NSString stringWithFormat:@"%@",dic[@"data"][@"num"]];
            self.shippingNumberLabel.text = LaguageControlAppendStrings(@"物流单号",number);
            self.shipcomparyLabel.text = LaguageControlAppendStrings(@"发货公司",string);
        }
        else{
            [HUDManager showWarningWithText:dic[@"message"]];
            [self viewDissMissFromWindow];

        }
    } errorBlock:^(NSString *error) {
        [HUDManager hideHUDView];
        [self viewDissMissFromWindow];

    }];
    
}
-(void)showView
{
    [KeyWindow addSubview:self];
    self.frame =kScreenFreameBound;
    self.popView.layer.cornerRadius = 10;
    self.popView.layer.masksToBounds = YES;
    self.confirmButton.layer.cornerRadius = 10;
    self.confirmButton.layer.masksToBounds = YES;
    self.popView.center = CGPointMake(KScreenBoundWidth/2, KScreenBoundHeight*2);
    [UIView animateWithDuration:0.3 animations:^{
        self.popView.center = CGPointMake(KScreenBoundWidth/2, KScreenBoundHeight/2);
    } completion:^(BOOL finished) {
    }];
}
-(void)tapTheView
{
}
- (IBAction)confirmButtonClicked:(UIButton *)sender
{
    [self confirmButtonClicked];
}
/** 修改物流 */
-(void)confirmButtonClicked
{
    NSDictionary * dic = @{@"of_id":self.orderNumberID,
                            @"conpanyId":@"",
                           @"num":@"",
                           @"lineType":@"1",};
    [HUDManager showLoadingHUDView:self];
    __weak PopSellerSendingView * weakself = self;
    [NetWork PostNetWorkWithUrl:@"/changeShippingStatus" with:dic successBlock:^(NSDictionary *dic)
    {
    
        [weakself viewDissMissFromWindow];
        if (weakself.block) {
            weakself.block(YES);
        }
    } errorBlock:^(NSString *error)
    {
        [HUDManager hideHUDView];
        [weakself viewDissMissFromWindow];
        [HUDManager showWarningWithText:@"提交失败"];
        if (weakself.block)
        {
            weakself.block(NO);
        }
    }];
    
}

-(void)GetBlocksWith:(PopSellerSendBlcok)block
{
    self.block = block;
}
-(void)viewDissMissFromWindow
{
    [UIView animateWithDuration:0.2 animations:^{
        self.popView.center = CGPointMake(KScreenBoundWidth/2, KScreenBoundHeight*2);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
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
