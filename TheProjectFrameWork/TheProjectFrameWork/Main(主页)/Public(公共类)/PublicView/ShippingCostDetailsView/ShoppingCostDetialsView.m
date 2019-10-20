//
//  ShoppingCostDetialsView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ShoppingCostDetialsView.h"

@implementation ShoppingCostDetialsView
+(id)loadView{
    ShoppingCostDetialsView * view = [super loadView];
    view.costDetialView.layer.masksToBounds = YES;
    view.costDetialView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view.costDetialView.layer.cornerRadius = 10;
    view.goodsImageView.layer.masksToBounds = YES;
    view.goodsImageView.layer.cornerRadius = 5;
    view.goodsImageView.layer.borderWidth =1;
    view.goodsImageView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(tapTheView)];
    [view.tapView addGestureRecognizer:tap];
    return view;
}
-(void)showView{
    self.isShow = YES;
    [KeyWindow addSubview:self];
    self.frame = CGRectZero;
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = (CGRect){0, 0, KScreenBoundWidth, KScreenBoundHeight};
    } completion:^(BOOL finished) {
    }];
}
- (IBAction)cancelButtonClicked:(UIButton *)sender
{
        [self viewDissMissFromWindow];
}
-(void)tapTheView
{
    
//    [self viewDissMissFromWindow];
}
-(void)viewDissMissFromWindow{
    self.isShow = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = (CGRect){0, 0, KScreenBoundWidth,KScreenBoundHeight};
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
