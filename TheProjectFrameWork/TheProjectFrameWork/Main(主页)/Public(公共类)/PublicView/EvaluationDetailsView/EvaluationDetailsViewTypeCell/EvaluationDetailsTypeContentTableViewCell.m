//
//  EvaluationDetailsTypeContentTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "EvaluationDetailsTypeContentTableViewCell.h"
#import "StarView.h"
#import "GoodsEvaluationModel.h"

@implementation EvaluationDetailsTypeContentTableViewCell

{
    StarView * star ;
    StarView * dectStarView;
}
- (void)awakeFromNib {
    
    if (KScreenBoundWidth>320)
    {
        
    }
    else
    {
        self.evalutaionName.font = KSystemFont(11);
        self.goodsName.font = KSystemFont(11);
        self.goodsName.font = KSystemFont(11);
    }
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width/2;
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
        }];
        [self.starView addSubview:star];
    }
    if (!dectStarView)
    {
        dectStarView = [StarView new];
        dectStarView.frame = self.levelView.bounds;
        dectStarView.backgroundColor = [UIColor clearColor];
        dectStarView.fullImage = [UIImage imageNamed:@"level"];
        dectStarView.backImage = [UIImage imageNamed:@""];
        dectStarView.show_star = 3;
        [dectStarView GetValues:^(float values) {
        }];
        [self.levelView addSubview:dectStarView];

    }
    
      // Initialization code
}
-(void)LoadData:(id)Model
{
    GoodsEvaluationModel * themodel = Model;
    
    CGSize cellSize = [NSString sizeWithString:themodel.userName font:KSystemFont(13) maxHeight:30 maxWeight:KScreenBoundWidth-60];
    self.nameWIdth.constant =cellSize.width;
    self.evalutaionName.text= themodel.userName;
    self.goodsName.text = themodel.evaluateInfo;
    self.evaluationTime.text = [themodel.goods_by_date substringToIndex:11];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:themodel.userAcc]];
    [star Setwidtt:20 minWidth:5 showStar:[themodel.evaluateBuyerVal floatValue]];
    [dectStarView Setwidtt:15 minWidth:5 showStar:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
