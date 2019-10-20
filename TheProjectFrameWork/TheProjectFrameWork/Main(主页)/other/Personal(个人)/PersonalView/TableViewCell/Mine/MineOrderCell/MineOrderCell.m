//
//  MineOrderCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineOrderCell.h"
#import "OrderStatusView.h"
@interface MineOrderCell ()<OrderStatusViewDelegate>


@end


@implementation MineOrderCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setup];
    }
    return self;
}
- (void)setup
{
    NSArray * stautsArr = @[@{@"title":[LaguageControl languageWithString:@"待付款"],@"image":@"daifukuan"},@{@"title":[LaguageControl languageWithString:@"待收货"],@"image":@"daishouhuo"},@{@"title":[LaguageControl languageWithString:@"已收货"],@"image":@"yishouhuo"},@{@"title":[LaguageControl languageWithString:@"已取消"],@"image":@"yiquxiao"},@{@"title":[LaguageControl languageWithString:@"退款"],@"image":@"tuikuanIcon"}];
    __weak typeof(self) weakSelf = self;
    __block UIView * lastView = nil;
    [stautsArr enumerateObjectsUsingBlock:^(NSDictionary *  dic, NSUInteger idx, BOOL * _Nonnull stop) {
        OrderStatusView * view = [[OrderStatusView alloc] initWithText:dic[@"title"] image:[UIImage imageNamed:dic[@"image"]]];

        view.delegate = self;
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView.mas_top).mas_offset(kScaleHeight(8));
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).mas_offset(-kScaleHeight(8));
            if(lastView)
            {
                make.left.equalTo(lastView.mas_right);
                make.size.equalTo(lastView);
            }else
            {
                make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(15));
            }
        }];
        lastView = view;

    }];
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(15));
    }];
}
- (void)loadOrderStatus
{
    NSArray * stautsArr = @[@{@"title":[LaguageControl languageWithString:@"待付款"],@"image":@"daifukuan"},@{@"title":[LaguageControl languageWithString:@"待收货"],@"image":@"daishouhuo"},@{@"title":[LaguageControl languageWithString:@"已收货"],@"image":@"yishouhuo"},@{@"title":[LaguageControl languageWithString:@"已取消"],@"image":@"yiquxiao"},@{@"title":[LaguageControl languageWithString:@"退款"],@"image":@"tuikuanIcon"}];
    NSArray * subviews = self.contentView.subviews;
    [subviews enumerateObjectsUsingBlock:^(OrderStatusView *  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        view.text = stautsArr[idx][@"title"];
        view.image = [UIImage imageNamed:stautsArr[idx][@"image"]];
    }];
}
- (void)orderStatusWithType:(SellerOrderTypes)type
{
    if([_delegate respondsToSelector:@selector(mineOrderStatus:)])
    {
        [_delegate mineOrderStatus:type];
    }
}
- (void)buyerStatusWithType:(OrderTypes)type
{
    if([_delegate respondsToSelector:@selector(buyerOrderStatus:)])
    {
        [_delegate buyerOrderStatus:type];
    }
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor colorWithString:@"#cccccc120"]setStroke];
    CGContextSetLineWidth(ctx, 1);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, rect.size.height);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
    CGContextStrokePath(ctx);
}
@end
