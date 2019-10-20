//
//  PopLogisticsView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PopLogisticsView.h"

@interface PopLogisticsView ()<UITextViewDelegate>

@end

@implementation PopLogisticsView
+(id)loadView
{
    PopLogisticsView * view = [super loadView];
    view.descrpTextView.delegate = view;
    view.contentView.layer.masksToBounds = YES;
    view.contentView.layer.borderWidth=1;
    view.contentView.layer.cornerRadius=10;
    view.contentView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    view.orderNumerView.layer.masksToBounds = YES;
    view.orderNumerView.layer.cornerRadius=3;
    view.orderNumerView.layer.borderWidth=0.5;
    view.orderNumerView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    view.operationView.layer.masksToBounds = YES;
    view.operationView.layer.borderWidth=0.5;
    view.operationView.layer.cornerRadius=3;
    view.operationView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    view.sendGoodButton.layer.masksToBounds = YES;
    view.sendGoodButton.layer.cornerRadius=3;
    view.logisticsnumberLabel.text = LaguageControl(@"物流单号");
    view.orderNumberLabel.text = LaguageControlAppend(@"订单号");
    view.ModifythelogisticsLabel.text = LaguageControl(@"准备发货");
    [view.sendGoodButton setTitle:LaguageControl(@"发货") forState:UIControlStateNormal];
    
    return view;
}

-(void)showView
{
    self.descrpTextView.placeholder = @"操作说明";
    if (self.isChange) {
        self.ModifythelogisticsLabel.text = LaguageControl(@"修改物流");
    }
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
 *  <#Description#>
 *
 *  @param sender <#sender description#>
 */
- (IBAction)cancelClicked:(UIButton *)sender
{
    [self viewDissMissFromWindow];

}

#pragma mark --UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.center = CGPointMake(self.center.x, self.center.y-textView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.center = CGPointMake(KScreenBoundWidth/2, KScreenBoundHeight/2);
    } completion:^(BOOL finished) {
        
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
