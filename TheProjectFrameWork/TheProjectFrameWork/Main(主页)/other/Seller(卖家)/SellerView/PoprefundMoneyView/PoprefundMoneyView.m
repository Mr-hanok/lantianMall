//
//  PoprefundMoneyView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PoprefundMoneyView.h"

@implementation PoprefundMoneyView
+(id)loadView
{
    PoprefundMoneyView * view = [super loadView];
    view.contentView.layer.masksToBounds = YES;
    view.contentView.layer.borderWidth=1;
    view.contentView.layer.cornerRadius=10;
    view.contentView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [view.calcelButton setTitle:LaguageControl(@"取消") forState:UIControlStateNormal];
     [view.confirmButton setTitle:LaguageControl(@"确定") forState:UIControlStateNormal];
    [view.RefundtipsButton setTitle:LaguageControl(@"退款提示") forState:UIControlStateNormal];
    view.RefundDetialButton.text = LaguageControl(@"确定退款给买家");
    
    return view;
}

-(void)showView{
    self.blcok = nil;
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
/**
 *  取消
 *
 *  @param sender <#sender description#>
 */
- (IBAction)cancelButtonClicked:(UIButton *)sender
{
    [self viewDissMissFromWindow];

}

-(void)GetpopInfo:(PopInfoBlock)block{
    self.blcok = block;
}
/**
 *  确认
 *
 *  @param sender <#sender description#>
 */
- (IBAction)confirmButtonClicked:(UIButton *)sender
{
    if (self.blcok) {
        self.blcok(YES);
    }
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
