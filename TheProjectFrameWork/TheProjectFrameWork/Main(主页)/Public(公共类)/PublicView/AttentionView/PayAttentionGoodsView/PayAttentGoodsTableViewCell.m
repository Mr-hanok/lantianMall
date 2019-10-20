//
//  PayAttentGoodsTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/13.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "PayAttentGoodsTableViewCell.h"
#import "StarView.h"
#import "AttentGoodsModel.h"

@implementation PayAttentGoodsTableViewCell
{
   StarView * dectStarView;
}

- (void)awakeFromNib {
    self.addShopCartButton.layer.masksToBounds = YES;
    self.addShopCartButton.layer.cornerRadius = 5;
    self.addShopCartButton.layer.borderColor = [UIColor lightGrayColor].CGColor
    ;
    if (!dectStarView) {
        dectStarView = [StarView new];
        dectStarView.frame = self.StarView.bounds;
        dectStarView.backgroundColor = [UIColor clearColor];
        dectStarView.fullImage = [UIImage imageNamed:@"level"];
        dectStarView.backImage = [UIImage imageNamed:@""];
        dectStarView.show_star = 4;
        [self.StarView addSubview:dectStarView];

    }
}
-(void)loadDateWith:(id)model andindex:(NSIndexPath*)indexPath
{
    [self.addShopCartButton setTitle:LaguageControl(@"加入购物车") forState:UIControlStateNormal];

    AttentGoodsModel * models= model;
    self.goodsDescriptionLabel.text = models.attentgoods_name;
    self.goodsPricesLabel.text = [NSString stringWithFormat:@"￥ %@", models.attentstore_price];
    NSString * price = [NSString stringWithFormat:@"￥ %@", models.attentgoods_price];

    if (models.attentgoods_price) {
        
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:price];
        [AttributedStr addAttribute:NSStrikethroughStyleAttributeName
                              value:[NSNumber  numberWithInteger:1]
                              range:NSMakeRange(0,AttributedStr.length)];
        NSString * str = [NSString caculater:models.attentstore_price goodValue:models.attentgoods_price];
        NSMutableAttributedString *appendString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@",str]];
        [appendString addAttribute:NSForegroundColorAttributeName value:kNavigationColor range:NSMakeRange(0, appendString.length)];
        [AttributedStr appendAttributedString:appendString];
        if ([models.attentgoods_price floatValue]!=[models.attentstore_price floatValue]) {
            self.storePriceLabel.attributedText = AttributedStr;
        }
        else{
            self.storePriceLabel.attributedText = [NSAttributedString new];
        }
    }
    [dectStarView Setwidtt:15 minWidth:5 showStar:[models.attentgoodsdescription_evaluate floatValue]];
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:models.attentgoods_main_photo] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
    self.indexPath = indexPath;
    
}
/** 删除 */
- (IBAction)delegateButton:(UIButton *)sender
{
    if ([self.deleagate respondsToSelector:@selector(AttentionView:withIndexPath:)]) {
        [self.deleagate AttentionView:self withIndexPath:self.indexPath];
    }
    
    
}
/** 添加购物车 */

- (IBAction)addShopCart:(UIButton *)sender
{    if ([self.deleagate respondsToSelector:@selector(AttentionViewAddShopCart:withIndexPath:)]) {
    [self.deleagate AttentionViewAddShopCart:self withIndexPath:self.indexPath];
}
    
}
- (IBAction)shareButtonClicked:(UIButton *)sender
{
    if ([self.deleagate respondsToSelector:@selector(AttentionViewShareButton:withIndexPath:)]) {
        [self.deleagate AttentionViewShareButton:self withIndexPath:self.indexPath];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
