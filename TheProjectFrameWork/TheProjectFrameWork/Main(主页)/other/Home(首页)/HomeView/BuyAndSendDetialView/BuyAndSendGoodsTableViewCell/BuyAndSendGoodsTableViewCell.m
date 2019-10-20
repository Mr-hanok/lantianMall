//
//  BuyAndSendGoodsTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BuyAndSendGoodsTableViewCell.h"

@implementation BuyAndSendGoodsTableViewCell

- (void)awakeFromNib {
    
    self.goodsImageView.layer.masksToBounds = YES;
    self.goodsImageView.layer.cornerRadius = 5;
    self.goodsImageView.layer.borderWidth =1;
    self.goodsImageView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
