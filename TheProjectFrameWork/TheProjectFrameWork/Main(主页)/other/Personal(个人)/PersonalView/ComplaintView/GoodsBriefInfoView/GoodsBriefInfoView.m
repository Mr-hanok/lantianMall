//
//  GoodsBriefInfoView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "GoodsBriefInfoView.h"
#import "ComplaintDetailedModel.h"
#import "OrderGoodsModel.h"
@interface GoodsBriefInfoView ()<UITextViewDelegate>
{
    UILabel * _titleLabel;
    UILabel * _valueLabel;
    UILabel * _countLabel;
    UIImageView * _icon;
    UITextView * _describeTextField;
    UILabel * _describe;
}
@end
@implementation GoodsBriefInfoView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _titleLabel = [[UILabel alloc] initWithText:nil];
        _icon = [[UIImageView alloc] initWithImage:nil];
        _valueLabel = [[UILabel alloc] initWithText:nil];
        _countLabel = [[UILabel alloc] initWithText:nil];
        _describeTextField = [[UITextView alloc] init];
       
        _describe = [[UILabel alloc] initWithText:LaguageControlAppend(@"问题描述")];
        
        [self addSubview:_titleLabel];
        [self addSubview:_icon];
        [self addSubview:_valueLabel];
        [self addSubview:_countLabel];
        [self addSubview:_describeTextField];
        [self addSubview:_describe];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickGoods)];
        [_icon addGestureRecognizer:tap];
        _icon.userInteractionEnabled = YES;
        // 问题描述
        
        [self setup];
    }
    return self;
}
- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    _icon.layer.borderWidth = 0.5f;
    _icon.layer.borderColor = [UIColor colorWithString:@"#cccccc"].CGColor;
    _titleLabel.numberOfLines = 2;
    _titleLabel.textColor = [UIColor colorWithString:@"#333333"];
    _valueLabel.textColor = [UIColor colorWithString:@"#808080"];
    _countLabel.textColor = _valueLabel.textColor;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _describe.textColor = [UIColor colorWithString:@"#808080"];
    _describeTextField.font = [UIFont systemFontOfSize:kAppAsiaFontSize(12)];
    _describeTextField.backgroundColor = [UIColor clearColor];
    _describeTextField.delegate = self;
    _describeTextField.font = [UIFont systemFontOfSize:kAppAsiaFontSize(12)];
    _describeTextField.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    __weak typeof(self) weakSelf = self;
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.top.equalTo(weakSelf.mas_top).mas_offset(kScaleHeight(8));
        make.height.mas_offset(kScaleHeight(80));
        make.width.equalTo(_icon.mas_height);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_icon.mas_top);
        make.left.equalTo(_icon.mas_right).mas_offset(kScaleWidth(5));
        make.right.equalTo(weakSelf.mas_right);
    }];
    [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_icon.mas_bottom);
        make.left.equalTo(_icon.mas_right).mas_offset(kScaleWidth(5));
    }];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_valueLabel.mas_bottom);
        make.left.equalTo(_valueLabel.mas_right).mas_offset(kScaleWidth(8));
    }];
    [_describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.top.equalTo(_describeTextField.mas_top);
    }];
    [_describeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_describe.mas_right).mas_offset(kScaleWidth(8));
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(kScaleHeight(44));
        make.top.equalTo(_countLabel.mas_bottom).mas_offset(kScaleHeight(5));
        make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-kScaleHeight(8));
    }];
    _describeTextField.layer.borderWidth = 0.5f;
    _describeTextField.layer.borderColor = [UIColor colorWithString:@"#cccccc"].CGColor;
    _describeTextField.layer.cornerRadius = 2.f;
    [_describeTextField.layer setMasksToBounds:YES];
}
- (void)setEdit:(BOOL)edit
{
    _edit = edit;
    _describeTextField.userInteractionEnabled = edit;
}
- (void)textFieldChangText
{
    _contentString = [NSString stringWithFormat:@"%@_%@",_model.goods_id,_describeTextField.text];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChangText) name:UITextViewTextDidChangeNotification object:nil];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)clickGoods
{
    if(_delegate && [_delegate respondsToSelector:@selector(goodsBriefInfoClick:good_id:)])
    {
        NSString * good_id = nil;
        
        if(self.model.goods_id)
        {
            good_id = self.model.goods_id;
        }else
        {
            good_id = [NSString stringWithFormat:@"%ld",(long)self.complaint.goodsID];
            
        }
        [_delegate goodsBriefInfoClick:self good_id:good_id];
    }
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor colorWithString:@"#CCCCCC"] setStroke];
    CGContextSetLineWidth(ctx, 1);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, rect.size.width, 0);
    CGContextStrokePath(ctx);
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, rect.size.height);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
    CGContextStrokePath(ctx);
}
- (void)setModel:(OrderGoodsModel *)model
{
    _model = model;
   _titleLabel.text = model.goodsName;
   _countLabel.text = [NSString stringWithFormat:@"%@: %@",LaguageControl(@"数量"),model.count];
    _valueLabel.text = [NSString stringWithFormat:@"￥ %@",model.gcPrice];
    [_icon sd_setImageWithURL:[NSURL URLWithString:model.goodsMainPhotos] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
}
- (void)setComplaint:(ComplaintGoods *)complaint
{
    _complaint = complaint;
    _titleLabel.text = complaint.goods_name;
    _countLabel.text = [NSString stringWithFormat:@"%@: %ld",LaguageControl(@"数量"),(long)complaint.count];
    _valueLabel.text = [NSString stringWithFormat:@"￥ %.2f",complaint.goods_price];
    _describeTextField.text = complaint.desc;
    [_icon sd_setImageWithURL:[NSURL URLWithString:complaint.path] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
}
- (NSString *)contentString
{
    if(!_contentString || _contentString.length == 0)
    {
        _contentString = [NSString stringWithFormat:@"%@_",_model.goods_id];
    }
    return _contentString;
}
@end

