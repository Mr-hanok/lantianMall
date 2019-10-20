//
//  PopNumberTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PopNumberTableViewCell.h"
#import "ShoppingButtonView.h"

@interface PopNumberTableViewCell ()<ShoppingButtonViewDelegate>

@end

@implementation PopNumberTableViewCell

- (void)awakeFromNib
{
    self.shoppingButtonView =[ShoppingButtonView loadShoppingButtonViewWithShoppingNumber:1 frame:self.goodsNumberView.bounds];
    self.shoppingButtonView.delegate = self;
    [self.goodsNumberView addSubview:self.shoppingButtonView];
    // Initialization code
}
-(void)loadData:(id)model
{
     NSString * str =model;
    [self.shoppingButtonView SetTheGoodsNumber:[str integerValue]];
}
-(void)loadDataGoodsNumber:(NSInteger)number andCollectionNumber:(NSInteger)collectionnumber
{
    [self.shoppingButtonView SetGoodsDetialNumber:number andCollection:collectionnumber];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)shoppingNumberChangeedvalue:(NSInteger)number
{
    if ([self.delegate respondsToSelector:@selector(numberOfgoods:)])
    {
        [self.delegate numberOfgoods:number];
    }
}

@end
