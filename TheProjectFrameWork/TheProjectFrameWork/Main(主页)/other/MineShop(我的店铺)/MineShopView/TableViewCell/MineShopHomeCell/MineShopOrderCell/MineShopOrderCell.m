//
//  MineShopOrderCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineShopOrderCell.h"
#import "OrderStatusView.h"
@interface MineShopOrderCell ()<UIScrollViewDelegate,OrderStatusViewDelegate>
{
    UIScrollView * _orders;
    UIImageView * shadow;
    UIButton * sender;
    NSInteger count;
}
@property (nonatomic , assign) NSInteger offsetX;

@end
@implementation MineShopOrderCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        count = 0;
        _orders = [[UIScrollView alloc] init];
        _orders.delegate = self;
        _orders.bounces = NO;
//        _orders.pagingEnabled = YES;
        shadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zuohuabeijing"]];
        [self.contentView addSubview:_orders];
        [self setup];
    }
    return self;
}
- (void)setup
{
    sender = [UIButton buttonWithType:UIButtonTypeCustom];
    [sender addTarget:self action:@selector(scrollOffsetWithButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:sender];
    [self.contentView addSubview:shadow];
    __weak typeof(self) weakSelf = self;
    [sender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(weakSelf.contentView);
        make.width.mas_equalTo(kScaleWidth(25));
    }];
    [_orders mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(weakSelf.contentView);
        make.left.equalTo(sender.mas_right).mas_offset(kScaleHeight(5));
        make.height.mas_equalTo(kScaleHeight(60)).priority(750);
    }];
    [shadow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf.contentView);
        make.left.equalTo(sender.mas_right);
        make.right.equalTo(_orders.mas_left);
    }];
    NSArray * stautsArr = @[@{@"title":[LaguageControl languageWithString:@"待付款"],@"image":@"daifukuan"},@{@"title":[LaguageControl languageWithString:@"待发货"],@"image":@"daifanhuo"},@{@"title":[LaguageControl languageWithString:@"待收货"],@"image":@"daishouhuo"},@{@"title":[LaguageControl languageWithString:@"已收货"],@"image":@"yishouhuo"},@{@"title":[LaguageControl languageWithString:@"已取消"],@"image":@"yiquxiao"},@{@"title":[LaguageControl languageWithString:@"已完成"],@"image":@"yiwancheng"},@{@"title":[LaguageControl languageWithString:@"退款"],@"image":@"tuikuanIcon"},@{@"title":[LaguageControl languageWithString:@"退款记录"],@"image":@"tuikuanjilu"}];
    __block UIView * lastView = nil;
    __weak typeof(_orders) wView = _orders;
    CGFloat spacing = ([LaguageControl shareControl].type == LanguageTypesChinese)? 25: 10;
    [stautsArr enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
        OrderStatusView * item = [[OrderStatusView alloc] initWithText:dic[@"title"] image:[UIImage imageNamed:dic[@"image"]]];
        item.delegate = self;
        [_orders addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(wView);
            if(lastView)
            {
                make.left.greaterThanOrEqualTo(lastView.mas_right).mas_offset(kScaleWidth(spacing));
                make.width.equalTo(lastView.mas_width);
            }else
            {
                make.left.equalTo(wView.mas_left).mas_offset(kScaleWidth(spacing));
            }
        }];
        lastView = item;
    }];
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wView.mas_right).mas_offset(-kScaleWidth(spacing));
    }];
    [sender setImage:[UIImage imageNamed:@"zuohuajiantou"] forState:UIControlStateNormal];
    [sender setImage:[UIImage imageNamed:@"huandoujiantou"] forState:UIControlStateSelected];
}
- (void)scrollOffsetWithButton:(UIButton *)button
{
    button.selected = !button.selected;
    button.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.25f animations:^{
        _orders.contentOffset = (CGPoint){(button.selected?self.offsetX:-self.offsetX), 0};
    } completion:^(BOOL finished) {
        button.userInteractionEnabled = finished;
    }];
}
- (void)orderStatusWithType:(SellerOrderTypes)type
{
    if([_delegate respondsToSelector:@selector(mineShopOrderWithType:)])
    {
        [_delegate mineShopOrderWithType:type];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.offsetX == 0)
    {
        sender.selected = YES;
    }else if(_orders.contentSize.width - _orders.frame.size.width == self.offsetX)
    {
        sender.selected = NO;
    }
}
- (NSInteger)offsetX
{
    if(count == 0)
    {
        [_orders layoutIfNeeded];
        count ++;
    }
        _offsetX = _orders.contentSize.width - _orders.frame.size.width;
        _offsetX -= _orders.contentOffset.x;
    
    return _offsetX;
}
@end
