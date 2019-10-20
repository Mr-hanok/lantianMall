//
//  DialogueRecordView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "DialogueRecordView.h"

@implementation DialogueRecordView

@end


@implementation DialogueItem
{
    UILabel * _info;
    UILabel * _content;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _info = [[UILabel alloc] init];
        _content = [[UILabel alloc] init];
        _info.textColor = [UIColor colorWithString:@"#666666"];
        _info.font = [UIFont systemFontOfSize:kAppAsiaFontSize(11)];
        _content.font = [UIFont systemFontOfSize:kAppAsiaFontSize(12)];
        _info.numberOfLines = 1;
        _content.numberOfLines = 0;
        [self.contentView addSubview:_info];
        [self.contentView addSubview:_content];
        __weak typeof(self) weakSelf = self;
        [_info mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView.mas_top).mas_offset(kScaleHeight(3));
            make.left.equalTo(weakSelf.contentView.mas_left);
        }];
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_info.mas_bottom).mas_offset(kScaleHeight(5));
            make.left.equalTo(_info.mas_left);
            make.right.equalTo(weakSelf.mas_right);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).mas_offset(-kScaleHeight(5));
        }];
        _content.textColor = [UIColor colorWithString:@"#FF0000"];
        _info.text = @"投诉人[侯兴林] 2016-07-27 11:39:43";
        _content.text = @"东西一用就坏了。我才用了一次啊这拖鞋，老板你快给我换货，我就喜欢你们这拖鞋";
    }
    return self;
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    _info.text = title;
}
- (void)setContentStr:(NSString *)contentStr
{
    _contentStr = contentStr;
    _content.text = contentStr;
}
@end


@implementation DialogueHandleView
{
    UIButton * _submit;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        UIButton * publish = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton * reload = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton * submit = [UIButton buttonWithType:UIButtonTypeCustom];
        [self settingButton:publish];
        [self settingButton:reload];
        [self settingButton:submit];
        [publish addTarget:self action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
        [reload addTarget:self action:@selector(clickReload) forControlEvents:UIControlEventTouchUpInside];
        [submit addTarget:self action:@selector(clickSubmit) forControlEvents:UIControlEventTouchUpInside];
        __weak typeof(self) weakSelf = self;
        [publish mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kScaleHeight(30));
            make.top.equalTo(weakSelf.mas_top).mas_offset(kScaleHeight(10));
            make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-kScaleHeight(10));
            make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(10));
        }];
        [reload mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(publish);
            make.center.equalTo(weakSelf);
            make.left.equalTo(publish.mas_right).mas_offset(kScaleWidth(40));
        }];
        [submit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(publish);
            make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(10));
            make.left.equalTo(reload.mas_right).mas_offset(kScaleWidth(40));
            make.top.bottom.equalTo(publish);
        }];
        [publish setTitle:[LaguageControl languageWithString:@"发布对话"] forState:UIControlStateNormal];
        [reload setTitle:[LaguageControl languageWithString:@"刷新对话"] forState:UIControlStateNormal];
        [submit setTitle:[LaguageControl languageWithString:@"提交仲裁"] forState:UIControlStateNormal];
        _submit = submit;
    }
    return self;
}
- (void)settingButton:(UIButton *)sender
{
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(10)];
    sender.backgroundColor = [UIColor colorWithString:@"#DB7405"];
    sender.layer.cornerRadius = 1;
    [self addSubview:sender];
}
- (void)clickPublish
{
    if ([_delegate respondsToSelector:@selector(DialogueHandlePublish)]) {
       [_delegate DialogueHandlePublish];
    }
}
- (void)clickReload
{
    if ([_delegate respondsToSelector:@selector(DialogueHandleReload)]) {
        [_delegate DialogueHandleReload];
    }
}
- (void)clickSubmit
{
    if ([_delegate respondsToSelector:@selector(DialogueHandleSubmit)]) {
        [_delegate DialogueHandleSubmit];
    }
}
- (void)setWaitingArbitration:(BOOL)waitingArbitration
{
    _waitingArbitration = waitingArbitration;
    _submit.userInteractionEnabled = !waitingArbitration;

    if(waitingArbitration)
    {
        _submit.alpha = 0.4f;
    }else
    {
        _submit.alpha = 1;
    }
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor colorWithString:@"#cccccc120"] setStroke];
    CGContextSetLineWidth(ctx, 0.5f);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 5, 0);
    CGContextAddLineToPoint(ctx, rect.size.width-5, 0);
    CGContextStrokePath(ctx);
}
@end
