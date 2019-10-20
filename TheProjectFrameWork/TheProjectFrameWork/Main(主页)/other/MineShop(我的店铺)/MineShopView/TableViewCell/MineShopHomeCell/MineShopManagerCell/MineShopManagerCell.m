//
//  MineShopManagerCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineShopManagerCell.h"
#import "MineShopBaseCell.h"
@interface MineShopManagerCell ()<MineShopManagerItemDelegate>
@end
@implementation MineShopManagerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.title = [LaguageControl languageWithString:@"商品管理"];

        [self setup];
    }
    return self;
}
- (void)setup
{
    NSArray * managers = @[@{@"title":[LaguageControl languageWithString:@"出售中的商品"],@"image":@"chushou",@"type":@(1)},@{@"title":[LaguageControl languageWithString:@"仓库中的商品"],@"image":@"cangku",@"type":@(2)},@{@"title":[LaguageControl languageWithString:@"违规下架商品"],@"image":@"weizhang",@"type":@(3)},@{@"title":[LaguageControl languageWithString:@"品牌申请"],@"image":@"pingpei",@"type":@(4)}];
    __weak typeof(self) weakSelf = self;
    __block UIView * lastView = nil;
    [managers enumerateObjectsUsingBlock:^(NSDictionary * dic, NSUInteger idx, BOOL * _Nonnull stop) {
        MineShopManagerItem * item = [[MineShopManagerItem alloc] initWithTitle:dic[@"title"] image:[UIImage imageNamed:dic[@"image"]]];
        item.type = [dic[@"type"] integerValue];
        item.delegate = self;
        [self.backView addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if(lastView)
            {
                make.size.equalTo(lastView);
                make.height.mas_lessThanOrEqualTo(kScaleHeight(25));
                if(idx % 2 == 1)
                {
                    make.right.equalTo(weakSelf.backView.mas_right).mas_offset(-kScaleWidth(20));
                    make.left.equalTo(lastView.mas_right).mas_offset(kScaleWidth(30));
                    make.top.equalTo(lastView.mas_top);
                }else
                {
                    make.top.equalTo(lastView.mas_bottom).mas_offset(kScaleHeight(10));
                    make.left.equalTo(weakSelf.backView.mas_left).mas_offset(kScaleWidth(20));
                }
            }else{
                make.top.equalTo(weakSelf.line.mas_top).mas_offset(kScaleHeight(14));
                make.left.equalTo(weakSelf.backView.mas_left).mas_offset(kScaleWidth(20));
            }
        }];
        lastView = item;
    }];
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.backView.mas_bottom).mas_offset(-kScaleHeight(18));
    }];
}
- (void)mineShopManagerItem:(MineShopManagerItem *)item
{
    if([_delegate respondsToSelector:@selector(mineShopManagerWithType:)])
    {
        [_delegate mineShopManagerWithType:item.type];
    }
}
@end



