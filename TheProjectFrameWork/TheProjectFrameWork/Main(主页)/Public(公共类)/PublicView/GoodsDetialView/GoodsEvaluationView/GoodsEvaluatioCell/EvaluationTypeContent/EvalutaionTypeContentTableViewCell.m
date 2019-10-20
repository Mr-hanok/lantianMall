//
//  EvalutaionTypeContentTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "EvalutaionTypeContentTableViewCell.h"
#import "StarView.h"
#import "GoodsEvaluationModel.h"

@implementation EvalutaionTypeContentTableViewCell
{
    StarView * star;
    StarView * dectStarView;
}
- (void)awakeFromNib
{
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width/2;
    if (KScreenBoundWidth>320)
    {
        
    }
    else
    {
        self.goodsNameLabel.font = KSystemFont(11);
        self.timeLabel.font = KSystemFont(11);
        self.evalutationDetailLabel.font = KSystemFont(11);
        self.buyTimeLabel.font = KSystemFont(11);
    }
    if (!star) {
        star = [StarView new];
        star.backgroundColor = [UIColor clearColor];
        star.frame = self.starView.bounds;
        star.width = 20 ;
        star.height = 20 ;
        star.fullImage = [UIImage imageNamed:@"xuanzhouxingxing"];
        star.backImage = [UIImage imageNamed:@"weixuanzhongxingxing"];
        star.show_star = 4;
        [star GetValues:^(float values) {
            NSLog(@"%f",values);
        }];
        [self.starView addSubview:star];
    }
    if (!dectStarView) {
        dectStarView = [StarView new];
        dectStarView.frame = self.levelView.bounds;
        dectStarView.backgroundColor = [UIColor clearColor];
        dectStarView.fullImage = [UIImage imageNamed:@"level"];
        dectStarView.backImage = [UIImage imageNamed:@""];
        dectStarView.show_star = 3;
        [dectStarView GetValues:^(float values) {
            NSLog(@"%f",values);
        }];
        [self.levelView addSubview:dectStarView];
    }
       // Initialization code
}
- (IBAction)ThumbupButton:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(EvalutaionTypeContentTableViewCellthumbUpButton:WithIndexPath:)])
    {
        [self.delegate EvalutaionTypeContentTableViewCellthumbUpButton:sender WithIndexPath:self.indexPath];
    }
    sender.selected = !sender.selected;
}
-(void)LoadData:(id)model WithIndexPath:(NSIndexPath*)indexPath
{
    GoodsEvaluationModel * themodel = model;
    CGSize cellSize = [NSString sizeWithString:themodel.userName font:KSystemFont(13) maxHeight:30 maxWeight:KScreenBoundWidth-60];
    self.nameLabelwidth.constant =cellSize.width;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:themodel.userAcc]];
    self.nameLabel.text = themodel.userName;
    self.timeLabel.text = themodel.addTime;
    self.evalutationDetailLabel.text = themodel.evaluateInfo?:@"";
    self.goodsNameLabel.text = themodel.goods_spec;
    self.buyTimeLabel.text = themodel.goods_by_date;
    [star Setwidtt:20 minWidth:5 showStar:[themodel.evaluateBuyerVal floatValue]];
    [dectStarView Setwidtt:15 minWidth:5 showStar:1];
    self.indexPath = indexPath;

}

- (IBAction)evalutionButton:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(EvalutaionTypeContentTableViewCellEvaluationClickedWithIndexPath:)])
    {
        [self.delegate EvalutaionTypeContentTableViewCellEvaluationClickedWithIndexPath:self.indexPath];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
