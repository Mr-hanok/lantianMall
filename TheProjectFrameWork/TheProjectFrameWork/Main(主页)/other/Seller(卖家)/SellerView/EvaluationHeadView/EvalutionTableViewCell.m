//
//  EvalutionTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "EvalutionTableViewCell.h"

@implementation EvalutionTableViewCell

- (void)awakeFromNib
{
    self.HighpraiseButton.selected = YES;
    self.evaluationTextView.placeholder =LaguageControl( @"输入对买家的评论");
    self.addapointLabel.text = LaguageControl(@"加1分");
    self.noaddapointLabel.text = LaguageControl(@"不加分");
    self.minusonepointsLabel.text = LaguageControl(@"减1分");
    
    [self.HighpraiseButton setTitle:LaguageControl(@"好评") forState:UIControlStateNormal];
    [self.middleButton setTitle:LaguageControl(@"中评") forState:UIControlStateNormal];
    [self.lowButton setTitle:LaguageControl(@"差评") forState:UIControlStateNormal];
    
    // Initialization code
}
- (IBAction)buttonSelected:(UIButton *)sender
{
    sender.selected = !sender.selected;

    if (sender==self.HighpraiseButton)
    {
        self.middleButton.selected = NO;
        self.lowButton.selected = NO;
    }
    else if (sender ==self.middleButton){
        self.HighpraiseButton.selected = NO;
        self.lowButton.selected = NO;
    }
    else{
        self.HighpraiseButton.selected = NO;
        self.middleButton.selected = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
