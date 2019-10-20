//
//  PayAttentionTitleView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/13.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PayAttentionTitleView.h"

@implementation PayAttentionTitleView
+(id)loadView{
    PayAttentionTitleView * view = [super loadView];
    view.goodsButton.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.3];
    if (kIsChiHuoApp) {
        [view.shopButton setTitleColor:kTextDeepDarkColor forState:UIControlStateNormal];
        [view.goodsButton setTitleColor:kTextDeepDarkColor forState:UIControlStateNormal];
    }
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kIsB2cStr]) {
        view.shopButton.hidden= YES;
        view.shopBtnWith.constant = 0;
        
    }

    return view;
}

- (IBAction)buttonClicked:(UIButton *)sender
{
    self.shopButton.backgroundColor = [UIColor clearColor];
    self.goodsButton.backgroundColor = [UIColor clearColor];
    sender.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.3];
    if ([self.delegate respondsToSelector:@selector(PayAttentionTitleViewButtonClicked:)]) {
        [self.delegate PayAttentionTitleViewButtonClicked:sender];
    }
}

- (CGSize)intrinsicContentSize
{
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kIsB2cStr]) {
        return CGSizeMake(90, 40);
    }
    return CGSizeMake(150, 40);
}
@end
