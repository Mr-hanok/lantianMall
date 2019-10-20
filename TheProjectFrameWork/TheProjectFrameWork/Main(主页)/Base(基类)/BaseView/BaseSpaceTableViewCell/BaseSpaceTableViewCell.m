//
//  BaseSpaceTableViewCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseSpaceTableViewCell.h"

@implementation BaseSpaceTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        BackGroundView * back = [[BackGroundView alloc] init];
        [self.contentView addSubview:back];
        __weak typeof(self) weakSelf = self;
        [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.left.equalTo(weakSelf.contentView);
            make.top.equalTo(weakSelf.contentView.mas_top).mas_offset(kScaleWidth(10));
        }];
        _backView = back;
    }
    return self;
}

@end
@implementation BackGroundView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    
    if(!_separator)
    {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor colorWithString:@"#CCCCCC120"] setStroke];
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
}
@end


