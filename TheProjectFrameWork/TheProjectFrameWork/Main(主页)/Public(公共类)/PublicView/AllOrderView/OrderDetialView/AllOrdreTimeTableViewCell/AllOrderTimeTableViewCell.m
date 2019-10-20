//
//  AllOrderTimeTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AllOrderTimeTableViewCell.h"

@implementation AllOrderTimeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.PlacetheOrderLabel.text = LaguageControlAppend(@"下单时间");
    self.ClinchadealthetimeLabel.text = LaguageControlAppend(@"成交时间");
    self.payTimeLabel.text = LaguageControlAppend(@"支付时间");
    self.InvoiceNoLabel.text = LaguageControlAppend(@"发票号");
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
