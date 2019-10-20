//
//  GoodDescriptionTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "GoodDescriptionTableViewCell.h"

@implementation GoodDescriptionTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.goodsPriceLabel.textColor = kNavigationColor;
    self.activitylable.textColor = kNavigationColor;
    self.activityDesLabel.textColor = kNavigationColor;
}
-(void)LoadData:(id)model
{
    self.goodsNameLabel.text = @"";
    self.goodsPriceLabel.text = @"";
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
