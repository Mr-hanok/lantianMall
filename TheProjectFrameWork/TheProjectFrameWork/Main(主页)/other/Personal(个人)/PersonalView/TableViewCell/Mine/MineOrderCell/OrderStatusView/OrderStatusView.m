//
//  OrderStatusView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "OrderStatusView.h"
@interface OrderStatusView ()
{
    UIImageView * _imageview;
    UILabel * _titleLabel;
    UILabel *_countLabel;

}
@end
@implementation OrderStatusView
- (instancetype)initWithText:(NSString *)text
                       image:(UIImage *)image
{
    self = [super init];
    if(self)
    {
        _imageview = [[UIImageView alloc] initWithImage:image];
        _imageview.contentMode = UIViewContentModeCenter;
        _titleLabel = [[UILabel alloc] initWithText:text];
        _titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(10)];
        _titleLabel.textColor = [UIColor colorWithString:@"#333333"];
        [self setup];
     
    }
    return self;
}
- (void)setup
{
    
    [self addSubview:_imageview];
    [self addSubview:_titleLabel];
    __weak typeof(self) weakSelf = self;
    [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(weakSelf);
        make.top.equalTo(weakSelf.mas_top).mas_offset(kScaleHeight(5));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageview.mas_bottom).mas_offset(kScaleHeight(3));
        make.right.left.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-5);
    }];
    _countLabel = [[UILabel alloc]init];
    _countLabel.textColor = [UIColor whiteColor];
    _countLabel.backgroundColor = kNavigationColor;
    _countLabel.text = @"0";
    _countLabel.font = [UIFont systemFontOfSize:8.5];
    _countLabel.layer.cornerRadius = 7.f;
    _countLabel.layer.masksToBounds = YES;
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.hidden = YES;
    [self addSubview:_countLabel];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_imageview.mas_centerX).offset(8);
        make.centerY.equalTo(_imageview.mas_centerY).offset(-8);
        make.width.height.mas_equalTo(14);
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SellerOrderTypes type = SellerOrderTypesSuccess;
    if([_titleLabel.text isEqualToString:[LaguageControl languageWithString:@"待付款"]])
    {
        type = SellerOrderTypesToPay;
    }
    if([_titleLabel.text isEqualToString:[LaguageControl languageWithString:@"待发货"]])
    {
        type = SellerOrderTypesToSend;
    }
    if([_titleLabel.text isEqualToString:[LaguageControl languageWithString:@"待收货"]])
    {
        type = SellerOrderTypesToAccept;
    }
    if([_titleLabel.text isEqualToString:[LaguageControl languageWithString:@"已收货"]])
    {
        type = SellerOrderTypesToEvaluation;
    }
    if([_titleLabel.text isEqualToString:[LaguageControl languageWithString:@"已取消"]])
    {
        type = SellerOrderTypesCanCeled;
    }
    if([_titleLabel.text isEqualToString:[LaguageControl languageWithString:@"退款"]])
    {
        type = SellerOrderTypesRefund;
    }
    if([_titleLabel.text isEqualToString:[LaguageControl languageWithString:@"退款记录"]])
    {
        type = SellerOrderTypesRefundRecord;
    }
    if([_titleLabel.text isEqualToString:[LaguageControl languageWithString:@"已完成"]])
    {
        type = SellerOrderTypesSuccess;
    }
    if([_delegate respondsToSelector:@selector(orderStatusWithType:)])
    {
        [_delegate orderStatusWithType:type];
    }
    
    
    OrderTypes buyerType = OrderTypesScuccess;
    if([_titleLabel.text isEqualToString:LaguageControl(@"待付款")])
    {
        buyerType = OrderTypesToPayment;
    }
    if([_titleLabel.text isEqualToString:LaguageControl(@"待收货")])
    {
        buyerType = OrderTypesToAccePt;
    }
    if([_titleLabel.text isEqualToString:LaguageControl(@"已收货")])
    {
        buyerType = OrderTypesToEvaluation;
    }
    if([_titleLabel.text isEqualToString:LaguageControl(@"已取消")])
    {
        buyerType = OrderTypesCanCel;
    }
    if([_titleLabel.text isEqualToString:LaguageControl(@"退款")])
    {
        buyerType = OrderTypesRefund;
    }
    
    if([_delegate respondsToSelector:@selector(buyerStatusWithType:)])
    {
        [_delegate buyerStatusWithType:buyerType];
    }
}
- (void)setText:(NSString *)text
{
    _text = text;
    _titleLabel.text = text;
}
- (void)setImage:(UIImage *)image
{
    _image = image;
    _imageview.image = image;
}
-(void)setCountStr:(NSString *)countStr{
    _countStr = countStr;
    if ([countStr isEqualToString:@"0"]|| countStr == nil) {
        _countLabel.hidden = YES;
    }else{
        _countLabel.hidden = NO;
    }
    _countLabel.text = countStr;
}

@end
