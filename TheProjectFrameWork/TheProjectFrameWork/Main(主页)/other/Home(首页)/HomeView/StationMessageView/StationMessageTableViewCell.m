//
//  StationMessageTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "StationMessageTableViewCell.h"
#import "NewStationMessageModel.h"

@implementation StationMessageTableViewCell

- (void)awakeFromNib {
    self.goodsDetialImageView.layer.cornerRadius = 5;
    self.goodsDetialImageView.layer.masksToBounds = YES;
    // Initialization code
}
-(void)editCell:(BOOL)isEdit
{
    if (isEdit) {
        self.buttonWidth.constant =50;
    }
    else{
        self.buttonWidth.constant =0;
    }
}

-(void)loadModel:(id) model with:(NSIndexPath*)indexpath show:(BOOL)isSelected
{
    NewStationMessageModel * models = model;
    self.goodsDetialImageView.alpha = 0;
    self.shopTitleLabel.text =[kUserId isEqualToString:models.fromUserId]?models.toUserName:models.fromUserName;
    self.indexPath = indexpath;
    self.contentLabel.text = models.title ?: models.messageContent;
    self.timeLabel.text = models.messageaddtime;
    self.selectButton.selected = isSelected;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(StationMessageTableViewCellButtonSelete:)]) {
        [self.delegate StationMessageTableViewCellButtonSelete:self.indexPath];
    }
    sender.selected = !sender.selected;
}

@end
