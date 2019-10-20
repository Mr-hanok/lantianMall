//
//  PromotionGoodsTableViewCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PromotionGoodsTableViewCell.h"
#import "PromotionGoodsModel.h"

@implementation PromotionGoodsTableViewCell
{
    UIImageView * goodsImage;
    UILabel * goodsTitle;
    UILabel * currentPrice;
    UILabel * originalPrice;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        goodsImage = [[UIImageView alloc] initWithImage:nil];
        goodsTitle = [[UILabel alloc] init];
        currentPrice = [[UILabel alloc] init];
        originalPrice = [[UILabel alloc] init];
        UIButton * buyNow = [UIButton buttonWithType:UIButtonTypeCustom];
        goodsImage.contentMode = UIViewContentModeScaleAspectFill;
        goodsImage.clipsToBounds = YES;
        goodsTitle.numberOfLines = 2;
        goodsTitle.textColor = [UIColor colorWithString:@"#666666"];
        goodsTitle.font = [UIFont systemFontOfSize:kAppAsiaFontSize(13)];
        currentPrice.textColor = [UIColor colorWithString:@"#C50C20"];
        currentPrice.font = [UIFont systemFontOfSize:kAppAsiaFontSize(11)];
        buyNow.backgroundColor = [UIColor colorWithString:@"#C50C20"];
        [buyNow setTitle:LaguageControl(@"立即抢购") forState:UIControlStateNormal];
        buyNow.titleLabel.font = [UIFont systemFontOfSize:14];
        buyNow.layer.cornerRadius = 4;
        [buyNow addTarget:self action:@selector(clickBuyNow) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:goodsTitle];
        [self.contentView addSubview:goodsImage];
        [self.contentView addSubview:currentPrice];
        [self.contentView addSubview:originalPrice];
        [self.contentView addSubview:buyNow];
        __weak typeof(self) weakSelf = self;
        [goodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScaleHeight(120), kScaleHeight(120)));
            make.top.equalTo(weakSelf.contentView.mas_top).mas_offset(kScaleHeight(10));
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).mas_offset(-kScaleHeight(10));
            make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(12));
//                make.width.equalTo(goodsImage.mas_height);
        }];
        [goodsTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(goodsImage.mas_right).mas_offset(kScaleWidth(10));
                make.top.equalTo(goodsImage.mas_top).mas_offset(0);
            make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(10));
        }];
        [currentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(goodsImage.mas_right).mas_offset(kScaleWidth(10));
            make.centerY.equalTo(weakSelf.contentView);
        }];
        [originalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(goodsImage.mas_right).mas_offset(kScaleWidth(10));
            make.top.equalTo(currentPrice.mas_bottom).mas_offset(kScaleHeight(3));
        }];
        [buyNow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(goodsImage.mas_right).mas_offset(kScaleWidth(10));
            make.size.mas_equalTo(CGSizeMake(kScaleWidth(80), kScaleHeight(30)));
            make.bottom.equalTo(goodsImage.mas_bottom).mas_offset(0);
        }];
    }
    return self;
}
- (void)clickBuyNow
{
    if([_delegate respondsToSelector:@selector(promotionGoodsCell:)])
    {
        [_delegate promotionGoodsCell:self];
    }
}
- (void)setModel:(PromotionGoodsModel *)model
{
    _model = model;
    goodsTitle.text = model.goods_name;
    [goodsImage sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
    currentPrice.text = [NSString stringWithFormat:@"￥ %.2f",model.ag_price];
    NSString * price = [NSString stringWithFormat:@"￥ %.2f",model.goods_price];
    originalPrice.attributedText = [self deleteLine:price];
    
}
/**
 *  添加删除线
 */
- (NSAttributedString *)deleteLine:(NSString *)string
{
    NSAttributedString * attrStr =
    [[NSAttributedString alloc]initWithString:string
                                   attributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:kAppAsiaFontSize(11)],
       NSForegroundColorAttributeName:[UIColor colorWithString:@"#808080"],
       NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
       NSStrikethroughColorAttributeName:[UIColor colorWithString:@"#808080"]}];
    return attrStr;
}
@end
