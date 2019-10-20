//
//  DistributionTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "DistributionTableViewCell.h"

@implementation DistributionTableViewCell

- (void)awakeFromNib {
    self.distributionLabel.text = [LaguageControl languageWithString:@"配送方式"];
    self.deliverytimeLabel.text = [LaguageControl languageWithString:@"配送时间"];
    self.normaldeliveryLabel.text = [LaguageControl languageWithString:@"配送时间"];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
