//
//  ShoppingHeadView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ShoppingHeadView.h"
#import "CartShopModel.h"

@implementation ShoppingHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)loadDataWith:(id)model andsection:(NSInteger)section
{
    CartShopModel * models = model;
    self.shopNameLabel.text = models.storeName;
    self.section = section;
}
- (IBAction)selectedButtonClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(ShoppingHeadViewDidSelected: with:)]) {
        [self.delegate ShoppingHeadViewDidSelected:self.section with:sender];
    }
}
- (IBAction)lookDetialButton:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(ShoppingHeadViewLookDetialSelected:)]) {
        [self.delegate ShoppingHeadViewLookDetialSelected:self.section];
    }
}

@end
