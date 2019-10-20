//
//  ClassGoodsVerticalCollectionViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/30.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ClassGoodsVerticalCollectionViewCell.h"
#import "StarView.h"
#import "ClassGoodsModel.h"

@implementation ClassGoodsVerticalCollectionViewCell
{
    StarView * dectStarView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backView.layer.masksToBounds =YES;
    self.backView.layer.cornerRadius = 5;
    [self.backView.layer setBorderWidth:1];
    self.backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.goodStarView.alpha = 0;
    // Initialization code
}
-(void)loadData:(id)model withIndex:(NSIndexPath*)indexPath
{
    ClassGoodsModel * themodel = model;
    self.payAttentButton.selected= [themodel.favorite boolValue];
    if (!dectStarView)
    {
        dectStarView = [StarView new];
        dectStarView.isShow = YES;
        dectStarView.frame = self.goodStarView.bounds;
        dectStarView.backgroundColor = [UIColor clearColor];
        dectStarView.fullImage = [UIImage imageNamed:@"sxin"];
        dectStarView.backImage = [UIImage imageNamed:@"xing"];
    }
    dectStarView.show_star = [themodel.description_evaluate floatValue];
    [dectStarView setNeedsDisplay];
    [dectStarView GetValues:^(float values) {
        NSLog(@"%f",values);
    }];
    [self.goodStarView addSubview:dectStarView];
    self.index = indexPath;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:themodel.goods_imageUrl] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"defaultImgForGoods"]]];
    self.goodstitleLabel.text =themodel.classModelName;
    NSString * price = themodel.storePrice?:themodel.showPrice?:@"" ;

   
        NSString * goodPrice =[NSString stringWithFormat:@"￥ %@", [themodel.goodsPrice caculateFloatValue]];
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc] initWithString:goodPrice];
        NSString * str = [NSString caculater:price goodValue:themodel.goodsPrice];
//        [AttributedStr addAttribute:NSStrikethroughStyleAttributeName
//                              value:[NSNumber  numberWithInteger:1]
//                              range:NSMakeRange(0,AttributedStr.length)];
         [AttributedStr addAttributes:@{NSStrikethroughStyleAttributeName:[NSNumber  numberWithInteger:1],NSBaselineOffsetAttributeName     : @(NSUnderlineStyleSingle)} range:NSMakeRange(0,AttributedStr.length)];
    
    if ([themodel.goodsPrice floatValue]==[themodel.storePrice floatValue])
    {
        self.goodsDetialLabel.attributedText = AttributedStr;

    }else{
        NSMutableAttributedString * appendString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",str]];
        [appendString addAttribute:NSForegroundColorAttributeName value:kNavigationColor range:NSMakeRange(0, appendString.length)];
//        [AttributedStr appendAttributedString:appendString];
        self.goodsDetialLabel.attributedText = AttributedStr;
    }
    
    self.goodsDescriptionLabel.text =[NSString stringWithFormat:@"￥ %@", [price caculateFloatValue]];

    
}
- (IBAction)ThumbUpButtonClicked:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(PayAttentButtonClickedbutton:index:)]) {
        [self.delegate PayAttentButtonClickedbutton:sender index:self.index];
    }
}

@end
