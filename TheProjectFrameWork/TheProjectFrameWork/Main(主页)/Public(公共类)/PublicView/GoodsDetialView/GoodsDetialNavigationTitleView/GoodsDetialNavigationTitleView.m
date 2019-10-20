//
//  GoodsDetialNavigationTitleView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/2.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "GoodsDetialNavigationTitleView.h"

@implementation GoodsDetialNavigationTitleView

+(id)loadView
{
    GoodsDetialNavigationTitleView * view =   [super loadView];
    NSString * goodstitle = [LaguageControl languageWithString:@"商品"];
    NSString * goodsdetialstitle = [LaguageControl languageWithString:@"详情"];
    NSString * committitle = [LaguageControl languageWithString:@"评论"];
    if (KScreenBoundWidth>320)
    {
        view.goodsButton.titleLabel.font = KSystemFont(15);
        view.goodsdetialButton.titleLabel.font = KSystemFont(15);
        view.goodsEvaluation.titleLabel.font = KSystemFont(15);
    }
    else
    {
        view.goodsButton.titleLabel.font = KSystemFont(14);
        view.goodsdetialButton.titleLabel.font = KSystemFont(14);
        view.goodsEvaluation.titleLabel.font = KSystemFont(14);
    }
    [view.goodsButton setTitle:goodstitle forState:UIControlStateNormal];
    [view.goodsdetialButton setTitle:goodsdetialstitle forState:UIControlStateNormal];
    [view.goodsEvaluation setTitle:committitle forState:UIControlStateNormal];

    if (kIsChiHuoApp) {
        [view.goodsButton setTitleColor:kTextDeepDarkColor forState:UIControlStateNormal];
        [view.goodsdetialButton setTitleColor:kTextDeepDarkColor forState:UIControlStateNormal];
        [view.goodsEvaluation setTitleColor:kTextDeepDarkColor forState:UIControlStateNormal];
        view.scrollerView.backgroundColor = kTextDeepDarkColor;

    }
    
    view.goodsButton.tag =1000;
    view.goodsdetialButton.tag = 1001;
    view.goodsEvaluation.tag = 1002;
//    view.goodsButton.selected = YES;
    return view;

}


-(void)setScrollerWith:(NSInteger)Index{
    if (Index==0) {
        if (!self.goodsButton.selected){
            /*
            self.goodsButton.selected = YES;
            self.goodsdetialButton.selected = NO;
            self.goodsEvaluation.selected = NO;
             */
            [UIView animateWithDuration:0.2 animations:^{
                self.scrollerView.center = CGPointMake(self.goodsButton.center.x, self.scrollerView.center.y);
            }];
        }
    }
    else if (Index==1){
        if (!self.goodsdetialButton.selected){
            /*
            self.goodsButton.selected = NO;
            self.goodsdetialButton.selected = YES;
            self.goodsEvaluation.selected = NO;
             */
        }
        [UIView animateWithDuration:0.2 animations:^{
            self.scrollerView.center = CGPointMake(self.goodsdetialButton.center.x, self.scrollerView.center.y);
        }];
    }
    else{
        if (!self.goodsEvaluation.selected){
            /*
            self.goodsButton.selected = NO;
            self.goodsdetialButton.selected = NO;
            self.goodsEvaluation.selected = YES;
             */
            [UIView animateWithDuration:0.2 animations:^{
                self.scrollerView.center = CGPointMake(self.goodsEvaluation.center.x, self.scrollerView.center.y);
            }];
        }
    }
}
- (IBAction)buttonClicked:(UIButton *)sender {
    /*
    self.goodsButton.selected = NO;
    self.goodsdetialButton.selected = NO;
    self.goodsEvaluation.selected = NO;
    sender.selected = !sender.selected;
     */
    [UIView animateWithDuration:0.2 animations:^{
        self.scrollerView.center = CGPointMake(sender.center.x, self.scrollerView.center.y);
    }];
    if ([self.delegate respondsToSelector:@selector(GoodsDetialNavigationTitleViewButtionClicked:)]) {
        [self.delegate GoodsDetialNavigationTitleViewButtionClicked:sender];
    }
}
- (CGSize)intrinsicContentSize {
    return CGSizeMake(201, 40);
}
@end
