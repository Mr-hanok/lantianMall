//
//  NewPayAttentGoodsTableViewCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/10/19.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "NewPayAttentGoodsTableViewCell.h"
#import "AttentGoodsModel.h"
#import "StarView.h"

@implementation NewPayAttentGoodsTableViewCell
{
    UIImageView * _goodsImage;
    UILabel * _goodsName;
    UILabel * _goodsPrice;
    UILabel * _goodsStorePrice;
    StarView * _levelView;
    UIButton * _joinCart;
    UIButton * _shareButton;
    UIButton * _deleteButton;

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
       [self setep];
    }
    return self;
}
- (void)setep
{
    self.backView.separator = YES;
    UIView * backView = [UIView new];
    _goodsImage = [[UIImageView alloc] init];
    _goodsName = [[UILabel alloc] init];
    _goodsPrice = [[UILabel alloc] init];
    _goodsStorePrice = [[UILabel alloc] init];
    _levelView = [StarView new];
    _joinCart = [UIButton buttonWithType:UIButtonTypeCustom];
    _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _goodsName.font = [UIFont systemFontOfSize:kAppAsiaFontSize(11)];
    _goodsName.textColor = [UIColor colorWithString:@"#666666"];
    _goodsName.numberOfLines = 2;
    _goodsPrice.textColor = [UIColor colorWithString:@"#C50C20"];
    _goodsPrice.font = [UIFont systemFontOfSize:kAppAsiaFontSize(10)];
    _joinCart.backgroundColor = [UIColor colorWithString:@"#C90C1E"];
    _joinCart.titleLabel.font = [UIFont systemFontOfSize:kScaleWidth(14)];
    _joinCart.layer.cornerRadius = 3;
    [_joinCart setTitle:LaguageControl(@"加入购物车") forState:UIControlStateNormal];
    [_shareButton setBackgroundImage:[UIImage imageNamed:@"spxq_fengxiang"] forState:UIControlStateNormal];
    [_deleteButton setBackgroundImage:[UIImage imageNamed:@"ic_delete_shopcar"] forState:UIControlStateNormal];
    backView.backgroundColor = [UIColor clearColor];
    backView.layer.borderColor = [UIColor colorWithString:@"#CCCCCC"].CGColor;
    backView.layer.borderWidth = 1;
    
    _levelView.fullImage = [UIImage imageNamed:@"xingliang"];
    _levelView.backImage = [UIImage imageNamed:@"xinghui"];
    _levelView.show_star = 4;
    _levelView.backgroundColor = [UIColor clearColor];
    
    [self.backView addSubview:backView];
    [self.backView addSubview:_goodsImage];
    [self.backView addSubview:_goodsName];
    [self.backView addSubview:_goodsPrice];
    [self.backView addSubview:_goodsStorePrice];
    [self.backView addSubview:_levelView];
    [self.backView addSubview:_joinCart];
    [self.backView addSubview:_shareButton];
    [self.backView addSubview:_deleteButton];
    _joinCart.hidden = YES;
    
    __weak typeof(self.backView) weakSelf = self.backView;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf);
        make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(8));
        make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(8));
    }];
    [_goodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo((CGSize){kScaleWidth(125),kScaleWidth(125)});
    make.left.equalTo(backView.mas_left).mas_offset(kScaleWidth(10));
        make.centerY.equalTo(weakSelf);
    make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-kScaleWidth(10));
    make.top.equalTo(weakSelf.mas_top).mas_offset(kScaleWidth(10));

    }];
    [_goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(_goodsImage.mas_right).mas_offset(kScaleWidth(8));
//        make.top.equalTo(weakSelf.mas_top).mas_offset(kScaleWidth(10));
        make.top.equalTo(_goodsImage.mas_top);
//        make.height.mas_equalTo(kScaleHeight(25));
      make.right.equalTo(backView.mas_right).mas_offset(-kScaleWidth(10));
//        make.width.mas_lessThanOrEqualTo(200);
        make.height.mas_greaterThanOrEqualTo(20);


    }];
    [_goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsName.mas_left);
    make.top.equalTo(_goodsName.mas_bottom).mas_offset(kScaleWidth(8));
//        make.height.mas_lessThanOrEqualTo(35);
        make.width.mas_lessThanOrEqualTo(200);
        make.height.mas_greaterThanOrEqualTo(20);

    }];
    [_goodsStorePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsName.mas_left);
        make.top.equalTo(_goodsPrice.mas_bottom).mas_offset(kScaleWidth(8));
//        make.height.mas_lessThanOrEqualTo(35);
        make.width.mas_lessThanOrEqualTo(200);
        make.height.mas_greaterThanOrEqualTo(20);

    }];
    [_levelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsName.mas_left);
        make.top.equalTo(_goodsStorePrice.mas_bottom).mas_offset(kScaleHeight(8));
        make.size.mas_equalTo((CGSize){kScaleWidth(100),kScaleWidth(15)});
    }];
    [_joinCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsName.mas_left);
        make.top.equalTo(_levelView.mas_bottom).mas_offset(kScaleWidth(8));
        make.size.mas_equalTo((CGSize){kScaleWidth(90),kScaleWidth(30)});
//        make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-kScaleWidth(10));
        make.bottom.equalTo(_goodsImage.mas_bottom);
    }];
    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_joinCart.mas_right).mas_offset(kScaleWidth(10));
//        make.top.bottom.equalTo(_joinCart);
        make.size.mas_equalTo((CGSize){18,18});
        make.centerY.equalTo(_joinCart);

    }];
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView.mas_right).mas_offset(-kScaleWidth(10));
//        make.top.bottom.equalTo(_joinCart);
        make.centerY.equalTo(_joinCart);
        make.size.mas_equalTo((CGSize){18,18});

    }];
    
    _levelView.alpha = kIsChiHuoApp ? 0 : 1;
    [_shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [_deleteButton addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    [_joinCart addTarget:self action:@selector(addToCart) forControlEvents:UIControlEventTouchUpInside];
}

- (void)share
{
    if([_delegate respondsToSelector:@selector(payAttentGoodsShareWithCell:)])
    {
        [_delegate payAttentGoodsShareWithCell:self];
    }
}
- (void)delete
{
    if([_delegate respondsToSelector:@selector(payAttentGoodsDeleteWithCell:)])
    {
        [_delegate payAttentGoodsDeleteWithCell:self];
    }
}
- (void)addToCart
{
    if([_delegate respondsToSelector:@selector(payAttentGoodsAddCartWithCell:)])
    {
        [_delegate payAttentGoodsAddCartWithCell:self];
    }
}

- (void)setModel:(AttentGoodsModel *)model
{
    _model = model;
    _goodsName.text = model.attentgoods_name;
    NSString * thePrice = model.attentstore_price;

    _goodsPrice.text = [NSString stringWithFormat:@"￥ %@", [thePrice caculateFloatValue]];
    NSString * price = [NSString stringWithFormat:@"￥ %@", [model.attentgoods_price caculateFloatValue]];
    if (model.attentgoods_price.length)
    {
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:price];
        [AttributedStr addAttribute:NSStrikethroughStyleAttributeName
                                      value:[NSNumber numberWithInteger:1]
                                      range:NSMakeRange(0,AttributedStr.length)];
        [AttributedStr addAttribute:NSStrokeColorAttributeName
                              value:[UIColor colorWithString:@"#808080"]
                              range:NSMakeRange(0,AttributedStr.length)];
        [AttributedStr addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:kAppAsiaFontSize(10)]
                              range:NSMakeRange(0,AttributedStr.length)];
        NSString * str = [NSString caculater:thePrice goodValue:model.attentgoods_price];
        NSMutableAttributedString *appendString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@",str]];
        [appendString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithString:@"#C50C20"] range:NSMakeRange(0, appendString.length)];
        [appendString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kAppAsiaFontSize(10)] range:NSMakeRange(0, appendString.length)];
//        [AttributedStr appendAttributedString:appendString];
        if ([thePrice floatValue]!=[model.attentgoods_price floatValue]) {
            _goodsStorePrice.attributedText = AttributedStr;
            
        }
        else{
            _goodsStorePrice.attributedText = [NSAttributedString new];
        }
    }
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:model.attentgoods_main_photo] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
    [_levelView Setwidtt:15 minWidth:5 showStar:[model.attentgoodsdescription_evaluate floatValue]];
    [self layoutIfNeeded];
    [self setNeedsDisplay];
}

@end
