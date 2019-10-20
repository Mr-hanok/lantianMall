//
//  OrderTimeTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "OrderTimeTableViewCell.h"

@implementation OrderTimeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.PlacetheorderoftimeLabel.text = LaguageControlAppend(@"下单时间");
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
