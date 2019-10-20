//
//  NoSuccessConstTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/2.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "NoSuccessConstTableViewCell.h"

@implementation NoSuccessConstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.PlacetheorderoftimeLabel.text  =LaguageControlAppend(@"下单时间");
    self.InvoicenoLabel.text = LaguageControlAppend(@"发票号");
    self.PaymenttimeLabel.text = LaguageControlAppend(@"支付时间");
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
