//
//  BuyAndSendTouristsTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BuyAndSendTouristsTableViewCell.h"

@implementation BuyAndSendTouristsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.adresslabel.text = LaguageControl(@"快去创建收货地址吧");
}
@end
