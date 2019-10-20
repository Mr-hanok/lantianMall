//
//  MyWalletSettleMentButtonTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MyWalletSettleMentButtonTableViewCell.h"

@implementation MyWalletSettleMentButtonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.confirmPayButton.layer.cornerRadius = 25;
    self.confirmPayButton.backgroundColor = KAppRootNaVigationColor;
    [self.confirmPayButton setTitle:LaguageControl(@"确认付款") forState:UIControlStateNormal];
    self.confirmPayButton.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)confirmPayButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(MyWalletSettleMentButtonTableViewCellButtonClicked:)]) {
        [self.delegate MyWalletSettleMentButtonTableViewCellButtonClicked:sender];
    }
}

@end
