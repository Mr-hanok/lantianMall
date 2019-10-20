//
//  MineAccountFooterView.m
//  TheProjectFrameWork
//
//  Created by ZengPengYuan on 16/7/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineAccountFooterView.h"
#import "LoginButton.h"

@implementation MineAccountFooterView

- (instancetype)initWithTitle:(NSString *)title
                  actionBlcok:(void (^)(id))block
{   self = [super init];
    if(self)
    {
        LoginButton * button = [[LoginButton alloc] initWithActionBlock:block title:title];
        [self addSubview:button];
        __weak __typeof__(self) weakSelf = self;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(12)).priority(750);
            make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(12)).priority(750);
           
        }];
        [button settingButtonSelectWithSelected:YES];
    }
    return self;
}

@end
