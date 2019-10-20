//
//  MyWalletPayTypeTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MyWalletPayTypeTableViewCell.h"

@implementation MyWalletPayTypeTableViewCell

- (void)awakeFromNib
{
    self.selectedButton.userInteractionEnabled = NO;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    self.selectedButton.selected = selected;
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectedButtonClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

@end
