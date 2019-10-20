//
//  MineAssistSubView.m
//  test
//
//  Created by TheMacBook on 16/6/29.
//  Copyright © 2016年 TheMacBook. All rights reserved.
//

#import "MineAssistSubView.h"
@interface MineAssistSubView ()
{
    UILabel * _countLabel;
    UILabel * _titleLabel;
}
@end
@implementation MineAssistSubView

- (instancetype)initWithTitle:(NSString *)title
                        count:(NSInteger)count
{
    self = [super init];
    if(self)
    {
        __weak typeof(self) weakSelf = self;

        NSString * countStr = nil;
        if(count != -1)
        {
            countStr = [NSString stringWithFormat:@"%ld\n",(long)count];
        }
        _titleLabel = [[UILabel alloc] initWithText:[NSString stringWithFormat:@"%@%@",countStr?countStr:@"",title]];
            [self addSubview:_titleLabel];

            [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(weakSelf);
                
            }];
        _titleLabel.numberOfLines = 3;
      
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithMineStore:(NSString *)title
{
    self = [super init];
    if(self)
    {
        UILabel * accessLabel = [[UILabel alloc] initWithText:@">>"];
        _titleLabel = [[UILabel alloc] initWithText:title];
        _titleLabel.numberOfLines = 0;
        [self addSubview:accessLabel];
        [self addSubview:_titleLabel];
        __weak typeof(self) weakSelf = self;
        [accessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            make.right.equalTo(weakSelf.mas_right).mas_offset(-6);
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            make.right.lessThanOrEqualTo(accessLabel.mas_left).mas_offset(20);
            make.centerX.equalTo(weakSelf.mas_centerX).mas_offset(-kScaleWidth(6));
            make.left.greaterThanOrEqualTo(weakSelf.mas_left).mas_offset(20).priority(750);
        }];
        
    }
    return self;
}
- (void)loadAssistWithTitle:(NSString *)title
                      count:(NSInteger)count
{
    NSString * countStr = nil;
    if(count != -1)
    {
        countStr = [NSString stringWithFormat:@"%ld\n",(long)count];
    
        _titleLabel.text = [NSString stringWithFormat:@"%@%@",countStr?countStr:@"",[LaguageControl languageWithString:title]];
    }else
    {
        _titleLabel.text = [LaguageControl languageWithString:title];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if([_delegate respondsToSelector:@selector(mineAssistSubView:)])
    {
        [_delegate mineAssistSubView:self];
    }
}
@end
