//
//  MessageTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (void)awakeFromNib {
    self.badegvalueLabel.layer.cornerRadius = 10;
    self.badegvalueLabel.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
