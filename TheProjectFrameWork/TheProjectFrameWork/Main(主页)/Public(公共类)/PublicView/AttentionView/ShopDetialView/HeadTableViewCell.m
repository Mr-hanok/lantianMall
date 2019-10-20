//
//  HeadTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/17.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "HeadTableViewCell.h"

@implementation HeadTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.attentButton setTitle:LaguageControl(@"关注") forState:UIControlStateNormal];
    [self.attentButton setTitle:LaguageControl(@"已关注") forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
