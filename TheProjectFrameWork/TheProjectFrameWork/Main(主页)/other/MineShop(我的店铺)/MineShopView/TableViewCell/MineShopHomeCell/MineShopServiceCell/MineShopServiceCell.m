//
//  MineShopServiceCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/2.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineShopServiceCell.h"
@interface MineShopServiceCell ()<MineShopManagerItemDelegate>
@end
@implementation MineShopServiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.title = [LaguageControl languageWithString:@"客户服务"];
        [self setup];
    }
    return self;
}
- (void)setup
{
    NSArray * services = @[@{@"title":[LaguageControl languageWithString:@"退款管理"],@"image":@"tuikuan",@"type":@(1)},@{@"title":[LaguageControl languageWithString:@"投诉管理"],@"image":@"tousu",@"type":@(2)}];
    __weak typeof(self) weakSelf = self;
    __block UIView * lastView = nil;
    [services enumerateObjectsUsingBlock:^(NSDictionary * dic, NSUInteger idx, BOOL * _Nonnull stop) {
        MineShopManagerItem * item = [[MineShopManagerItem alloc] initWithTitle:dic[@"title"] image:[UIImage imageNamed:dic[@"image"]]];
        item.type = [dic[@"type"] integerValue];
        item.delegate = self;
        [self.backView addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.backView.mas_bottom).mas_offset(-kScaleHeight(18));
            make.top.equalTo(weakSelf.line.mas_top).mas_offset(kScaleHeight(14));
            if(idx)
            {
                make.size.equalTo(lastView);
                make.height.mas_lessThanOrEqualTo(kScaleHeight(25));
                make.right.equalTo(weakSelf.backView.mas_right).mas_offset(-kScaleWidth(20));
                make.left.equalTo(lastView.mas_right).mas_offset(kScaleWidth(30));
            }else
            {
                make.left.equalTo(weakSelf.backView.mas_left).mas_offset(kScaleWidth(20));
            }
        }];
        lastView = item;
    }];
}
- (void)mineShopManagerItem:(MineShopManagerItem *)item
{
    if ([_delegate respondsToSelector:@selector(mineShopServiceWithType:)])
    {
        [_delegate mineShopServiceWithType:item.type];
    }
}
@end
