//
//  ClassGoodsCollectionViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/30.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ClassGoodsCollectionViewCell.h"
#import "StarView.h"
#import "ClassGoodsModel.h"

@implementation ClassGoodsCollectionViewCell

{
    StarView * dectStarView;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backView.layer.masksToBounds =YES;
    self.backView.layer.cornerRadius = 5;
    [self.backView.layer setBorderWidth:1];
    self.backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
  
    self.yellowcommentView.alpha = 0;

    // Initialization code
}
-(void)loadData:(id)model withIndex:(NSIndexPath*)indexPath
{   ClassGoodsModel * themodel = model;
    if (!dectStarView) {
        dectStarView = [StarView new];
    }
    dectStarView.frame = self.yellowcommentView.bounds;
    self.payAttentButton.selected= [themodel.favorite boolValue];
    dectStarView.backgroundColor = [UIColor clearColor];
    dectStarView.fullImage = [UIImage imageNamed:@"sxin"];
    dectStarView.backImage = [UIImage imageNamed:@"xing"];
    dectStarView.show_star = [themodel.description_evaluate floatValue];
    dectStarView.isShow = YES;
    [dectStarView setNeedsDisplay];
    [dectStarView GetValues:^(float values) {
    }];
    [self.yellowcommentView addSubview:dectStarView];
    self.index = indexPath;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:themodel.goods_imageUrl] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"defaultImgForGoods"]]];
    
    self.goodsStoreNameLabel.text = themodel.classModelName;

    NSString * price = themodel.storePrice;
//    if ([themodel.goodsPrice floatValue]!=[themodel.storePrice floatValue])
//    {
        NSString * string =[NSString stringWithFormat:@"¥ %@",[themodel.goodsPrice caculateFloatValue]];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:string];
//        [AttributedStr addAttribute:NSStrikethroughStyleAttributeName
//                              value:[NSNumber  numberWithInteger:1]
//                              range:NSMakeRange(0,AttributedStr.length)];
    [AttributedStr addAttributes:@{NSStrikethroughStyleAttributeName:[NSNumber  numberWithInteger:1],NSBaselineOffsetAttributeName     : @(NSUnderlineStyleSingle)} range:NSMakeRange(0,AttributedStr.length)];
    
    if ([themodel.goodsPrice floatValue]==[themodel.storePrice floatValue]){
        self.goodPreferentialpriceLabel.attributedText = AttributedStr;
    }else{
        NSString * str = [NSString caculater:price goodValue:themodel.goodsPrice];
        NSMutableAttributedString *appendString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@",str]];
        [appendString addAttribute:NSForegroundColorAttributeName value:kNavigationColor range:NSMakeRange(0, appendString.length)];
//        [AttributedStr appendAttributedString:appendString];
        self.goodPreferentialpriceLabel.attributedText = AttributedStr;
    }

    
//    }
    
    
//    if (themodel.activity_price.length)
//    {
//        price = themodel.activity_price;
//    }
    self.goodsNameLabel.text = [NSString stringWithFormat:@"¥ %@",[price caculateFloatValue]];
}
- (IBAction)ThumbUpButtonClicked:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(ClassGoodsPayAttentButtonClickedbutton:index:)]) {
        [self.delegate ClassGoodsPayAttentButtonClickedbutton:sender index:self.index];
    }
}

@end
