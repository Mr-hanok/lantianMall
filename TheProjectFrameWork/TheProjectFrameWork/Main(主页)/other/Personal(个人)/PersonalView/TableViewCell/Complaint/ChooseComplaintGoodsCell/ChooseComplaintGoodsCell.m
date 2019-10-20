//
//  ChooseComplaintGoodsCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ChooseComplaintGoodsCell.h"
#import "ComplaintsContentCell.h"
#import "OrderGoodsModel.h"
@interface ChooseComplaintGoodsCell ()
{
    PhotoView * _image; // 商品图片
    UIButton * _selectButton; // 选择按钮
    UILabel * _titleLabel; // 商品名称
    UILabel * _attributeLabel; // 属性
    UILabel * _priceLabel;  // 现在的价格
    UILabel * _costLabel; // 原价
    UILabel * _concessionsLabel; // 优惠
    UILabel * _numberLabel;
}
@end
@implementation ChooseComplaintGoodsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _image = [[PhotoView alloc] initWithImage:nil];
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleLabel = [[UILabel alloc] init];
        _attributeLabel = [[UILabel alloc] init];
        _costLabel = [[UILabel alloc] init];
        _concessionsLabel = [[UILabel alloc] init];
        _numberLabel = [[UILabel alloc] init];
        _priceLabel = [[UILabel alloc] init];
        _image.layer.cornerRadius = 3;
        [_selectButton setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
        [_selectButton setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
        _titleLabel.textColor = [UIColor colorWithString:@"#333333"];
        _titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        _titleLabel.numberOfLines = 2;
        _attributeLabel.textColor = [UIColor colorWithString:@"#848691"];
        _attributeLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(10)];
        _priceLabel.textColor = [UIColor colorWithString:@"#F22F33"];
        _priceLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(12)];
        _concessionsLabel.textColor = [UIColor colorWithString:@"#F22F33"];
        _concessionsLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(8)];
        _costLabel.textColor = [UIColor colorWithString:@"#9F9F9F"];
        _costLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(8)];
        _numberLabel.textColor = [UIColor colorWithString:@"#666666"];
        _numberLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(13)];
        [_selectButton addTarget:self action:@selector(clickGoods:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_image];
        [self.contentView addSubview:_selectButton];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_attributeLabel];
        [self.contentView addSubview:_priceLabel];
        [self.contentView addSubview:_numberLabel];
        [self.contentView addSubview:_costLabel];
        [self.contentView addSubview:_concessionsLabel];
        [self setup];
    }
    return self;
}
- (void)setup
{
    __weak typeof(self) weakSelf = self;
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(8));
        make.centerY.equalTo(weakSelf.contentView);
        make.width.mas_equalTo(kScaleWidth(20));
    }];
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScaleWidth(95), kScaleWidth(95)));
        make.top.equalTo(weakSelf.contentView.mas_top).mas_offset(kScaleHeight(10));
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).mas_offset(-kScaleHeight(10));
        make.left.equalTo(_selectButton.mas_right).mas_offset(kScaleWidth(6));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_image.mas_top);
        make.left.equalTo(_image.mas_right).mas_offset(kScaleWidth(6));
        make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(30));
    }];
    [_attributeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_image.mas_right).mas_offset(kScaleWidth(6));
        make.centerY.equalTo(weakSelf.contentView.mas_centerY).mas_offset(kScaleHeight(3));
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_image.mas_right).mas_offset(kScaleWidth(6));
        make.bottom.equalTo(_image.mas_bottom);
    }];
    [_costLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(_image.mas_bottom);
//        make.left.equalTo(_image.mas_right).mas_offset(kScaleWidth(6));
        
        make.left.equalTo(_image.mas_right).mas_offset(kScaleWidth(6));
        make.bottom.equalTo(_costLabel.mas_top).mas_offset(-kScaleHeight(6));

    }];
    [_concessionsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_costLabel);
        make.left.equalTo(_costLabel.mas_right).mas_offset(3);
    }];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_image.mas_bottom);
        make.right.equalTo(_titleLabel.mas_right);
    }];
}
- (NSAttributedString *)deleteLineWithString:(NSString *)string
{
    NSAttributedString * attrStr =
    [[NSAttributedString alloc]initWithString:string
                                  attributes:
  @{NSFontAttributeName:[UIFont systemFontOfSize:kAppAsiaFontSize(8.f)],
    NSForegroundColorAttributeName:[UIColor colorWithString:@"#9F9F9F"],
    NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
    NSStrikethroughColorAttributeName:[UIColor colorWithString:@"#9F9F9F"]}];
    return attrStr;
}
- (void)clickGoods:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.goodsSelected = sender.selected;
}

- (void)setGoodsSelected:(BOOL)goodsSelected
{
    _goodsSelected = goodsSelected;
    if([_delegate respondsToSelector:@selector(chooseComplaintGoodsCell:)])
    {
        [_delegate chooseComplaintGoodsCell:self];
    }
}
- (void)setModel:(OrderGoodsModel *)model
{
    _model = model;
    _titleLabel.text = model.goodsName;
    _attributeLabel.text = model.specInfo;
//    _costLabel.attributedText = [self deleteLineWithString:[NSString stringWithFormat:@"￥ %@",model.storePrice]];
    _priceLabel.text = [NSString stringWithFormat:@"￥ %@",model.gcPrice];
//    _concessionsLabel.text = @"-48%";
    _image.image = [UIImage imageNamed:@"defaultImgForGoods"];
    _numberLabel.text = [NSString stringWithFormat:@"x %@",model.count];
    [NetWork loadImageWithUrl:model.goodsMainPhotos ImageDownloaderProgressBlock:nil ImageCompletionWithFinishedBlock:^(UIImage *image, NSError *error, BOOL finished, NSURL *imageURL) {
        if(image)
        {
            _image.image = image;
        }
    }];
}

@end
