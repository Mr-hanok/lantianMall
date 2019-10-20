//
//  MineShopOperationCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/2.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineShopOperationCell.h"
@interface MineShopOperationCell ()<MineShopManagerItemDelegate>
@end
@implementation MineShopOperationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.title = [LaguageControl languageWithString:@"运营服务"];
        [self setup];
    }
    return self;
}
- (void)setup
{
    NSDictionary * operation = @{@"title":[LaguageControl languageWithString:@"模版设置" ],@"image":@"moban",@"type":@(1)};
    MineShopManagerItem * item = [[MineShopManagerItem alloc] initWithTitle:operation[@"title"] image:[UIImage imageNamed:operation[@"image"]]];
    item.type = [operation[@"type"] integerValue];
    item.delegate = self;
    [self.backView addSubview:item];
    __weak typeof(self) weakSelf = self;
    [item mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backView.mas_left).mas_offset(kScaleWidth(20));
        make.top.equalTo(weakSelf.line.mas_top).mas_offset(kScaleHeight(14));
        make.bottom.equalTo(weakSelf.backView.mas_bottom).mas_offset(-kScaleHeight(18));
        make.right.equalTo(weakSelf.backView.mas_centerX);
    }];
}
- (void)mineShopManagerItem:(MineShopManagerItem *)item
{
    if([_delegate respondsToSelector:@selector(mineShopOperationCell:type:)])
    {
        [_delegate mineShopOperationCell:self type:item.type];
    }
}
@end
